import QtQuick
import QtQuick.Controls
import Qt.labs.platform
import org.kde.kirigami as Kirigami
import org.kde.kquickcontrols as KQControls

Item {
    id: configRoot

    QtObject {
        id: unidWeatherValue
        property var value
    }



    signal configurationChanged

    property alias cfg_temperatureUnit: unidWeatherValue.value
    property alias cfg_latitudeC: latitude.text
    property alias cfg_longitudeC: longitude.text
    property alias cfg_useCoordinatesIp: autamateCoorde.checked
    property alias cfg_generalColor: colorhex.color

    property alias cfg_sunColor: sunColorButton.color
    property alias cfg_moonColor: moonColorButton.color
    property alias cfg_cloudColor: cloudColorButton.color
    property alias cfg_bigCloudColor: bigCloudColorButton.color
    property alias cfg_lightningColor: lightningColorButton.color

    Kirigami.FormLayout {
        width: parent.width

        ComboBox {
            textRole: "text"
            valueRole: "value"
            id: positionComboBox
            Kirigami.FormData.label: i18n("Temperature Unit:")
            model: [
                {text: i18n("Celsius (°C)"), value: 0},
                {text: i18n("Fahrenheit (°F)"), value: 1},
            ]
            onActivated: unidWeatherValue.value = currentValue
            Component.onCompleted: currentIndex = indexOfValue(unidWeatherValue.value)
        }

        CheckBox {
            id: autamateCoorde
            Kirigami.FormData.label: i18n('Use IP location')
        }
        TextField {
            id: latitude
            visible: !autamateCoorde.checked
            Kirigami.FormData.label: i18n("Latitude:")
            width: 200
        }
        TextField {
            id: longitude
            visible: !autamateCoorde.checked
            Kirigami.FormData.label: i18n("Longitude:")
            width: 200
        }

        KQControls.ColorButton {
            id: colorhex
            Kirigami.FormData.label: i18n('General Color:')
            showAlphaChannel: true
        }
        KQControls.ColorButton {
            id: sunColorButton
            Kirigami.FormData.label: i18n('Sun Color:')
            showAlphaChannel: true
        }
        KQControls.ColorButton {
            id: moonColorButton
            Kirigami.FormData.label: i18n('moon Color:')
            showAlphaChannel: true
        }
        KQControls.ColorButton {
            id: cloudColorButton
            Kirigami.FormData.label: i18n('Cloud/Rain Color:')
            showAlphaChannel: true
        }
        KQControls.ColorButton {
            id: bigCloudColorButton
            Kirigami.FormData.label: i18n('Deepin Cloud Color:')
            showAlphaChannel: true
        }
        KQControls.ColorButton {
            id: lightningColorButton
            Kirigami.FormData.label: i18n('Lightning Color:')
            showAlphaChannel: true
        }
    }
}
