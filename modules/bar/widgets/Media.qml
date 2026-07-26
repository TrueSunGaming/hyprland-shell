pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import "../../../components/interactive"
import "../../../services"

Control {
    id: root

    padding: 4

    contentItem: MediaPlayerCard {
        player: MediaService.activePlayer
        implicitWidth: 250
    }
}
