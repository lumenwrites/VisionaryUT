import QtQuick 2.0
import Ubuntu.Components 1.1
import "logic.js" as Logic

Item {
    id: root

    property alias deleteNode: deleteNode
    anchors {
        top: parent.top
        left: parent.left
        bottom: parent.bottom
    }

    width: units.gu(6)
    z: 10

    Rectangle{
        anchors.fill: parent
        id: node
        color: Qt.darker(UbuntuColors.coolGrey)
    }

    Column {
        anchors.fill:parent
        anchors.margins: units.gu(1)
        spacing: units.gu(1)


        ToolbarSmallButton {
            id: saveMap
            anchors.horizontalCenter: parent.horizontalCenter
            border.color: Qt.lighter(UbuntuColors.coolGrey, 3)
            border.width: 0

            onClicked: {
                Logic.saveMapData()

                // Blink to show I'm saving
                border.width = 2
                delay.start();

            }
            color: Qt.lighter(UbuntuColors.coolGrey)
            iconSource: "icons/save-icon.png"

            Timer {
                id: delay
                repeat: false
                interval: 500
                onTriggered: {
                    saveMap.border.width = 0
                }
            }
        }

        ToolbarSmallButton {
            id: clearCanvas
            anchors.horizontalCenter: parent.horizontalCenter
            border.color: Qt.lighter(UbuntuColors.coolGrey, 3)
            border.width: 0
            onClicked: {
                Logic.clearCanvas()
                // var n = 0
                // for (n=0; n < map.nodes.length; n++ ){
                //     map.nodes[n].destroy()
                // }
                // map.canvas.requestPaint()
            }
            color: Qt.lighter(UbuntuColors.coolGrey)
            iconSource: "icons/delete-all.png"
        }


        ToolbarSmallButton {
            id: deleteNode
            anchors.horizontalCenter: parent.horizontalCenter
            border.color: Qt.lighter(UbuntuColors.coolGrey, 3)
            border.width: 0
            onClicked: {
                if (map.deleting == false) {
                    map.deleting = true
                    border.width = 2
                } else {
                    map.deleting = false
                    border.width = 0
                }
            }
            color: Qt.lighter(UbuntuColors.coolGrey)
            iconSource: "icons/delete-node.png"
        }
    }
}