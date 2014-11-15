import QtQuick 2.0
import Ubuntu.Components 1.1
import U1db 1.0 as U1db
import "logic.js" as Logic
Item {
    id: root
    anchors {
        top: parent.top
        left: toolbar.right
        //right: parent.right
        bottom: parent.bottom
    }

    //height: units.gu(14)*5
    width: units.gu(36)
    z: 10

    visible: false

    Rectangle{
        anchors.fill: parent
        id: node
        color: Qt.darker(UbuntuColors.coolGrey)
    }

    UbuntuShape {
        id: createNewMap
        anchors.left:parent.left
        y: units.gu(2)
        anchors.margins: units.gu(1)
        image: Image {
            anchors.margins: units.gu(2)
            source: "icons/plus.png"
        }
        color:  Qt.lighter(UbuntuColors.coolGrey, 3)
        MouseArea {
            id: input
            anchors.fill: parent
            onClicked: {
                Logic.createNewMap()
            }
        }
    }


    ListView {
        //orientation: ListView.Horizontal
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            top: createNewMap.bottom
        }
        model: modelQuery
        delegate: MapItem {
            savedMapDocument: model
            // mapTitle: model.contents.savedMapData.mapTitle //model.docId
            // nodes: model.contents.savedMapData.nodes
        }
    }
}