pragma Singleton

import Quickshell
import Quickshell.Services.SystemTray

Singleton {
    readonly property list<SystemTrayItem> items: SystemTray.items.values

    function clickItem(item: SystemTrayItem): void {
        item.activate();
    }
}
