import QtQuick
import "lib" as Lib
import org.kde.kirigami as Kirigami

Item {

    property int widthTxt: 0
    Row {
        id: dayForecast
        width: parent.width
        height: parent.height

        Repeater {
            model: forecastModel
            delegate: Item {
                width: parent.width/3
                height: parent.height
                Column {
                    width: text.implicitWidth
                    height: parent.height
                    spacing: Kirigami.Units.iconSizes.small/3
                    anchors.horizontalCenter: parent.horizontalCenter
                    Kirigami.Heading {
                        id: text
                        height: parent.height/4
                        width: parent.width
                        text: model.date
                        color: txtColor
                        level: 5
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.capitalization: Font.Capitalize
                        font.pointSize: height*.5
                    }
                    Lib.Icon {
                        id: logo
                        width: parent.height/4
                        height: width
                        anchors.horizontalCenter: parent.horizontalCenter
                        name: model.icon
                    }
                    Column {
                        width: parent.width
                        height: parent.height - text.height - logo.height
                        spacing: 2
                        Kirigami.Heading {
                            width: parent.width
                            text: model.maxTemp
                            color: txtColor
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: parent.height*.25
                        }
                        Kirigami.Heading {
                            width: parent.width
                            text: model.minTemp
                            color: txtColor
                            opacity: 0.7
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pointSize: parent.height*.25
                        }
                    }


                }
            }

        }
    }
}
