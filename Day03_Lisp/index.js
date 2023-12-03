
const fs = require('fs')

var numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
var coors = [];



function find(currentNum, x, y, lines, numOfDigits) {
    var initX = x - numOfDigits - 1;
    var initY = y - 1;
    console.log(currentNum, x, y, initX, initY);

    for(var ny = initY; ny <= initY + 2; ny++) {
        for(var nx = initX; nx <= x; nx++) {
            var coor = coors.find(c => c.x === nx && c.y === ny);
            console.log(coor, nx, ny);
            if(coor !== undefined) {
                coor.nums.push(currentNum);
                break;
            }
        }
    }
}

function findGear(currentNum, x, y, lines) {
    var numOfDigits = currentNum.toString().length;
    find(currentNum, x, y, lines, numOfDigits);
}


fs.readFile('input1.txt', 'utf-8', (err, data) => {
    lines = data.split('\n');

    for (var [y, line] of lines.entries()) {
        for (let x = 0; x < line.length; x++) {
            if (line[x] === '*') {
                coors.push({ x: x, y: y, nums: [] })
            }
        }
    }

    var currentNum = 0;
    for (var [y, line] of lines.entries()) {
        for (let x = 0; x < line.length; x++) {
            var ch = line[x];
            if (ch >= '0' && ch <= '9') {
                var i = parseInt(ch);
                currentNum = currentNum * 10 + i;
            } else {
                if (currentNum !== 0) {
                    findGear(currentNum, x, y, lines);
                    currentNum = 0;
                }
            }
        }
    }

    console.log(coors);
    
    var selected = coors.filter(c => c.nums.length === 2);
    // console.log(selected.length);
    // console.log(selected);

    var sum = 0;
    selected.forEach(c => {
        var a = c.nums[0];
        var b = c.nums[1];
        var s = a * b;
        sum += s;
        // console.log(s, sum);
    });

    console.log(sum);
})