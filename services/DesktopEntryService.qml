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

    function heuristicLookup(name: string): DesktopEntry {
        let _ = _bindToggle; // create binding dependency

        return DesktopEntries.heuristicLookup(name);
    }

    function getAppIconEntry(appClass: string): string {
        return heuristicLookup(appClass)?.icon ?? "";
    }
}