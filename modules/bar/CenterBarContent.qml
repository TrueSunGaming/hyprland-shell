import QtQuick
import "../screen"
import "drawer"
import "widgets"

DateTime {
    id: root

    required property ScreenManager screenManager

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
        }
    }
}