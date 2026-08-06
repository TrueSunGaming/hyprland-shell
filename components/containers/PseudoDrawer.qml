import QtQuick
import QtQuick.Controls
import "../../services"

Pseudowindow {
    id: root

    required property Item anchorItem
    default property Item content

    property real expandProgress: 0

    open: false

    readonly property point globalAnchor: {
        void open;
        return anchorItem?.mapToItem(fsWindow?.windowView, 0, 0) ?? Qt.point(0, 0);
    }
    readonly property point localAnchor: {
        void open;
        parent?.mapFromItem(fsWindow?.windowView, globalAnchor) ?? Qt.point(0, 0);
    }

    x: localAnchor.x + (anchorItem?.width ?? 0) / 2 - width / 2
    y: localAnchor.y + anchorItem?.height ?? 0

    implicitWidth: contentControl.implicitWidth
    implicitHeight: contentControl.implicitHeight * expandProgress

    color: ThemeService.bgColor
    opacity: 0.9

    transitions: [
        Transition {
            from: "closed"
            to: "open"

            SequentialAnimation {
                PropertyAction {
                    target: root
                    property: "visible"
                    value: true
                }

                NumberAnimation {
                    target: root
                    property: "expandProgress"
                    to: 1
                    duration: 200
                    easing: Easing.OutCubic
                }
            }
        },
        Transition {
            from: "open"
            to: "closed"

            SequentialAnimation {
                NumberAnimation {
                    target: root
                    property: "expandProgress"
                    to: 0
                    duration: 200
                    easing: Easing.OutCubic
                }

                PropertyAction {
                    target: root
                    property: "visible"
                    value: false
                }
            }
        }
    ]

    Control {
        id: contentControl

        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        contentItem: root.content
    }
}
