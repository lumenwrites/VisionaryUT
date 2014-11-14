import QtQuick 2.0
import Ubuntu.Components 1.1

Item {
    id: root
    height: units.gu(8)
    width: units.gu(32)

    property int nodeId: 0
    property var children: []

    property alias nodeShape: nodeShape
    property alias
    title: nodeTitle.text

    Rectangle {
        anchors.horizontalCenter: parent.horizontalCenter
        height: units.gu(6)
        id: nodeShape
        color: Qt.lighter(UbuntuColors.coolGrey)
        radius: 4
        border.width: 0
        border.color: Qt.lighter(UbuntuColors.coolGrey, 4)
        width: nodeTitle.paintedWidth + units.gu(4)
    }

    Item {
        anchors.fill: parent
        anchors.margins: units.gu(2)
        TextEdit {
            id: nodeTitle
            anchors.horizontalCenter: parent.horizontalCenter
            activeFocusOnPress: false
            text: "Node Title"
            color: "white"
            onFocusChanged:{
                nodeMouseArea.enabled = !nodeTitle.focus
            }
        }

    }

    MouseArea {
        id: nodeMouseArea
        anchors.fill: nodeShape
        drag.target: parent

        onClicked: {
            parent.focus = true
            if (map.linking) {
                //console.log("Tap! Id: " + parent.nodeId)
                //console.log("Seleted node: " + map.nodes[selectedNode].children)
                map.nodes[selectedNode].children.push(parent.nodeId)
                map.nodes[selectedNode].nodeShape.border.width = 0
                map.linking = false
                canvas.requestPaint()
            } else if (map.deleting) {
                map.nodes[parent.nodeId].destroy()
                canvas.requestPaint()

                map.deleting = false
                toolbar.deleteNode.border.width = 0

            }
        }
        onPressAndHold: {
            map.selectedNode = parent.nodeId
            map.linking = true
            nodeShape.border.width = 2
            console.log("Tap! Id: " + map.selectedNode)
            console.log("Linking : " + map.linking)


        }

        onDoubleClicked: {
            nodeTitle.focus = true
        }
        onPositionChanged: {
            canvas.requestPaint()
        }
    }




}