import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Control {
    id: root

    property real scrollSpeed: 30
    property real scrollProgress: 0

    readonly property real scrollMax: Math.max(textItem.paintedWidth - availableWidth, 0)

    onScrollMaxChanged: {
        scrollAnimation.restart();
    }

    SequentialAnimation {
        id: scrollAnimation
        running: root.scrollMax > 0
        loops: Animation.Infinite

        NumberAnimation {
            target: root
            property: "scrollProgress"
            from: 0
            to: root.scrollMax
            duration: root.scrollMax / root.scrollSpeed * 1000
        }

        PauseAnimation { duration: 1000 }

        NumberAnimation {
            target: root
            property: "scrollProgress"
            from: root.scrollMax
            to: 0
            duration: root.scrollMax / root.scrollSpeed * 1000
        }

        PauseAnimation { duration: 1000 }
    }

    property alias text: textItem.text

    onTextChanged: {
        scrollProgress = 0;
        scrollAnimation.restart();
    }

    anchors.fill: parent
    clip: true

    contentItem: Item {
        VFitText {
            height: parent.height
            id: textItem
            x: -root.scrollProgress
        }
    }
}