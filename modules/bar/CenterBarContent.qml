import QtQuick
import QtQuick.Controls
import "../screen"
import "../../services"
import "drawer"
import "widgets"

Control {
    id: root

    required property ScreenManager screenManager

    contentItem: DateTime {}

    background: Rectangle {
        color: ThemeService.bgColor2
        visible: hoverHandler.hovered
    }

    HoverHandler {
        id: hoverHandler
        cursorShape: Qt.PointingHandCursor
    }

    TapHandler {
        onTapped: root.screenManager.toggleDrawer(drawer)
    }

    CenterDrawer {
        id: drawer

        screenManager: root.screenManager
        anchorItem: root

        content: Rectangle {
            implicitWidth: 100
            implicitHeight: 300
            color: "transparent"

            Rectangle {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter

                implicitWidth: 100
                implicitHeight: 100
            }
        }
    }
}
