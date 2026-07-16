import QtQuick
import Quickshell
import "modules/bar"
import "modules/theme"

ShellRoot {
    ThemeLoader {}

    Variants {
        model: Quickshell.screens

        Item {
            id: screenWrapper
            required property ShellScreen modelData

            BarWindow {
                currentScreen: screenWrapper.modelData
            }
        }
    }
}