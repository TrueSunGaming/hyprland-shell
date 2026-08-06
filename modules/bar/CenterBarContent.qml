import QtQuick
import QtQuick.Controls
import "../screen"
import "../../services"
import "drawer"
import "widgets"
import "../../components/interactive"

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

    DrawerSpawner {
        drawer: CenterDrawer {
            screenManager: root.screenManager
            anchorItem: root.contentItem
        }
    }
}
