import QtQuick
import QtQuick.Layouts
import "../../components/containers"
import "widgets"

FiveRow {
    leftComponent: RowLayout {
        Rectangle {
            Layout.preferredWidth: 100
            Layout.fillHeight: true
            color: "red"
        }
    }

    leftCenterComponent: RowLayout {
        Rectangle {
            Layout.preferredWidth: 100
            Layout.fillHeight: true
            color: "orange"
        }
    }

    centerComponent: DateTime {}

    rightCenterComponent: RowLayout {
        Rectangle {
            Layout.preferredWidth: 100
            Layout.fillHeight: true
            color: "green"
        }
    }

    rightComponent: RowLayout {
        Rectangle {
            Layout.preferredWidth: 100
            Layout.fillHeight: true
            color: "blue"
        }
    }
}