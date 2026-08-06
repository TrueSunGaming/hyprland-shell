pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import "../../components/containers"
import "widgets"
import "../screen"

FiveRow {
    id: root
    required property ScreenManager screenManager

    leftComponent: RowLayout {
        Workspaces {
            screenManager: root.screenManager

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

    centerComponent: CenterBarContent {
        screenManager: root.screenManager
    }

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
