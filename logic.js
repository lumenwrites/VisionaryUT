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

function saveMapData(){
    //console.log("x " + map.nodes[1].y)

    // Save into variable
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

    // console.log("Saved Data: " + map.savedMapData)
    // console.log("Saved Node Title: " + map.savedMapData[0].title)

    // Save into DB
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
          "mapTitle":"My Map Title!"}}

}
