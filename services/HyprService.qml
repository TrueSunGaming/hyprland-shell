pragma Singleton

import Quickshell
import Quickshell.Hyprland

Singleton {
    readonly property list<HyprlandWorkspace> workspaces: [...Hyprland.workspaces.values].sort((a, b) => a.id - b.id)
    readonly property list<HyprlandWorkspace> activeWorkspaces: workspaces.filter((ws) => ws.active)

    signal workspaceAdded(workspace: HyprlandWorkspace)
    signal workspaceRemoved(workspace: HyprlandWorkspace)

    property list<HyprlandWorkspace> _oldWorkspaces: []
    onWorkspacesChanged: {
        const added = workspaces.filter((ws) => !_oldWorkspaces.includes(ws));
        const removed = _oldWorkspaces.filter((ws) => !workspaces.includes(ws));

        for (const ws of added) workspaceAdded(ws);
        for (const ws of removed) workspaceRemoved(ws);

        _oldWorkspaces = [...workspaces];
    }

    function getIconSource(toplevel: HyprlandToplevel): string {
        // qmllint disable unresolved-type missing-property
        const rawClass = toplevel?.wayland?.appId ?? toplevel?.initialClass ?? toplevel?.class ?? "";
        // qmllint enable unresolved-type missing-property
        if (rawClass == "") return "";

        const entry = DesktopEntryService.getAppIconEntry(rawClass);
        const appName = entry || rawClass;

        return Quickshell.iconPath(appName, true) || Quickshell.iconPath(appName.toLowerCase(), true);
    }

    function getWorkspaceIcons(workspace: HyprlandWorkspace): list<string> {
        return workspace?.toplevels.values.map((t) => getIconSource(t)) ?? [];
    }

    function getScreenWorkspaces(screen: ShellScreen): list<HyprlandWorkspace> {
        return workspaces.filter((ws) => ws.monitor?.name == screen.name);
    }

    function execFloating(command: string): void {
        try {
            Hyprland.dispatch(`hl.dsp.exec_cmd('${command}', { float = true })`);
        } catch(e) {
            Hyprland.dispatch(`exec [float] ${command}`);
        }
    }
}