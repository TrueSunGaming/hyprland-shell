import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../../components/containers"
import "../../../components/text"
import "../../../services"

Control {
    padding: 4

    contentItem: GoldenColumn {
        topComponent: VFitText {
            text: ClockService.format("h:mm:ss AP")
            horizontalAlignment: Text.AlignHCenter
        }

        bottomComponent: VFitText {
            text: ClockService.format("dddd, MMMM d")
            horizontalAlignment: Text.AlignHCenter
        }
    }
}