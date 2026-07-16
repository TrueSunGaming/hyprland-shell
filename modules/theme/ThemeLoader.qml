import QtQuick

QtObject {
    default property list<Theme> themes

    onThemesChanged: {
        for (const theme of themes) theme.load();
    }
}