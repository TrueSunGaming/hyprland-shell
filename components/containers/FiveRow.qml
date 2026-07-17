import QtQuick
import "../../components/containers"

Item {
    property Component leftComponent
    property Component leftCenterComponent
    property Component centerComponent
    property Component rightCenterComponent
    property Component rightComponent

    ExtremeRow {
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            right: centerContainer.left
        }

        leftComponent: parent.leftComponent
        rightComponent: parent.leftCenterComponent
    }

    Loader {
        id: centerContainer

        sourceComponent: parent.centerComponent

        anchors {
            top: parent.top
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }

    ExtremeRow {
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: centerContainer.right
            right: parent.right
        }

        leftComponent: parent.rightCenterComponent
        rightComponent: parent.rightComponent
    }
}