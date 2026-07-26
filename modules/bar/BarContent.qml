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
            Layout.rightMargin: 8
            color: "orange"
        }
    }

    centerComponent: DateTime {}

    rightCenterComponent: RowLayout {
        Media {
            Layout.leftMargin: 8
            Layout.fillHeight: true
        }
    }

    rightComponent: RowLayout {
        spacing: 0

        Audio {
            Layout.fillHeight: true
        }

        Wifi {
            Layout.fillHeight: true

            leftPadding: 0
        }
    }
}