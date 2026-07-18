pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../components/containers"
import "widgets"

FiveRow {
    id: root
    required property ShellScreen screen

    leftComponent: RowLayout {
        Workspaces {
            screen: root.screen

            Layout.fillHeight: true
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