import QtQuick
import QtQuick.Effects

Item {
    property color nameColor
    property string nameSource
    Image {
        id: bg
        source: nameSource
        onStatusChanged: if (status === Image.Ready) {
            sourceSize.width = parent.width
            sourceSize.height = parent.height
            anchors.fill = parent
        }
        onWidthChanged: {
            sourceSize.width = parent.width
            sourceSize.height = parent.height
        }
        fillMode: Image.PreserveAspectFit
        visible: false
    }

    MultiEffect {
        source: bg
        anchors.fill: parent
        colorization: 1.0
        colorizationColor: nameColor
    }
}
