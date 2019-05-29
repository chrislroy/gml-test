import QtQuick 2.12
import QtQuick.Window 2.12
import FileIO 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    FileIO {
        id: myFile
        source: "E:\\dev\\qml-dynamiclist\\data\\b71d55ae-543c-490c-b660-b0dd16800763.json"
        onError: console.log(msg)
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
    }


    DynamicList {
        id : test
        anchors.fill: parent

    }

}
