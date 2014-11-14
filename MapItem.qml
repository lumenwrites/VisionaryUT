import QtQuick 2.0
import Ubuntu.Components 1.1
import U1db 1.0 as U1db
import "logic.js" as Logic

Item {
    id: root
    width: units.gu(10)
    height: units.gu(10)

    property alias mapTitle: mapTitle.text
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
                    console.log("Map Data: " + savedNodes[1].y)
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
                PopupUtils.open(itemPopoverComponent, drawingItem);
            }
            // Component {
            //     id: itemPopoverComponent
            //     Popover {
            //         id: itemPopover
            //         Column {
            //             anchors {
            //                 top: parent.top
            //                 right: parent.right
            //                 left: parent.left
            //             }
            //             ListItem.Standard {
            //                 text: i18n.tr("delete");
            //                 onTriggered: {
            //                     mirageDB.putDoc("", model.docId)
            //                     print("deleted")
            //                 }
            //             }
            //         }
            //     }
            // }
        }
    }

    Text {
        id: mapTitle
        //anchors.top: mapItemShape.bottom
        //anchors.horizontalCenter: mapItemShape.horizontalCenter
        anchors.left: mapItemShape.right
        anchors.verticalCenter: mapItemShape.verticalCenter
        anchors.margins: units.gu(1)
        color: "white"
        text: "Map Title"
        wrapMode: Text.Wrap
        width: units.gu(32)
    }

}