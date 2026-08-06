import QtQuick
import "../../../components/containers"

PseudoDrawer {
    content: Rectangle {
        implicitWidth: 100
        implicitHeight: 300
        color: "transparent"

        Rectangle {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            implicitWidth: 100
            implicitHeight: 100
        }
    }
}
