#!/usr/bin/env node

/* This thing takes the main Webb algorithm's matrix output
 * and analyzes it for the network's topology. */

var fs = require('fs'),
    result = "",
    resultArray,
    links = [],
    pop_size;

// accept data through STDIN 
process.stdin.resume();
process.stdin.setEncoding('utf8');
process.stdin.on('data', function(data) {
    result += data;
});

// begin processing
process.stdin.on('end', function() {
    
    if (!result) {
        console.error("Data must be passed through STDIN!");
        process.exit();
    }
    
    result = result.substring(8,result.length - 2); // so in the form "1.0, 1.0, 1.0], [1.0, 1.0, 1.0" and so on
    
    var resultArray = result.split("], ["); // so each element in the form 1.0, 1.0, 1.0 and so on
    
    resultArray.forEach(function(string){
        links.push(string.split(","));
    });
    
    // count number of nodes in population
    pop_size = resultArray.length;
  
    // now links is the parsed network
    // for each node count connections one-way
    var topology_array = [];
    for (var i = 0; i < pop_size; i ++) {
        var total = links[i].reduce(function(pre, cur) {
            return parseFloat(pre) + parseFloat(cur);
        });

        topology_array.push(total / pop_size);
    }

    // console.log(topology_array);
   
    topology_array.forEach(function(val) {
        var line = "  | ",
            adjVal = val * 100;
        for (i = 0; i < adjVal; i ++ ) {
            line += "=";
        }
        console.log(line + "  " + (Math.floor(val * 100) / 100).toString());
    });

});
