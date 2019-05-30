import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.3


Rectangle {
    id: mapSelector

    width: 200
    height: 60

    Frame {
        id: frame
        width: 60
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        Layout.fillHeight: true

        Image {
            id: image
            anchors.leftMargin: 0
            anchors.fill: parent
            source: "map-junk.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    ComboBox {
        id: comboBox
        width: 80
        anchors.right: button.left
        anchors.rightMargin: 70
        anchors.verticalCenter: parent.verticalCenter
    }

    Switch {
        id: mapOn
        width: 50
        display: AbstractButton.IconOnly
        anchors.left: comboBox.right
        anchors.leftMargin: 12
        anchors.verticalCenter: parent.verticalCenter
    }

    Button {
        id: button
        width: 20
        height: 20
        text: qsTr("")
        focusPolicy: Qt.StrongFocus
        checkable: true
        display: AbstractButton.IconOnly
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 5
        visible: true
        Layout.fillHeight: false
        Layout.fillWidth: false
    }

}

