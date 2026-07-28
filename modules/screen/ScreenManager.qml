import Quickshell
import "../../components/containers/window"

Scope {
    required property ShellScreen screen

    property PanelWindow bar
    property DrawerWindow activeDrawer: null

    function closeDrawer(win: DrawerWindow): void {
        win.open = false;
        if (activeDrawer == win) activeDrawer = null;
    }

    function closeActiveDrawer(): void {
        if (activeDrawer) closeDrawer(activeDrawer);
    }

    function openDrawer(win: DrawerWindow): void {
        closeActiveDrawer();
        win.open = true;
        activeDrawer = win;
    }

    function toggleDrawer(win: DrawerWindow): void {
        if (activeDrawer == win) closeDrawer(win);
        else openDrawer(win);
    }
}