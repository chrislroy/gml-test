import QtQuick 2.0
import QtQuick.Window 2.12
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.3

Rectangle {
    id: layer
    width: 400
    height: 80

    anchors {
        left: parent.left
        right:parent.right
    }

    Rectangle {
        id: rectangle
        width: 80
        height: 80
        color: "#ffffff"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0

        Image {
            id: image
            anchors.rightMargin: 5
            anchors.leftMargin: 5
            anchors.bottomMargin: 5
            anchors.topMargin: 5
            anchors.fill: parent
            source: toQrc(thumbnail)
            fillMode: Image.PreserveAspectFit
        }

    }

    Rectangle {
        id: sliderRect
        color: "#ffffff"
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.left: rectangle.right
        anchors.leftMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 80
        anchors.top: parent.top
        anchors.topMargin: 0

        Slider {
            id: slider
            height: 14
            anchors.top: parent.top
            anchors.topMargin: 57
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 5
            from: 1
            value: parseInt(weight)
            to: 100


        }


        Text {
            id: layerName
            color: "#c95f65"
            text: name
            anchors.top: parent.top
            anchors.topMargin: 7
            font.bold: true
            lineHeight: 1.1
            anchors.left: parent.left
            anchors.leftMargin: 5
            font.pixelSize: 12
        }
        Text {
            id: weightSlider
            text: qsTr("Weignt")
            anchors.top: parent.top
            anchors.topMargin: 29
            anchors.left: parent.left
            anchors.leftMargin: 7
            font.bold: true
            font.pixelSize: 12
        }
    }
}
