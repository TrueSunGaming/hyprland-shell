import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ColumnLayout {
    property Component topComponent
    property Component bottomComponent

    spacing: 0

    Loader {
        sourceComponent: parent.topComponent

        Layout.preferredHeight: 1.618
        Layout.fillWidth: true
        Layout.fillHeight: true
    }

    Loader {
        sourceComponent: parent.bottomComponent

        Layout.preferredHeight: 1
        Layout.fillWidth: true
        Layout.fillHeight: true
    }
}