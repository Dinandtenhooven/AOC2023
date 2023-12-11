const fs = require('fs');

fs.readFile('input.txt', 'utf-8', (err, data) => {
    var lines = data.split("\r\n");
    // console.log(lines);

    var leftRight = lines[0];
    var groups = lines.splice(2).map(l => {
        return {
            a: l.slice(0, 3),
            b: l.slice(7, 10),
            c: l.slice(12, 15)
        }
    });

    var currents = groups
        .filter(g => g.a.endsWith('A'))
        .map(g => g.a);


    for(var n = 0; n < currents.length; n++) {
        var current = currents[n];
        var i = 0;
        var count = 0;
    
        while(current.endsWith('Z') === false) {
            var char = leftRight[i];
            var group = groups.find(g => g.a === current);
            
            current = char === 'L' ? group.b : group.c;
                
            i++;
            count++;
                
            if(i === leftRight.length) {
                i = 0;
            }
        }

        console.log(count, current);
    }
    console.log(leftRight.length);
});


