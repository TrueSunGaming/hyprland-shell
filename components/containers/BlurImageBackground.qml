pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import "../../services"

Item {
    property alias image: sourceImage
    property alias mask: cornerMask

    Image {
        id: sourceImage

        visible: false
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
    }

    ShaderEffectSource {
        id: cornerMask

        hideSource: true
        visible: false
        sourceItem: Item {
            width: sourceImage.width
            height: sourceImage.height

            Rectangle {
                anchors.fill: parent
                radius: 8
                color: "black" // Alpha channel is what MultiEffect uses
            }
        }
    }

    MultiEffect {
        anchors.fill: parent
        source: sourceImage

        autoPaddingEnabled: false

        blurEnabled: true
        blur: 0.3
        blurMax: 64

        maskEnabled: true
        maskSource: cornerMask
        maskThresholdMin: 0.5
        maskSpreadAtMin: 1

        colorization: 0.8
        colorizationColor: ThemeService.bgColor2
    }
}