pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root
    property bool _bindToggle: false

    Connections {
        target: DesktopEntries

        function onApplicationsChanged() {
            root._bindToggle = !root._bindToggle;
        }
    }

    function getAppIconEntry(appClass: string): string {
        let _ = _bindToggle; // create binding dependency

        return DesktopEntries.heuristicLookup(appClass)?.icon ?? "";
    }
}