#!/usr/bin/env node

// init
const n = parseInt(process.argv[2]);
if (!process.argv[2]) throw "ERROR: please provide a dimension for the matrix, followed by [variance x.xx]";
if (isNaN(n)) throw "ERROR: Pleae provide a number as the dimension for the matrix";

var variance = 0;
if (process.argv[3] == "variance") {
    variance = parseFloat(process.argv[4]);
}

// generate rows
function makeRow() {
    var row = "[";
    var tempVariance;
    for (j = 0; j < n - 1; j ++) {
        tempVariance = Math.random() < 0.5 ? Math.random() * variance : Math.random() * -1 * variance;
        row += (1 + tempVariance).toString() + ", ";
    }

    tempVariance = Math.random() < 0.5 ? Math.random() * variance : Math.random() * -1 * variance;
    row += (1 + tempVariance).toString() + "]";

    return row;
}

var matrix = "Matrix[";
// generate matrix
for (i = 0; i < n - 1; i ++) {
    matrix += makeRow() + ", ";
}
matrix += makeRow() + "]";

console.log(matrix);
