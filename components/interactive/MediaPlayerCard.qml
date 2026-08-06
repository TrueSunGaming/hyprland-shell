pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Widgets
import "../containers"
import "../decorations"
import "../text"
import "../../services"

Control {
    id: root

    required property MprisPlayer player

    readonly property bool playing: MediaService.isPlaying(player)
    readonly property DesktopEntry app: DesktopEntryService.heuristicLookup(player?.identity)

    padding: 4

    contentItem: RowLayout {
        spacing: 8

        GoldenColumn {
            Layout.fillWidth: false
            Layout.fillHeight: true

            reverse: true

            topComponent: Control {
                id: appControl

                readonly property bool clickable: root.player?.canRaise ?? false

                visible: root.app != null

                contentItem: RowLayout {
                    spacing: 2

                    IconImage {
                        Layout.fillHeight: true
                        Layout.preferredWidth: height

                        readonly property string icon: root.app?.icon ?? ""
                        source: icon ? Quickshell.iconPath(icon) : ""
                    }

                    Item {
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        HScrollText {
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            text: root.app?.name ?? "Player"
                        }
                    }
                }

                background: Rectangle {
                    color: ThemeService.hoverColor
                    radius: 4

                    visible: appControl.clickable && appHover.hovered
                }

                HoverHandler {
                    id: appHover
                    cursorShape: appControl.clickable ? Qt.PointingHandCursor : Qt.ArrowCursor
                }

                TapHandler {
                    onTapped: {
                        if (appControl.clickable)
                            root.player?.raise();
                    }
                }
            }

            bottomComponent: RowLayout {
                spacing: 0

                PlayerButton {
                    Layout.leftMargin: 8

                    text: ""
                    buttonEnabled: root.player?.canGoPrevious ?? false
                    onTapped: root.player?.previous()
                }

                PlayerButton {
                    text: root.playing ? "" : ""
                    buttonEnabled: (root.playing ? root.player?.canPause : root.player?.canPlay) ?? false
                    onTapped: MediaService.togglePause(root.player)
                }

                PlayerButton {
                    Layout.rightMargin: 8

                    text: ""
                    buttonEnabled: root.player?.canGoNext ?? false
                    onTapped: root.player?.next()
                }
            }
        }

        GoldenColumn {
            Layout.fillWidth: true
            Layout.fillHeight: true

            topComponent: HScrollText {
                text: (root.player?.trackTitle ?? "No active player") || "Unknown Title"
            }

            bottomComponent: HScrollText {
                text: (root.player?.trackArtist ?? "-") || "Unknown Artist"
            }
        }
    }

    background: Loader {
        id: bg

        anchors.fill: parent

        Component {
            id: activeComponent
            BlurImageBackground {
                image.source: Qt.resolvedUrl(root.player?.trackArtUrl ?? "")
            }
        }

        Component {
            id: inactiveComponent
            Rectangle {
                color: ThemeService.bgColor2
                radius: 8
            }
        }

        states: [
            State {
                name: "active"
                when: root.player
                PropertyChanges {
                    target: bg
                    sourceComponent: activeComponent
                }
            },
            State {
                name: "inactive"
                when: !root.player
                PropertyChanges {
                    target: bg
                    sourceComponent: inactiveComponent
                }
            }
        ]

        Item {
            anchors.fill: parent
            z: 1

            BottomBar {
                barColor: Qt.alpha(ThemeService.textColor, 0.3)
                maskWidth: parent.width
            }

            BottomBar {
                barColor: ThemeService.textColor
                maskWidth: parent.width * MediaService.getProgress(root.player)

                FrameAnimation {
                    running: root.playing
                    onTriggered: root.player?.positionChanged()
                }
            }
        }
    }

    component PlayerButton: Control {
        id: buttonRoot

        property bool buttonEnabled: true

        property string text
        property alias textItem: textItem

        Layout.fillHeight: true
        Layout.preferredWidth: height
        padding: 0

        signal tapped

        contentItem: VFitText {
            id: textItem

            updateParentLayout: false
            text: buttonRoot.text
            horizontalAlignment: Text.AlignHCenter
        }

        background: Rectangle {
            color: ThemeService.hoverColor
            radius: 4

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
                    implicitHeight: 3
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
