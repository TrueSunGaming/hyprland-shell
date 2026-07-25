pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property bool connected: false
    property bool connectedThisAttempt: false
    property string wifiName: "Disconnected"

    Process {
        id: wifiWatcher
        command: ["nmcli", "-t", "-f", "active,ssid", "dev", "wifi"]

        stdout: SplitParser {
            onRead: (data) => {
                if (!data) return;

                const line = data.trim();
                if (line.startsWith("yes")) {
                    root.wifiName = line.split(":")[1] || "Connected";
                    root.connectedThisAttempt = true;
                    root.connected = true;
                }
            }
        }
    }

    Timer {
        interval: 10000
        running: true
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            root.connected = root.connectedThisAttempt;
            if (!root.connected) root.wifiName = "Disconnected";

            root.connectedThisAttempt = false;
            wifiWatcher.running = true;
        }
    }
}