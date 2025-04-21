import QtQuick
import org.kde.plasma.plasmoid
import org.kde.kirigami as Kirigami

Item {
    property string name

    function getIconDetails(iconName, detail = "all") {
        const iconDetails = [
            {
                name: "weather-clear",
                isFull: false,
                primaryColor: Plasmoid.configuration.sunColor,
            },
            {
                name: "weather-few-clouds",
                isFull: true,
                primaryColor: Plasmoid.configuration.sunColor,
                secondColor: Plasmoid.configuration.cloudColor,
            },
            {
                name: "weather-clouds",
                isFull: true,
                primaryColor: Plasmoid.configuration.cloudColor,
                secondColor: Plasmoid.configuration.bigCloudColor,
            },
            {
                name: "weather-showers-scattered",
                isFull: false,
                primaryColor: Plasmoid.configuration.cloudColor,
            },
            {
                name: "weather-showers",
                isFull: false,
                primaryColor: Plasmoid.configuration.cloudColor,
            },
            {
                name: "weather-snow-scattered",
                isFull: false,
                primaryColor: Plasmoid.configuration.cloudColor,
            },
            {
                name: "weather-snow",
                isFull: false,
                primaryColor: Plasmoid.configuration.cloudColor,
            },
            {
                name: "weather-hail",
                isFull: false,
                primaryColor: Plasmoid.configuration.cloudColor,
            },
            {
                name: "weather-storm",
                isFull: true,
                primaryColor: Plasmoid.configuration.cloudColor,
                secondColor: Plasmoid.configuration.lightningColor,
            },
            {
                name: "weather-unknown",
                isFull: false,
                primaryColor: Plasmoid.configuration.cloudColor,
            },
            {
                name: "weather-clear-night",
                isFull: false,
                primaryColor: Plasmoid.configuration.moonColor,
            },
            {
                name: "weather-few-clouds-night",
                isFull: true,
                primaryColor: Plasmoid.configuration.moonColor,
                secondColor: Plasmoid.configuration.cloudColor,
            },
            {
                name: "weather-clouds-night",
                isFull: true,
                primaryColor: Plasmoid.configuration.cloudColor,
                secondColor: Plasmoid.configuration.bigCloudColor,
            },
            {
                name: "weather-showers-scattered-night",
                isFull: false,
                primaryColor: Plasmoid.configuration.cloudColor,
            },
            {
                name: "weather-showers-night",
                isFull: false,
                primaryColor: Plasmoid.configuration.cloudColor,
            },
            {
                name: "weather-snow-scattered-night",
                isFull: false,
                primaryColor: Plasmoid.configuration.cloudColor,
            },
            {
                name: "weather-snow-night",
                isFull: false,
                primaryColor: Plasmoid.configuration.cloudColor,
            },
            {
                name: "weather-hail-night",
                isFull: false,
                primaryColor: Plasmoid.configuration.cloudColor,
            },
            {
                name: "weather-storm-night",
                isFull: true,
                primaryColor: Plasmoid.configuration.cloudColor,
                secondColor: Plasmoid.configuration.lightningColor,
            },
            {
                name: "weather-unknown-night",
                isFull: false,
                primaryColor: Plasmoid.configuration.cloudColor,
            },
        ];
        const icon = iconDetails.find(icon => icon.name === iconName);
        if (!icon) {
            return null;
        }

        switch (detail) {
            case "isFull":
                return icon.isFull;
            case "primaryColor":
                return icon.primaryColor;
            case "secondColor":
                return icon.secondColor;
            default:
                return icon;
        }
    }
    property color primaryColor:  getIconDetails(name, "primaryColor")
    property color secondColor: getIconDetails(name, "secondColor")

    property bool isFull: getIconDetails(name, "isFull")

    Loader {
        sourceComponent: isFull ? full : simple
        width: parent.width
        height: parent.height
    }

    Component {
        id: full
        Item {
            anchors.fill: parent
            Colorizer {
                anchors.fill: parent
                nameColor: secondColor
                nameSource: Qt.resolvedUrl("../icons/" + name + "-pf" + ".svg")
            }
            Colorizer {
                anchors.fill: parent
                nameColor: primaryColor
                nameSource: Qt.resolvedUrl("../icons/" + name + "-bg" + ".svg")
            }

        }
    }

    Component {
        id: simple
        Colorizer {
            anchors.fill: parent
            nameColor: primaryColor
            nameSource: Qt.resolvedUrl("../icons/" + name + ".svg")
        }
    }
}

