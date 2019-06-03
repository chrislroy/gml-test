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
        myFile.source = map;
        suitabilityMap.jsonFile = myFile.read();
    }

    FileIO {
        id: myFile
        source: ""
        onSourceChanged:  {
            console.log("onSourceChanged called")
            var data = myFile.read();
            suitabilityMap.jsonFile = data;
        }

        onError: console.log(msg)
    }

    SuitabilityMap {
        id : suitabilityMap
        anchors.fill: parent

    }

}
