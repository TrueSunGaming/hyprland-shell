import QtQuick
import "../../services"

QtObject {
    required property string themeID
    
    property int barHeight: 48
    property real barOpacity: 0.9
    
    property color bgColor: "#0f0f0f"
    property color bgColor2: "#2f2f2f"
    property color textColor: "#b0ffff"

    property string fontFamily: "Inter"
    property int fontWeight: 700

    function load(): void {
        ThemeService.themes.push(this);
    }
}