import Quickshell
import "../../components/containers"
import "../../components/containers/window"
import "../bar"

Scope {
    required property ShellScreen screen

    property FullscreenWindow fullscreenWindow
    property BarWindow bar
    property PseudoDrawer activeDrawer: null

    function closeDrawer(drawer: PseudoDrawer): void {
        drawer.open = false;
        if (activeDrawer == drawer)
            activeDrawer = null;
    }

    function closeActiveDrawer(): void {
        if (activeDrawer)
            closeDrawer(activeDrawer);
    }

    function openDrawer(drawer: PseudoDrawer): void {
        closeActiveDrawer();
        drawer.open = true;
        activeDrawer = drawer;
    }

    function toggleDrawer(drawer: PseudoDrawer): void {
        if (activeDrawer == drawer)
            closeDrawer(drawer);
        else
            openDrawer(drawer);
    }
}
