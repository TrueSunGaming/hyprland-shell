pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import "../../../modules/screen"
import ".."

StyleWindow {
    id: root

    required property ScreenManager screenManager

    default property list<Pseudowindow> windows

    property alias windowView: windowView

    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: screenManager.screen.height
    screen: screenManager.screen
    exclusiveZone: 0

    mask: Region {
        regions: root.windows.map(win => win.region)
    }

    ListView {
        id: windowView
        anchors.fill: parent
        model: root.windows

        delegate: Item {
            id: delegateItem
            required property Pseudowindow modelData

            Binding {
                target: delegateItem.modelData
                property: "parent"
                value: delegateItem
            }
        }
    }

    Component.onCompleted: screenManager.fullscreenWindow = this
    Component.onDestruction: {
        if (screenManager.fullscreenWindow == this)
            screenManager.fullscreenWindow = null;
    }
}
