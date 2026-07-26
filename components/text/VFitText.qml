import QtQuick
import QtQuick.Layouts

StyleText {
    property bool updateParentLayout: true

    minimumPixelSize: 1
    font.pixelSize: 100
    fontSizeMode: Text.VerticalFit
    wrapMode: Text.NoWrap
    verticalAlignment: Text.AlignVCenter
    Layout.preferredWidth: paintedWidth

    function updateLayoutWidth(): void {
        if (!updateParentLayout) return;
        parent.Layout.preferredWidth = paintedWidth;
    }

    Component.onCompleted: updateLayoutWidth()
    onPaintedWidthChanged: updateLayoutWidth()
}