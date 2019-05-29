
import QtQuick 2.0
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

    Component {
        id: mapDelegate

        Item {

            id: mapItem
            width: mapView.width; height: 80
            clip: true

            Column {
                anchors {
                    left: parent.left
                    horizontalCenter: parent.horizontalCenter;
                    bottom: parent.verticalCenter
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: name
                    font.pixelSize: 15
                    color: "white"
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: weight
                    font.pixelSize: 15
                    color: "white"
                }
            }
        }
    }

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

