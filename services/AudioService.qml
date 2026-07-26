pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNodeAudio audio: sink?.audio ?? null

    PwObjectTracker {
        id: sinkTracker
        objects: [root.sink]
    }

    readonly property int volume: Math.round((audio?.volume ?? 0) * 100)
    readonly property bool muted: audio?.muted ?? false
    readonly property bool silent: volume == 0 || muted

    readonly property string sinkName: sink?.description || sink?.nickname || sink?.name || "Unknown"

    function setVolume(vol: real): void {
        if (!audio) return;
        audio.volume = vol / 100;
    }
}