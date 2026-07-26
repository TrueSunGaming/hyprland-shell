import QtQuick
import QtQuick.Layouts

ColumnLayout {
    property bool reverse: false
    property Component topComponent
    property Component bottomComponent
    property bool topFillWidth: true
    property bool bottomFillWidth: true

    spacing: 0

    Loader {
        sourceComponent: parent.topComponent

        Layout.preferredHeight: parent.reverse ? 1 : 1.618
        Layout.fillWidth: parent.topFillWidth
        Layout.fillHeight: true
    }

    Loader {
        sourceComponent: parent.bottomComponent

        Layout.preferredHeight: parent.reverse ? 1.618 : 1
        Layout.fillWidth: parent.bottomFillWidth
        Layout.fillHeight: true
    }
}