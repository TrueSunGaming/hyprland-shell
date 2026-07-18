pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import "../../../components/anim"
import "../../../components/text"
import "../../../services"

Control {
    id: root
    required property ShellScreen screen

    padding: 8

    contentItem: RowLayout {
        spacing: 4

        Repeater {
            model: HyprService.getScreenWorkspaces(root.screen)

            delegate: Control {
                id: wsContainer
                required property HyprlandWorkspace modelData

                Layout.fillHeight: true
                padding: 5

                contentItem: RowLayout {
                    VFitText {
                        text: wsContainer.modelData.name

                        Layout.fillHeight: true
                    }

                    Repeater {
                        model: HyprService.getWorkspaceIcons(wsContainer.modelData)

                        delegate: IconImage {
                            required property string modelData

                            source: modelData

                            Layout.fillHeight: true
                            Layout.preferredWidth: height
                        }
                    }
                }

                background: Rectangle {
                    color: ThemeService.bgColor2
                    radius: 8
                    border {
                        color: wsContainer.modelData.active ? ThemeService.textColor : "transparent"
                        width: 1
                    }

                    Behavior on border.color {
                        ColorAnimNorm {}
                    }
                }

                TapHandler {
                    onTapped: parent.modelData.activate()
                }

                HoverHandler {
                    cursorShape: Qt.PointingHandCursor
                }
            }
        } 
    }
}