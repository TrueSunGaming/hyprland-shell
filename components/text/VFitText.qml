import QtQuick
import QtQuick.Layouts

StyleText {
    minimumPixelSize: 1
    font.pixelSize: 100
    fontSizeMode: Text.VerticalFit
    wrapMode: Text.NoWrap
    verticalAlignment: Text.AlignVCenter
    Layout.preferredWidth: paintedWidth

    function updateLayoutWidth(): void {
        parent.Layout.preferredWidth = paintedWidth;
    }

    Component.onCompleted: updateLayoutWidth()
    onPaintedWidthChanged: updateLayoutWidth()
}