pragma Singleton

import QtQuick
import Quickshell
import "../components/anim"
import "../modules/theme"

Singleton {
    readonly property list<Theme> themes: []

    Theme {
        id: defaultTheme
        themeID: "default"
    }

    property string activeThemeID: "default"
    readonly property Theme activeTheme: themes.find(t => t.themeID == activeThemeID) ?? defaultTheme

    property int barHeight: activeTheme.barHeight
    Behavior on barHeight {
        NumAnimLong {}
    }

    property real barOpacity: activeTheme.barOpacity
    Behavior on barOpacity {
        NumAnimLong {}
    }

    property color bgColor: activeTheme.bgColor
    Behavior on bgColor {
        ColorAnimLong {}
    }

    property color bgColor2: activeTheme.bgColor2
    Behavior on bgColor2 {
        ColorAnimLong {}
    }
    
    property color textColor: activeTheme.textColor
    Behavior on textColor {
        ColorAnimLong {}
    }

    property string fontFamily: activeTheme.fontFamily
    property int fontWeight: activeTheme.fontWeight
}
