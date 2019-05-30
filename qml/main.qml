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
            console.log("Got map changed")
            console.log(applicationData.map)
            mapChanged(applicationData.map)
        }
    }

    function mapChanged(map) {
        console.log(map);
        myFile.source = map;
        test.jsonFile = myFile.read();
    }

    FileIO {
        id: myFile
        source: "" //"E:\\dev\\qml-dynamiclist\\data\\b71d55ae-543c-490c-b660-b0dd16800763.json"
        onSourceChanged:  {
            console.log("onSourceChanged called")
            var data = myFile.read();
            test.jsonFile = data;
        }

        onError: console.log(msg)
        /*
        Component.onCompleted: {
            var data = myFile.read();
            test.jsonFile = data;
            var obj = JSON.parse(data);
            var softs = obj["SoftCostLayers"];
            for (var i in softs) {
                console.log(softs[i]["DisplayName"]);
            }
            console.log("completed")
        }
        */
    }



    DynamicList {
        id : test
        anchors.fill: parent

    }

}
