import QtQuick
import "../containers"

Item {
    id: root

    required property PseudoDrawer drawer

    anchors.fill: parent

    TapHandler {
        onTapped: root.drawer.screenManager.toggleDrawer(root.drawer)
    }
}
