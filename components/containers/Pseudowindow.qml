import QtQuick
import Quickshell
import Quickshell.Widgets
import "../../modules/screen"
import "window"

ClippingRectangle {
    id: root

    required property ScreenManager screenManager
    readonly property FullscreenWindow fsWindow: screenManager.fullscreenWindow

    readonly property Region region: Region {
        item: root
    }

    property bool open: false

    states: [
        State {
            name: "open"
            when: root.open
        },
        State {
            name: "closed"
            when: !root.open
        }
    ]

    clip: true

    function addToScreen(): void {
        fsWindow?.windows.push(this);
    }

    onFsWindowChanged: addToScreen()
}
