import QtQuick
import QtQuick.Layouts

RowLayout {
    property Component leftComponent
    property Component rightComponent

    spacing: 0

    Loader {
        sourceComponent: parent.leftComponent

        Layout.fillHeight: true
        Layout.alignment: Qt.AlignLeft
    }

    Loader {
        sourceComponent: parent.rightComponent

        Layout.fillHeight: true
        Layout.alignment: Qt.AlignRight
    }
}