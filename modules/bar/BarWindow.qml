import QtQuick
import "../../components/containers"
import "../../components/containers/window"
import "../../services"

FullscreenWindow {
    id: root

    exclusiveZone: ThemeService.barHeight

    Pseudowindow {
        id: pseudowindow

        screenManager: root.screenManager

        x: 0
        y: 0
        implicitWidth: screenManager.screen.width
        implicitHeight: ThemeService.barHeight
        // implicitWidth: 100
        // implicitHeight: 100

        color: ThemeService.bgColor
        opacity: 0.9

        BarContent {
            screenManager: root.screenManager
            anchors.fill: parent
        }
    }

    Component.onCompleted: screenManager.bar = this
    Component.onDestruction: {
        if (screenManager.bar == this)
            screenManager.bar = null;
    }
}
