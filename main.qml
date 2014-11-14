import QtQuick 2.0
import Ubuntu.Components 1.1
import U1db 1.0 as U1db

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "com.ubuntu.developer.rayalez.visionary"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(100)
    height: units.gu(75)

    Page {
        MapsView {
            id: mapsView
        }
        Toolbar {
            id: toolbar
        }
        Map {
            id: map
            anchors {
                top: parent.top
                right: parent.right
                left: toolbar.right
            }
        }
        // NodeInfo {
        //     id: nodeInfo
        // }
    }


    // Create database
    U1db.Database {
        id: visionaryDB
        path: "visionary.u1db"
    }

    // Create Document
    U1db.Document {
        id: mindMapTemplate
        docId: "template"
        database: visionaryDB
    }

    U1db.Index {
        database: visionaryDB
        id: by_src
        //expression: ["src"]
        expression: ["savedMapData"]
    }

    U1db.Query {
        id: modelQuery
        index: by_src
        //query: [{"src":"*"}]
        query: [{"savedMapData":"*"}]
    }

}
