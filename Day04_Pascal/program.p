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
  

function parseLine(line: string; count: integer): integer;
var
  i: Integer;
  wins: TA;
  guesses: TA;
  score: Integer;
  scored: Integer;
  w: string;
  g: string;

begin
  SetLength(wins, 10);
  SetLength(guesses, 25);
  scored := 0;
  score := 1;

  for i:= 0 to 9 do 
    wins[i] := copy(line, 3 * i + 10, 3);

  for i:= 0 to 24 do 
    guesses[i] := copy(line, 3 * i + 42, 3);

  for w in wins do
    for g in guesses do
    begin
      if w = g then
      begin
        if scored = 1 then
          score := score + score
        else
        begin
          scored := 1;
          score := 1;
        end;
      end;
    end;

  Writeln(line);
  // Writeln(count);
  Writeln(score);
  Writeln(scored);

  if scored = 1 then
    sum := sum + score;

  Writeln(sum);
end;



begin
  Assign(tfOut, C_FNAME);
  reset(tfOut);
  i := 0;
  while not EOF(tfOut) do
  begin
    i := i + 1;
    ReadLn(tfOut, s);
    parseLine(s, i)
  end;
  Close(tfOut);

  Writeln(sum);
end.