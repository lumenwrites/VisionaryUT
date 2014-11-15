import QtQuick 2.0
import Ubuntu.Components 1.1
import "logic.js" as Logic

Item {
    id: root
    anchors.fill: parent

    property var openedDocument
    property alias canvas: canvas
    property alias mapTitle: mapTitle
    property int selectedNode: 0
    property bool linking: false
    property bool deleting: false
    property var nodes: []
    property var savedMapData: []

    Component.onCompleted: {
        //Logic.createNewMap()

        // Create nodes
        map.createNode(parent.width/2, canvas.height/2, "Main Node", [])
        //why canvas.width and not with/2 ??

        // createNode(300, 300, "Node 1", [1, 2])
        // createNode(200,400, "Node 2", [])
        // createNode(400,400, "Third Node", [])
    }

    Rectangle {
        anchors.fill: parent
        color: UbuntuColors.coolGrey
    }

        // Rectangle {
        //     anchors.fill: parent
        //     color: Qt.darker(UbuntuColors.coolGrey)
        //     radius: 4
        // }

        TextEdit {
            id: mapTitle
            anchors.horizontalCenter: canvas.horizontalCenter
            y: units.gu(1)
            height: 40
            z: 20
            color: "white"
            text: "My New Map"//"Temp"

            onFocusChanged: {
                Logic.saveMapData()
            }
        }

    // Test Buttons
    // Button {
    //     x: units.gu(6)
    //     y: units.gu(14)
    //     text: "List Nodes"
    //     z: 12
    //     onClicked: {
    //         var n = 0
    //         for (n = 0; n < root.nodes.length; n++) {
    //             console.log("Node Id: " + root.nodes[n].nodeId)
    //             console.log("Node Children: " + root.nodes[n].children)
    //         }
    //     }
    // }

    // Button {
    //     x: units.gu(20)
    //     y: units.gu(14)
    //     text: "Restore Nodes"
    //     z: 12
    //     onClicked: {
    //         restoreNodes()
    //     }
    // }



    // Button {
    //     x: units.gu(38)
    //     y: units.gu(14)
    //     text: "Save To DB"
    //     z: 12
    //     onClicked: {
    //         var date = new Date()
    //         var docName = Qt.formatDateTime(date, "yyMMddhhmmss");
    //         //only one map
    //         docName = "MindMapName"

    //         var document = {}
    //         document = mindMapTemplate
    //         document.docId = docName //"MindMapName"
    //         document.contents =
    //         {"savedMapData":
    //         	{"nodes":"Map Data[]",
    //          	 "mapTitle":"My Map Title!"}}
    //     }
    // }


    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d")

            ctx.lineWidth = 1
            ctx.strokeStyle = "steelblue"

            ctx.clearRect(0,0,width,height)

            // ctx.closePath()


            //console.log("Node 0 Id : " + root.nodes[0].nodeId)

            if (root.nodes.length > 0) {
                var n = 0
                for (n = 0; n < root.nodes.length; n++) {
                    // console.log("Node Id: " + root.nodes[n].nodeId)
                    // console.log("Node Children: " + root.nodes[n].children)
                    var node = root.nodes[n]
                    if (node.children.length > 0) {
                        var c = 0
                        for (c = 0; c < node.children.length; c++) {
                            var childId = node.children[c]
                            var child = root.nodes[childId]
                            //console.log("Child: " + childId)
                            ctx.beginPath()
                            ctx.moveTo(node.x+units.gu(16),node.y+units.gu(4))
                            ctx.lineTo(child.x+units.gu(16),child.y+units.gu(4))
                            ctx.stroke()
                        }
                    }
                }
            }

        }

        MouseArea{
            id: canvasMouseArea
            anchors.fill: parent
            onClicked: {
                parent.focus = true
                map.linking = false
                nodes[selectedNode].nodeShape.border.width = 0

                mapsView.visible = false
                //createNode(mouseX, mouseY, [])
            }
            onPressAndHold: {
                createNode(mouseX-units.gu(16), mouseY-units.gu(4),"Node Title", [])
            }
        }
    }



    function createNode(x, y, title, children) {
        var component = Qt.createComponent("Node.qml");
        var node = component.createObject(root,
        {"x": x,
        "y": y,
        "nodeId": root.nodes.length,
        "title": title,
        "children": children
    });
    root.nodes.push(node)
    // console.log("Nodes: " + root.nodes)
    // console.log("Nodes.length : " + root.nodes.length)
    // console.log("Node id : " + node.nodeId)
    // console.log("Node children : " + node.children)
    }

    // function restoreNodes() {
    //     //console.log("Map Data: " + map.savedMapData)
    //     console.log("x " + map.savedMapData[1].y)

    //     map.nodes = []
    //     var n = 0
    //     for (n=0; n < map.savedMapData.length; n++ ){
    //         var nodeData = map.savedMapData[n]
    //         createNode(nodeData.x, nodeData.y, nodeData.title, nodeData.children)
    //     }
    //     canvas.requestPaint()
    // }

}