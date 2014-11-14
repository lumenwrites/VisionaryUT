import QtQuick 2.0
import Ubuntu.Components 1.1
import U1db 1.0 as U1db
import "logic.js" as Logic

Item {
    id: root
    width: units.gu(10)
    height: units.gu(10)

    property string mapTitle
    property var nodes
    UbuntuShape {
        anchors.fill:parent
        anchors.margins: units.gu(1)
        id: mapItemShape
        image: Image {
            //source: contents.src
        }
        color:  Qt.lighter(UbuntuColors.coolGrey)
        MouseArea {
            id: input
            anchors.fill: parent
            onClicked: {
                //console.log("Saved Nodes: " + root.nodes)
                restoreNodes(root.nodes)

                function restoreNodes(savedNodes) {
                    //console.log("Map Data: " + savedNodes[1].y)
                    //console.log("x " + savedNodes[1].y)
                    Logic.clearCanvas()

                    map.nodes = []
                    var n = 0
                    for (n=0; n < savedNodes.length; n++ ){
                        var nodeData = savedNodes[n]
                        map.createNode(nodeData.x, nodeData.y, nodeData.title, nodeData.children)
                    }
                    map.canvas.requestPaint()
                }

            }
            onPressAndHold: {
                // visionaryDB.putDoc("", model.docId)
                // print("deleted")
            }
        }
    }

    TextEdit {
        id: mapTitle
        //anchors.top: mapItemShape.bottom
        //anchors.horizontalCenter: mapItemShape.horizontalCenter
        anchors.left: mapItemShape.right
        anchors.verticalCenter: mapItemShape.verticalCenter
        anchors.margins: units.gu(1)
        color: "white"
        text: root.mapTitle
        wrapMode: Text.Wrap
        width: units.gu(20)

        onFocusChanged: {
            //root.mapTitle =
        }
    }


    Rectangle {
        id: deleteMap
        anchors.verticalCenter: mapItemShape.verticalCenter
        anchors.left: mapTitle.right
        width: units.gu(4)
        height: units.gu(4)

        color: Qt.lighter(UbuntuColors.coolGrey)

        Image {
            id: icon
            anchors.fill: parent
            anchors.margins: 2
            source: "icons/delete-node.png"
        }

        MouseArea {
            id: mousearea
            anchors.fill: parent
            onClicked: {
                visionaryDB.putDoc("", model.docId)
                print("deleted")
            }

        }

    }

}