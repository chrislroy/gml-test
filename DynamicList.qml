
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


    ListModel {
        id: mapModel
    }

    // functions
    function toQrc(s) {
        return s.replace("img://file/", "file:///");
    }

    function addLayer(layerObj) {
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
            mapModel.append(addLayer(softs[i]));
        }
    }

    // map selector
    MapSelector {
        id: mapSelector
        height: 80

        anchors {
            top: parent.top
            left: parent.left
            leftMargin: 0
            right: parent.right
            rightMargin: 0
        }
    }

    // layer title
    Rectangle {
        id: layerTitle
        height: 40
        color: "#020202"
        anchors.top: mapSelector.bottom
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        Text {
            color: "#ffffff"
            text: "Layers"
            anchors.left: parent.left
            anchors.leftMargin: 13
            font.pointSize: 13
            elide: Text.ElideRight
            anchors.verticalCenter: parent.verticalCenter
        }
    }



    Component {
        id: mapDelegate

        Map {
            id: map
            width: 400
            height: 80
        }
    }

    // The view:
    ListView {
        id: mapView
        anchors.topMargin: 20
        anchors {
            left: parent.left; top: layerTitle.bottom
            right: parent.right; bottom: buttons.top;
            margins: 20
        }
        model: mapModel
        delegate: mapDelegate
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

