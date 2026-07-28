import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import "../../../services"
import "../../../modules/screen"
import "../../anim"

PopupWindow {
    id: root

    required property ScreenManager screenManager
    required property Item anchorItem
    property Item content

    property bool open: false

    readonly property PanelWindow bar: screenManager.bar

    anchor.item: anchorItem
    anchor.rect.x: (anchorItem?.width ?? 0) / 2 - width / 2
    anchor.rect.y: bar?.height ?? 0
    implicitWidth: contentControl.implicitWidth
    implicitHeight: contentControl.implicitHeight

    surfaceFormat.opaque: false
    color: "transparent"

    mask: Region {
        item: contentClip
    }

    Item {
        states: [
            State {
                name: "closed"
                when: !root.open
            },
            State {
                name: "open"
                when: root.open
            }
        ]

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

                    PropertyAction {
                        target: contentClip
                        property: "visible"
                        value: true
                    }

                    NumberAnimation {
                        target: contentClip
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
                        target: contentClip
                        property: "expandProgress"
                        to: 0
                        duration: 200
                        easing: Easing.OutCubic
                    }

                    PropertyAction {
                        target: contentClip
                        property: "visible"
                        value: false
                    }

                    PropertyAction {
                        target: root
                        property: "visible"
                        value: false
                    }
                }
            }
        ]
    }

    ClippingRectangle {
        id: contentClip

        property real expandProgress: 0

        opacity: 0.9
        color: ThemeService.bgColor

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        implicitWidth: contentControl.implicitWidth
        implicitHeight: contentControl.implicitHeight * expandProgress

        Control {
            id: contentControl

            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter

            contentItem: root.content
        }
    }
}
