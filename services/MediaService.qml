pragma ComponentBehavior: Bound
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root

    readonly property list<MprisPlayer> players: Mpris.players.values
    readonly property list<MprisPlayer> activePlayers: players.filter((p) => p.playbackState == MprisPlaybackState.Playing)

    property MprisPlayer lastActivePlayer: null
    property MprisPlayer activePlayer: lastActivePlayer ?? players[0] ?? null

    Instantiator {
        model: root.players

        delegate: Item {
            id: playerItem

            required property MprisPlayer modelData
            
            Connections {
                target: playerItem.modelData
                ignoreUnknownSignals: true

                function onPlaybackStateChanged(): void {
                    if (playerItem.modelData.playbackState == MprisPlaybackState.Playing) {
                        root.lastActivePlayer = playerItem.modelData
                    }
                }
            }

            Component.onDestruction: {
                if (root.lastActivePlayer == playerItem.modelData) root.lastActivePlayer = null;
            }
        }
    }

    Component.onCompleted: lastActivePlayer = activePlayers[0] ?? null

    function isPlaying(player: MprisPlayer): bool {
        return player?.playbackState == MprisPlaybackState.Playing;
    }

    function getProgress(player: MprisPlayer): real {
        return (player?.position ?? 0) / (player?.length ?? 1);
    }

    readonly property real activePlayerProgress: getProgress(activePlayer)

    function togglePause(player: MprisPlayer): void {
        if (!player) return;
        player.playbackState == MprisPlaybackState.Playing ? player.pause() : player.play();
    }
}