const fs = require('fs');

const cards = [
  'A', 'K', 'Q', 'T',
  '9', '8', '7', '6', '5',
  '4', '3', '2', 'J'];

fs.readFile('input.txt', 'utf-8', (err, data) => {
  if (err) {
    console.error(err);
    return;
  }

  const lines = data
    .split('\r\n')
    .map(s => s.split(' '))
    .map(d => {
      return {
        hand: d[0],
        bet: d[1]
      };
    })
    .map(d => {
      const count = {};
      for (const ch of d.hand) {
        if (count[ch]) {
          count[ch].count++;
        } else {
          count[ch] = {
            ch: ch,
            count: 1
          };
        }
      }
      d.count = Object.values(count);
      d.count.sort((a, b) => cards.indexOf(a.ch) - cards.indexOf(b.ch));
      return d;
    })
    .map(d => {
      if(checkFull(d)) return d;
      if(checkFourAndFullHouse(d)) return d;
      if(checkThreeOfTwoPair(d)) return d;
      if(checkSecond(d)) return d;
      if(checkHigh(d)) return d;
      
      return d;
    })
    .sort((a, b) => {
      const result = a.score - b.score;
      if (result !== 0) return result;
      
      for (let i = 0; i < 5; i++) {
        const c1 = cards.indexOf(a.hand[i]);
        const c2 = cards.indexOf(b.hand[i]);
        // console.log(c1, c2);
        const result = c2 - c1;
        if (result !== 0) return result;
      }
    })
    .map(((d, index) => {
      d.winning = d.bet * (index + 1);
      return d;
    }));

  let sum = 0;
  for (let i = 0; i < lines.length; i++) {
    console.log(lines[i]);
    sum += lines[i].winning;
  }

  console.log(sum);
});

function checkFull(d) {
  if (d.count.length === 1) {
    d.score = 7000;
    return true;
  }
  
  if(d.count.length === 2) {
    var njokers = getJokers(d);
    var cards = d.count[0].count + njokers;
    if(cards == 5) {
      d.score = 7000;
      return true;
    }
  }

  return false;
}

function checkFourAndFullHouse(d) {
  if(d.count.length === 2) {
    if (d.count[0].count === 1 || d.count[0].count === 4) {
      d.score = 6000;
      return true;
    }

    if (d.count[0].count === 2 || d.count[0].count === 3) {
      d.score = 5000;
      return true;
    }
  }

  if(d.count.length === 3) {
    var njokers = getJokers(d);
    if(njokers === 1) {
      if (d.count[0].count === 1 || d.count[0].count === 3) {
        d.score = 6000;
        return true;
      }
  
      if (d.count[0].count === 2) {
        d.score = 5000;
        return true;
      }
    }

    if(njokers >= 2) {
      d.score = 6000;
      return true;
    }
  }
  
  return false;
}

function checkThreeOfTwoPair(d) {
  var njokers = getJokers(d);

  if(njokers === 0) {
    if (d.count.length !== 3) return;

    // three
    const c = d.count.find(item => item.count === 3);
  
    if (c !== undefined) {
      d.score = 4000;
      return;
    }
  
    // two pair
    d.score = 3000;
    return true;
  }

  if (d.count.length === 4) {
      d.score = 4000;
      return true;
  }
  
  return false;
}

function checkSecond(d) {
  var njokers = getJokers(d);
  if(njokers === 0) {
    if (d.count.length !== 4) return false;

    d.score = 2000;
    return true;
  }
}

function checkHigh(d) {
  var njokers = getJokers(d);
  if(njokers === 0) {
    if (d.count.length !== 5) return false;

    d.score = 1000;
    return true;
  }

  if(njokers === 1) {
    d.score = 2000;
    return true;
  }

  return false;
}

function getJokers(d) {
  console.log(d);
  var jokers = d.count.find(item => item.ch === 'J');
  return jokers?.count ?? 0;
}