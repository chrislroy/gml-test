import QtQuick 2.0

Item {

    id: layerList
    ListModel {
        id: layerModel
    }

    // functions
    function toQrc(s) {
        return s.replace("img://file/", "file:///");
    }

    function addLayer(layerObj) {
        layerModel.append({
            "object" : layerObj,
            "name": layerObj["DisplayName"],
            "weight": layerObj["Weight"],
            "thumbnail": layerObj["Thumbnail"]
        });
    }

    function clearModel() {
        console.log("Clearing model")
        layerModel.clear();
    }

    function isArray (value) {
        return value && typeof value === 'object' && value.constructor === Array;
    }

    Component {
        id: layerDelegate

        Layer {
            id: layer
            width: 400
            height: 80
        }
    }

    // The view:
    ListView {
        id: layerView
        model: layerModel
        delegate: layerDelegate
    }


}