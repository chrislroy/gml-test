
import QtQuick 2.0
import QtQuick.Controls 2.3
import "content"

// This example shows how items can be dynamically added to and removed from
// a ListModel, and how these list modifications can be animated.

Rectangle {
    id: container
    width: 500; height: 400
    color: "#343434"
    property string jsonFile: ""
    Rectangle {
        id: topRow
        color: "#e26b6b"
        width: 80
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
    }

    ListModel {
        id: mapModel
    }

    function getPng(s) {
        return s.slice(11, -1);
    }

    Component {
        id: mapDelegate

        Item {
            id: map
            width: 400
            height: 80

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
                   // source: getPng(thumbnail)
                    source : "file:///C:/Users/croy/Documents/Autodesk InfraWorks Models/Roads Tutorial (April 2019).files/unver/SoftCosts/Thumbnails/b71d55ae-543c-490c-b660-b0dd16800763.png"
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
                    id: mapName
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
                    id: sliderLabel
                    text: qsTr("Weignt")
                    anchors.top: mapName.bottom
                    anchors.topMargin: 16
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    font.bold: true
                    font.pixelSize: 12
                }
            }
        }    }

    // The view:
    ListView {
        id: mapView
        anchors.topMargin: 20
        anchors {
            left: parent.left; top: topRow.bottom
            right: parent.right; bottom: buttons.top;
            margins: 20
        }
        model: mapModel
        delegate: mapDelegate
    }

    function addMap(layerObj) {
        return {
            "object" : layerObj,
            "name": layerObj["DisplayName"],
            "weight": layerObj["Weight"],
            "thumbnail": layerObj["Thumbnail"]
        };
    }

    function addMaps() {
        if (jsonFile === "")
            return;
        var obj = JSON.parse(jsonFile);
        var softs = obj["SoftCostLayers"];
        for (var i in softs) {
            mapModel.append(addMap(softs[i]));
        }
    }


    Row {
        id: buttons
        anchors.horizontalCenter: parent.horizontalCenter
        anchors { bottom: parent.bottom; margins: 20 }
        spacing: 10

        TextButton {
            text: "Add an item"
            onClicked:addMaps()
        }

        TextButton {
            text: "Remove all items"
            onClicked: mapModel.clear()
        }
    }
}

