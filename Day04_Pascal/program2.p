program HelloWorld(output);

Uses sysutils;

Type  
  TA = Array of String;  

const
  C_FNAME = 'example.txt';

var
  tfOut: TextFile;
  s: String;
  i: Integer;
  sum: longInt;
  cards: Array[0..218] of longInt;
  

function parseLine(line: string; count: integer): integer;
var
  i: Integer;
  j: Integer;
  c: longInt;
  cd: Integer;
  wins: TA;
  guesses: TA;
  score: Integer;
  scored: Integer;
  w: string;
  g: string;
  userInput: string;
  fmt1: string;
  fmt2: string;
  row1: string;

begin
  SetLength(wins, 10);
  SetLength(guesses, 25);
  score := 0;

  for i:= 0 to 9 do 
    wins[i] := copy(line, 3 * i + 10, 3);

  for i:= 0 to 24 do 
    guesses[i] := copy(line, 3 * i + 42, 3);

  for w in wins do
    for g in guesses do
      if w = g then
          score := score + 1;

  c := cards[count + 1];

  sum := sum + c;
  Writeln('Next line to process:');
  Writeln(line);
  Writeln(count);
  Writeln(score);
  Writeln(c);
  Writeln('______________');
  if score >= 1 then

  begin
    for j:= 1 to score do
    begin
      cards[count + j + 1] := cards[count + j + 1] + c;
    end;
  end;

  fmt1 := '%3d';
  fmt2 := '%12d';

  // Writeln('Index         | Cards                          ');
  // Writeln('______________|________________________________');
  // for cd:=1 to 219 do
  // begin
  //   row1 := format(fmt1, [cd]) + format(fmt2,[cards[cd]]);
  //   Writeln(row1);
  // end;

  // ReadLn;
end;



begin
  Assign(tfOut, C_FNAME);
  reset(tfOut);

  for i:= 0 to 219 do
    cards[i] := 1;

  i := 0;
  while not EOF(tfOut) do
  begin
    ReadLn(tfOut, s);
    parseLine(s, i);
    i := i + 1;
  end;
  Close(tfOut);

  // sum := 0;
  // for i:= 1 to 219 do
  //   sum := sum + cards[i];

  Writeln(sum);
end.