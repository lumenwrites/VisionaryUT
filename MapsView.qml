import QtQuick 2.0
import Ubuntu.Components 1.1
import U1db 1.0 as U1db

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

    Rectangle{
        anchors.fill: parent
        id: node
        color: Qt.darker(UbuntuColors.coolGrey)
    }

    ListView {
        //orientation: ListView.Horizontal
        anchors.fill: parent
        model: modelQuery
        delegate: MapItem {
            mapTitle: model.contents.savedMapData.mapTitle //model.docId
            nodes: model.contents.savedMapData.nodes
        }
    }

}