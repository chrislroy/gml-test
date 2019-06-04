import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Styles 1.4


Item {
    id: container

    width: 200
    height: 60
    property string suitabilityMap: ""
    property int currentMap: -1
    property string thumbnail: ""

    function updateUi() {

        console.log("updateUi:" + suitabilityMap)
        layerList.clearModel();
        comboBox.model.clear()
        if (suitabilityMap === "") {
            return;
        }

        var theMap = JSON.parse(suitabilityMap);

        // iupdate the map model
        var currentIndex = ""
        for(var j in theMap) {
            if (theMap[j]["SuitabilityMap"]["Enabled"] && currentIndex === "") {
                currentIndex = j;
            }
            mapModel.append( { mapName : theMap[j]["SuitabilityMap"]["Name"] })
        }
        mapModel.append( { mapName : "Create new map..." })

        // update the layer model
        if (currentIndex !== "") {
            currentMap = parseInt(currentIndex, 10);
            thumbnail = theMap[currentIndex]["SuitabilityMap"]["Thumbnail"];
            var layers = theMap[currentIndex]["SuitabilityMap"]["SoftCostLayers"];
            for (var i in layers) {
                console.log("adding layer " + layers[i]["DisplayName"])
                layerList.addLayer(layers[i]);
            }

            comboBox.currentIndex = currentMap;
        }
    }

    function refreshUi() {
        if (currentMap != comboBox.currentIndex && comboBox.currentIndex !== -1) {
            currentMap = comboBox.currentIndex;

            thumbnail = theMap[comboBox.currentIndex]["SuitabilityMap"]["Thumbnail"];
            var layers = theMap[comboBox.currentIndex]["SuitabilityMap"]["SoftCostLayers"];
            for (var i in layers) {
                console.log("adding layer " + layers[i]["DisplayName"])
                layerList.addLayer(layers[i]);
            }
        }
    }

    onSuitabilityMapChanged: {
        updateUi();
    }


    // functions
    function toQrc(s) {
        return s.replace("img://file/", "file:///");
    }

    // disable suitability map or enable current map
    function updateAllMaps(checked) {

        console.log("update all maps " + checked)
        console.log("SM:\n" + suitabilityMap);
        comboBox.enabled = checked
        var mapIndex = currentMap
        var maps = JSON.parse(suitabilityMap);
        for(var i in maps) {
            maps[i]["SuitabilityMap"]["Enabled"] = checked
        }

        if (checked === false)
            layerList.clearModel();
        else {
            updateUi();
            comboBox.currentIndex = mapIndex;
        }

        applicationData.onSuitabilityMapChange(JSON.stringify(maps));
    }

    function setCurrentMap(mapIndex) {

        if (currentMap === mapIndex)
            return;
        currentMap = mapIndex;
        var maps = JSON.parse(suitabilityMap);
        for(var i in maps) {
            if (i === currentMap.toString())
                maps[i]["SuitabilityMap"]["Enabled"] = true
            else
                maps[i]["SuitabilityMap"]["Enabled"] = false
        }

        //updateAllMaps(true);
        applicationData.onSuitabilityMapChange(JSON.stringify(maps));
        //updateUi();
    }

    // combo box model
    ListModel {
        id: mapModel
    }

    Rectangle {
        id: selector

        height: 80
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        // thumbnail de la map
        Rectangle {
            id: rectangle
            width: 80
            height: 80
            color: "#ffffff"
            anchors {
                left: parent.left
                bottom: parent.bottom
                top: parent.top
                margins: 2
            }

            Image {
                id: image
                anchors {
                   margins: 5
                   fill: parent
                }

                source: toQrc(thumbnail)
                fillMode: Image.PreserveAspectFit
            }

        }

        // le map selector
        ComboBox {
            id: comboBox
            width: 80
            currentIndex: 0
            //textRole: "displayLabel"
            model: mapModel
            anchors.right: parent.right
            anchors.left: rectangle.right
            anchors.rightMargin: 70
            anchors.verticalCenter: parent.verticalCenter

            // combo box item delegate
            delegate: ItemDelegate {
                id: item
                Row {
                    height: 20
                    width: comboBox.width
                    Text {
                        color:  "#343434"
                        text: mapName
                    }
                }
            }

            MouseArea
            {
                anchors.fill: parent


                hoverEnabled: true
                propagateComposedEvents: true

                onClicked: mouse.accepted = false
                onPressed: mouse.accepted = false
                onReleased: mouse.accepted = false
                onDoubleClicked: mouse.accepted = false
                onPositionChanged: mouse.accepted = false
                onPressAndHold: mouse.accepted = false
             }

             onCurrentIndexChanged: {
                 console.log("onCurrentIndexChanged\n");
                if (currentIndex !== -1) {
                    console.log(currentIndex);
                    setCurrentMap(currentIndex)
                }
             }

        }

        // turn map on or off
        Switch {
            id: mapOn
            width: 50
            display: AbstractButton.IconOnly
            anchors.left: comboBox.right
            anchors.leftMargin: 12
            anchors.verticalCenter: parent.verticalCenter

            onPressedChanged: {
                console.log("Switch clicked");
                updateAllMaps(mapOn.checked)
            }
        }
    }

    // layer title
    Rectangle {
        id: layerTitle
        height: 40
        color: "#020202"
        anchors.top: selector.bottom
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

    // The layer list view:
    LayerList {
        id: layerList
        anchors.topMargin: 20

        anchors {
            left: parent.left;
            top: layerTitle.bottom;
            bottom: parent.bottom
            right: parent.right;
            margins: 20
        }
    }


}

