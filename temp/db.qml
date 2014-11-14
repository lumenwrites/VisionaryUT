import QtQuick 2.0
import Ubuntu.Components 1.1
import U1db 1.0 as U1db

MainView {

    Page {
        id: root

        // Create Database
        U1db.Database {
            id: myDB
            path: "myDatabase.u1db"
        }

        // Create Document
        U1db.Document {
            id: myDocument // to refer to it within qml
            database: myDB
            docId: 'filename' // displayed in database
            create: true
            defaults: { "textString":"Hello Awesome World!!!" }

        }

        // Display Document contents
        Text {
            id: text
            text: myDocument.contents.textString
        }

        // Creating a document dynamically
        Button {
            x: 300
            text: "Create Document"
            onClicked: {

                // Create a document by copying an existing one(that's what template is for.
                function createDocument() {
                    var document = {}
                    document = myDocument
                    document.docId = "newDoc" //document name
                    document.contents = {"textString": "Document I've just created!!"}
                }
                createDocument()
            }
        }

        // Awesome, all that's left is to query document by id.
        Button {
            x: 500
            text: "Open Document"
            onClicked: {

                // Create a document by copying an existing one(that's what template is for.
                function openDocument() {
                    var docContent = {}
                    docContent =  myDocument.contents
                    console.log(docContent.textString)
                }
                openDocument()
            }
        }

        // Load Data

    }
}