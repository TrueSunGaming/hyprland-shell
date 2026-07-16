import QtQuick
import QtQuick.Controls
import Quickshell
import "../../components/containers/window"
import "../../services"

StyleWindow {
    required property ShellScreen currentScreen
    screen: currentScreen

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: ThemeService.barHeight

    Control {
        anchors.fill: parent

        opacity: 0.9

        contentItem: BarContent {}

        background: Rectangle {
            color: ThemeService.bgColor
        }
    }
}