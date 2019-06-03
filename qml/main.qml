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
        onMapChanged: {
            console.log("Got map changed " + applicationData.map)
            onMapChanged(applicationData.map)
        }
    }

    function onMapChanged(map) {
        console.log(map);

        suitabilityMap.jsonFile = map;
    }

    SuitabilityMap {
        id : suitabilityMap
        anchors.fill: parent

    }

}
