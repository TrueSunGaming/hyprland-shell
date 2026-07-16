pragma Singleton

import Quickshell

Singleton {
    readonly property date date: clock.date

    function format(fmt: string): string {
        // qmllint disable missing-property
        return Qt.formatDateTime(date, fmt);
        // qmllint enable missing-property
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}