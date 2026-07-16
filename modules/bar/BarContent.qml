import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../../components/containers"
import "../../components/text"
import "widgets"

RowLayout {
    RowLayout {

    }

    Item {
        Layout.fillWidth: true
    }

    RowLayout {
        Layout.alignment: Qt.AlignHCenter

        DateTime {}
    }

    Item {
        Layout.fillWidth: true
    }

    RowLayout {

    }
}