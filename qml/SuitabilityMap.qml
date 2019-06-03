
import QtQuick 2.0
import QtQuick.Controls 2.3

// This example shows how items can be dynamically added to and removed from
// a ListModel, and how these list modifications can be animated.

Rectangle {
    id: container
    width: 500; height: 400
    color: "#343434"
    property string jsonFile: ""

    onJsonFileChanged : {
        console.log("onJsonFileChanged");
        updateSuitabilityMap();
    }

    function isArray (value) {
        return value && typeof value === 'object' && value.constructor === Array;
    }

    function updateSuitabilityMap() {
        maps.suitabilityMap = jsonFile
    }

    function clearSuitabilityMap() {
        maps.suitabilityMap = ""
    }

    // map selector
    MapSelector {
        id: maps
        height: 80

        anchors {
            top: parent.top
            left: parent.left
            leftMargin: 0
            right: parent.right
            rightMargin: 0
            bottom: buttons.top
        }
    }

    // test buttons - add/clear map
    Row {
        id: buttons
        anchors.horizontalCenter: parent.horizontalCenter
        height: 40
        anchors {
            bottom: parent.bottom
        }
        spacing: 10

        Button {
            text: "Add an item"
            onClicked:updateSuitabilityMap()
        }

        Button {
            text: "Remove all items"
            onClicked: clearSuitabilityMap()
        }
    }

}

