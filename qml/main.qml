import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import FileIO 1.0
import QtQuick.Dialogs.qml 1.0


Item {
    visible: true
    width: 640
    height: 480

    Connections {
        target: applicationData
        onMapPanelDataChanged: {
            console.log("Got map changed " + applicationData.mapPanelData)
            onMapPanelDataChanged(applicationData.mapPanelData)
        }
    }

    // called when IW calls setMapPanelData()
    function onMapPanelDataChanged(map) {

        suitabilityMap.jsonFile = JSON.parse(map);
        console.log(suitabilityMap.jsonFile);
    }

    SuitabilityMap {
        id : suitabilityMap
        anchors.fill: parent

    }

}
