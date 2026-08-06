import QtQuick
import QtQuick.Controls
import "../../components/containers/window"
import "../../services"
import "../screen"

StyleWindow {
    id: root

    required property ScreenManager screenManager
    screen: screenManager.screen

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: ThemeService.barHeight

    Control {
        anchors.fill: parent

        opacity: 0.9

        contentItem: BarContent {
            screenManager: root.screenManager
        }

        background: Rectangle {
            color: ThemeService.bgColor
        }
    }

    Component.onCompleted: screenManager.bar = this
    Component.onDestruction: {
        if (screenManager.bar == this)
            screenManager.bar = null;
    }
}
