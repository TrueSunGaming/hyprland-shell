pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Services.Mpris
import "../../../components/containers"
import "../../../components/text"
import "../../../services"

Control {
    id: root

    padding: 4

    contentItem: Control {
        padding: 4

        contentItem: RowLayout {
            spacing: 4

            RowLayout {
                Layout.margins: 2
                spacing: 0

                MediaButton {
                    text: ""
                    buttonEnabled: MediaService.activePlayer?.canGoPrevious ?? false
                    onTapped: MediaService.activePlayer?.previous()
                }

                MediaButton {
                    readonly property bool playing: MediaService.isPlaying(MediaService.activePlayer)

                    text: playing ? "" : ""
                    buttonEnabled: (playing ? MediaService.activePlayer?.canPause : MediaService.activePlayer?.canPlay) ?? false
                    onTapped: MediaService.togglePauseActivePlayer()
                }

                MediaButton {
                    text: ""
                    buttonEnabled: MediaService.activePlayer?.canGoNext ?? false
                    onTapped: MediaService.activePlayer?.next()
                }
            }

            GoldenColumn {
                Layout.preferredWidth: 150
                Layout.fillHeight: true

                topComponent: HScrollText {
                    text: (MediaService.activePlayer?.trackTitle ?? "No active player") || "Unknown Title"
                }

                bottomComponent: VFitText {
                    text: (MediaService.activePlayer?.trackArtist ?? "-") || "Unknown Artist"
                }
            }
        }

        background: BlurImageBackground {
            id: bg
            image.source: Qt.resolvedUrl(MediaService.activePlayer?.trackArtUrl ?? "")

            BottomBar {
                barColor: Qt.alpha(ThemeService.textColor, 0.3)
                maskWidth: parent.width
            }

            BottomBar {
                barColor: ThemeService.textColor
                maskWidth: parent.width * MediaService.getProgress(MediaService.activePlayer)

                FrameAnimation {
                    running: MediaService.isPlaying(MediaService.activePlayer)
                    onTriggered: MediaService.activePlayer?.positionChanged()
                }
            }
        }
    }

    component MediaButton: Control {
        id: buttonRoot

        property bool buttonEnabled: true

        property string text
        property alias textItem: textItem

        Layout.fillHeight: true
        Layout.preferredWidth: height
        padding: 4

        signal tapped

        contentItem: VFitText {
            id: textItem

            updateParentLayout: false
            text: buttonRoot.text
            horizontalAlignment: Text.AlignHCenter
        }

        background: Rectangle {
            color: "#20ffffff"
            radius: 8

            visible: buttonRoot.buttonEnabled && hoverHandler.hovered
        }

        HoverHandler {
            id: hoverHandler
            cursorShape: buttonRoot.buttonEnabled ? Qt.PointingHandCursor : Qt.ArrowCursor
        }

        TapHandler {
            onTapped: {
                if (buttonRoot.buttonEnabled)
                    buttonRoot.tapped();
            }
        }
    }

    component BottomBar: Item {
        id: bottomBarRoot

        required property color barColor
        required property real maskWidth

        anchors.fill: parent

        Rectangle {
            id: sourceRect
            anchors.fill: parent
            color: "transparent"
            border.width: 2
            border.color: bottomBarRoot.barColor
            radius: 8
            visible: false
        }

        ShaderEffectSource {
            id: maskRect

            hideSource: true
            visible: false
            sourceItem: Item {
                width: sourceRect.width
                height: sourceRect.height

                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    implicitHeight: 2
                    implicitWidth: bottomBarRoot.maskWidth
                    radius: 8
                    color: "black"
                }
            }
        }

        MultiEffect {
            source: sourceRect
            maskSource: maskRect
            maskEnabled: true
            anchors.fill: sourceRect
        }
    }
}
