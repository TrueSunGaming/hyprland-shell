import QtQuick
import Quickshell
import "modules/bar"
import "modules/screen"

ShellRoot {
    Variants {
        model: Quickshell.screens

        Scope {
            id: screenWrapper
            required property ShellScreen modelData

            ScreenManager {
                id: screenManagerObj
                screen: screenWrapper.modelData
            }

            BarWindow {
                screenManager: screenManagerObj
            }
        }
    }
}
