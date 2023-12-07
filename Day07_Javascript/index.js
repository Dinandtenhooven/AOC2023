const fs = require('fs');

const cards = [
  'A', 'K', 'Q', 'J', 'T',
  '9', '8', '7', '6', '5',
  '4', '3', '2'];

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
      return d;
    })
    .map(d => {
      checkFull(d);
      checkFourAndFullHouse(d);
      checkThreeOfTwoPair(d);
      checkSecond(d);
      checkHigh(d);
      return d;
    })
    .sort((a, b) => {
      const result = a.score - b.score;
      if (result !== 0) return result;

      for (let i = 0; i < 5; i++) {
        const c1 = cards.indexOf(a.hand[i]);
        const c2 = cards.indexOf(b.hand[i]);
        console.log(c1, c2);
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
  }
}

function checkFourAndFullHouse(d) {
  if (d.count.length !== 2) return;

  if (d.count[0].count === 1 || d.count[0].count === 4) {
    d.score = 6000;
    return;
  }

  // full house
  d.score = 5000;
}

function checkThreeOfTwoPair(d) {
  if (d.count.length !== 3) return;

  // three
  const c = d.count.find(item => item.count === 3);

  if (c !== undefined) {
    d.score = 4000;
    return;
  }

  // two pair
  d.score = 3000;
}

function checkSecond(d) {
  if (d.count.length !== 4) return;
  d.score = 2000;
}

function checkHigh(d) {
  if (d.count.length !== 5) return;
  d.score = 1000;
}
