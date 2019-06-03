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
    property string currentMap: ""
    property string thumbnail: ""

    onSuitabilityMapChanged: {
        // console.log("onSuitabilityMapChanged:" + suitabilityMap)
        layerList.clearModel();
        if (suitabilityMap === "") {
            return;
        }

        var theMap = JSON.parse(suitabilityMap);

        comboBox.model.clear()
        for(var j in theMap) {
            mapModel.append( { mapName : theMap[j]["SuitabilityMap"]["Name"] })
        }
        comboBox.currentIndex = 0;
        currentMap = theMap[0]["SuitabilityMap"]["Name"];
        thumbnail = theMap[0]["SuitabilityMap"]["Thumbnail"];
        var layers = theMap[0]["SuitabilityMap"]["SoftCostLayers"];
        for (var i in layers) {
            console.log("adding layer " + layers[i]["DisplayName"])
            layerList.addLayer(layers[i]);
        }
    }

    // functions
    function toQrc(s) {
        return s.replace("img://file/", "file:///");
    }

    function updateAllMaps(checked) {
        console.log("update all maps " + checked)
        var theMap = JSON.parse(suitabilityMap);

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

                onEntered:
                {
                    item.highlighted = true
                }

                onExited:
                {
                    item.highlighted = false
                }
             }
             onCurrentIndexChanged: {
                 console.log("Combo changed-new index:" + currentIndex)
                 console.log(mapModel.get(currentIndex)["mapName"])
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
            left: parent.left; top: layerTitle.bottom
            right: parent.right;
            margins: 20
        }
    }


}

