import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../../components/containers"
import "../../../components/text"
import "../../../services"

Control {
    padding: 8

    contentItem: Control {
        padding: 4

        contentItem: RowLayout {
            VFitText {
                Layout.fillHeight: true

                text: AudioService.silent ? "" : ""
            }
        }

        background: Rectangle {
            color: ThemeService.bgColor2
            radius: 8
        }
    }
}