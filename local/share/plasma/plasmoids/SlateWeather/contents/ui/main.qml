/*
 *  SPDX-FileCopyrightText: 2025 adolof aka zayronxio <adolfo@librepixels.com>
 *
 *  SPDX-License-Identifier: GPL-3.0-or-later
 */
import QtQuick
import org.kde.plasma.plasmoid
import Qt5Compat.GraphicalEffects
import org.kde.kirigami as Kirigami
import "components" as Components
import "lib" as Lib

PlasmoidItem {
  id: root
  width: 450
  height: 100
  preferredRepresentation: fullRepresentation
  Plasmoid.backgroundHints: "NoBackground"

  property int marginGeneral: Kirigami.Units.largeSpacing
  property date currentDateTime: new Date()
  property color widgetColor: Plasmoid.configuration.generalColor

  property color txtColor: "#060707"

  property string dayLastUpdate

  Components.WeatherData {
    id: weatherData
  }

  onWidgetColorChanged: {
    txtColor = isColorLight(widgetColor) ? "#060707" : "#eeeef1"
  }
  property string icon: (weatherData.datosweather !== "0") ? weatherData.iconWeatherCurrent : "weather-none-available"
  property string temcurrent: Math.round(weatherData.currentTemperature) + "°"

  ListModel {
    id: forecastModel
  }
  Timer {
    id: timer
    interval: 1000
    running: false
    repeat: true
    onTriggered: {
      currentDateTime = new Date()
      var currentDay = getTranslatedDayInitial(0)
      if (dayLastUpdate !== currentDay) {
        updateForecastModel()
      }
    }
  }

  Component.onCompleted: {
    weatherData.dataChanged.connect(() => {
      Qt.callLater(updateForecastModel); // Asegura que la función se ejecute al final del ciclo de eventos
      currentDateTime = new Date()
      dayLastUpdate = getTranslatedDayInitial(0)
      timer.start()
    });
  }

  function isColorLight(color) {
    var r = Qt.rgba(color.r, 0, 0, 0).r * 255;
    var g = Qt.rgba(0, color.g, 0, 0).g * 255;
    var b = Qt.rgba(0, 0, color.b, 0).b * 255;
    var luminance = 0.299 * r + 0.587 * g + 0.114 * b;
    return luminance > 127.5; // Devuelve true si es claro, false si es oscuro
  }

  function getTranslatedDayInitial(dayIndex) {
    currentDateTime.setDate(currentDateTime.getDate() - currentDateTime.getDay() + dayIndex);
    var dayName = currentDateTime.toLocaleString(Qt.locale(), "ddd");
    return dayName
  }

  function updateForecastModel() {

    let icons = {
      0: weatherData.oneIcon,
      1: weatherData.twoIcon,
      2: weatherData.threeIcon,
      3: weatherData.fourIcon,
      4: weatherData.fiveIcon,
    }
    let Maxs = {
      0: weatherData.oneMax,
      1: weatherData.twoMax,
      2: weatherData.threeMax,
      3: weatherData.fourMax,
      4: weatherData.fiveMax,
    }
    let Mins = {
      0: weatherData.oneMin,
      1: weatherData.twoMin,
      2: weatherData.threeMin,
      3: weatherData.fourMin,
      4: weatherData.fiveMin,
    }
    forecastModel.clear();
    for (var i = 1; i < 4; i++) {
      var icon = icons[i]
      var maxTemp = Maxs[i]
      var minTemp = Mins[i]
      var date = getTranslatedDayInitial(i)
      console.log(icon)
      forecastModel.append({
        date: date,
        icon: icon,
        maxTemp: maxTemp,
        minTemp: minTemp
      });


    }
  }

  Item {
    width: (root.height*4 < root.width) ? root.height*4 : root.width
    height: width/4
    DropShadow {
      anchors.fill: base
      horizontalOffset: 2
      verticalOffset: 2
      radius: 15
      samples: 17
      color: "#b2000000"
      source: base
      opacity: 0.3
    }
    Rectangle {
      id: base
      width: parent.width
      height: parent.height
      color: Plasmoid.configuration.generalColor
      radius: height/6
      opacity: 1
    }
    Column {
      id: currenWeather
      width: (parent.width/2) - marginGeneral
      height: parent.height - marginGeneral*2
      anchors.left: parent.left
      anchors.leftMargin: marginGeneral
      anchors.verticalCenter: base.verticalCenter

      Text {
        text: weatherData.city
        height: parent.height/2
        width: parent.width
        color: txtColor
        elide: Text.ElideRight
        font.pointSize: parent.height/7
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.Capitalize
      }
      Row {
        height: parent.height/2
        width: parent.width
        spacing: Kirigami.Units.smallSpacing

        Item {
          id: logoWeather
          width: height
          height: parent.height *.9
          Lib.Icon {
            width: parent.width
            height: width
            anchors.verticalCenter: parent.verticalCenter
            name: icon
          }

        }

        Text {
          width:  parent.width - logoWeather.width - parent.spacing
          height: parent.height
          color: txtColor
          verticalAlignment: Text.AlignVCenter
          font.pointSize: parent.height*.6
          text: temcurrent
        }
      }
    }
    Rectangle {
      width: 2
      anchors.left: currenWeather.right
      height: parent.height
      color: txtColor
      opacity: 0.2
    }
    ItemForecasts {
      width: (parent.width/2) - marginGeneral
      height: parent.height - marginGeneral*2
      anchors.left: currenWeather.right
      anchors.leftMargin: marginGeneral + 2
      anchors.verticalCenter: base.verticalCenter
    }
  }
}
