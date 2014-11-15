function clearCanvas(){
    //console.log("Nodes length to destroy: " + map.nodes.length)
    if (map.nodes.length > 0) {

	var n = 0
	// console.log("map.nodes before destroy: " + map.nodes)
	// console.log("savedMapData before destroy: " + map.savedMapData)
        for (n=0; n < map.nodes.length; n++ ){
            map.nodes[n].destroy()
        }
        // console.log("map.nodes after destroy: " + map.nodes)
        // console.log("savedMapData before destroy: " + map.savedMapData)

	map.nodes = []
        map.canvas.requestPaint()
    }
}

function createNewMap(){
    clearCanvas()

    var date = new Date()
    var docName = Qt.formatDateTime(date, "yyMMddhhmmss");
    //only one map
    //docName = "MindMapName"

    var document = {}
    document = mindMapTemplate
    document.docId = docName //"MindMapName"
    document.contents =
        {"savedMapData":
         {"nodes": map.savedMapData,
          "mapTitle":"My New Map"}}

    map.openedDocument = document.docId
    map.mapTitle.text = document.contents.savedMapData.mapTitle

    //Create Central Node
    map.createNode(map.canvas.width/2, map.canvas.height/2, "Main Node", [])
}

function saveMapData() {
    // Save into variable
    map.savedMapData = []
    var n = 0
    for (n=0; n < map.nodes.length; n++ ){
        var nodeData = {
            x: map.nodes[n].x,
            y: map.nodes[n].y,
            title: map.nodes[n].title,
            children: map.nodes[n].children
        }
        map.savedMapData.push(nodeData)
    }

    // Save into database
    if (!map.openedDocument) {
	var date = new Date()
	var docName = Qt.formatDateTime(date, "yyMMddhhmmss");
	map.openedDocument = docName

    }
    var document = {}
    document = mindMapTemplate
    document.docId = map.openedDocument
    document.contents = {"savedMapData":
         {"nodes": map.savedMapData,
          "mapTitle": map.mapTitle.text}}
    //console.log("Saved Nodes: " + map.savedMapData)
}

function openMap(savedMapDocument) {
    var savedMapData = savedMapDocument.contents.savedMapData
    var savedNodes = savedMapData.nodes
    //console.log("Restoring Nodes: " + map.savedMapData.nodes)

    clearCanvas()
    map.nodes = []

    var n = 0
    for (n=0; n < savedNodes.length; n++ ){
        var nodeData = savedNodes[n]
	if (nodeData.children) {
            map.createNode(nodeData.x, nodeData.y, nodeData.title, nodeData.children)
	} else {
	    map.createNode(nodeData.x, nodeData.y, nodeData.title, [])
	}
    }
    map.canvas.requestPaint()

    map.openedDocument = savedMapDocument.docId
    map.mapTitle.text = savedMapDocument.contents.savedMapData.mapTitle
}
