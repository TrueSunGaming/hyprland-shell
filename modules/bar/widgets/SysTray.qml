import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import "../../../services"

GridLayout {
    columnSpacing: 0
    rowSpacing: 0
    flow: GridLayout.TopToBottom
    layoutDirection: Qt.RightToLeft
    rows: 2

    Repeater {
        model: SysTrayService.items

        delegate: Control {
            id: trayItem

            padding: 2

            required property SystemTrayItem modelData

            contentItem: IconImage {
                source: trayItem.modelData.icon
                implicitSize: 16
            }

            background: Rectangle {
                color: ThemeService.hoverColor
                radius: 4

                visible: hoverHandler.hovered
            }

            QsMenuAnchor {
                id: menuAnchor

                // qmllint disable unresolved-type
                menu: trayItem.modelData.menu
                // qmllint enable unresolved-type
                anchor.item: trayItem
                // qmllint disable missing-type
                anchor.edges: Edges.Bottom | Edges.Left
                // qmllint enable missing-type
            }

            HoverHandler {
                id: hoverHandler
                cursorShape: Qt.PointingHandCursor
            }

            TapHandler {
                onTapped: {
                    if (trayItem.modelData.onlyMenu)
                        trayItem.modelData.activate();
                    menuAnchor.open();
                }
            }
        }
    }
}
