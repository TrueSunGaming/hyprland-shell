import QtQuick
import "../../services"

Text {
    color: ThemeService.textColor

    font {
        family: ThemeService.fontFamily
        weight: ThemeService.fontWeight
        features: {
            "tnum": 1,
            "lnum": 1
        }
    }
}