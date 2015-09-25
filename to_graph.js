#!/usr/bin/env node
/* This thing takes the main Webb algorithm's matrix output
 * and turns it into vector graphics. */

var fs = require('fs'),
    result,
    resultArray,
    node_coords = [],
    links = [],
    pop_size;

// Taking matrix input file, parse variables

// for now, for testing
var result = "Matrix[]";

result = result.substring(8,result.length - 2); // so in the form "1.0, 1.0, 1.0], [1.0, 1.0, 1.0" and so on

var resultArray = result.split("], ["); // so each element in the form 1.0, 1.0, 1.0 and so on
resultArray.forEach(function(string){
    links.push(string.split(", "));
});

// count number of nodes in population
pop_size = resultArray.length;

// have node coordinates put in array of duples
var angle = Math.PI / pop_size * 2;
for(i=0;i<pop_size;i++){
    node_coords.push([500 - 500 * Math.sin(angle * i).toString(), 500 - 500 * Math.cos(angle * i).toString()]);
}

// have segment startNode, endNode, strength in array, will resolve node coordinates from node list
var maximum=0.0;
var minimum=1.0;
var linkc = links;
for(i=0; i<pop_size; i++){
    for(j=0; j<pop_size; j++){
        links[i][j] = parseFloat(links[i][j]);
    }
}
for(i=0; i<pop_size; i++){
    for(j=0; j<pop_size; j++){
        links[i][j] = Math.sqrt(linkc[i][j] * linkc[j][i]);
    }
}
for(i=0; i<pop_size; i++){
    for(j=0; j<pop_size; j++){
        if(i!=j){
            if(links[i][j]>maximum){maximum = links[i][j]}
            if(links[i][j]<minimum){minimum = links[i][j]}
    
        }
    }
}

// will write SVG line by line
SVGlines = ["<svg xmlns='http://www.w3.org/2000/svg' version='1.0' viewBox='0 0 1000 1000'>"];

// write lines first
var writtenlines = ""
SVGlines.push("<!-- connections -->");
for(i=0;i<pop_size;i++){
    for(j=0;j<pop_size;j++){
        writtenlines+="0x"+node_coords[i]+"x0"+node_coords[j];
        if(writtenlines.indexOf("0x"+node_coords[j]+"x0"+node_coords[i])==-1){
            SVGlines.push("<line x1='" + node_coords[i][0] + "' y1='" + node_coords[i][1] + "' x2='" + node_coords[j][0] + "' y2='" + node_coords[j][1] + "' style='stroke:#000;stroke-width:2;opacity:" + (((links[i][j] - minimum) / (maximum - minimum)) + 0.0).toString() + "'/>");
        }
    }
}

// write nodes later
SVGlines.push("<!-- nodes -->");
node_coords.forEach(function(coord){
    SVGlines.push("<circle cy='" + coord[1] + "' cx='" + coord[0] + "' r='10' style='fill:#5200A3'/>");
});

// below is all good, writing to files everything front-back
fs.writeFile("graph.svg", "", function(err) {
    if(err) {return console.log(err);}
});

SVGlines.forEach(function(line){
    // this is the end
    fs.appendFile("graph.svg", line, function(err) {
        if(err) {
            return console.log(err);
        }
        
    });
});

fs.appendFile("graph.svg", "</svg>", function(err) {
    if(err) {return console.log(err);}
});
          
console.log("Graph Saved!");
