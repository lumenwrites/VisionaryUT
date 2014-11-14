import QtQuick 2.0
import Ubuntu.Components 1.1

Item {
    id: root
    anchors {
        top: parent.top
        right: parent.right
        bottom: parent.bottom
    }

    width: parent.width/3
    z: 10

    Rectangle{
        anchors.fill: parent
        id: node
        color: Qt.darker(UbuntuColors.coolGrey)
    }
}