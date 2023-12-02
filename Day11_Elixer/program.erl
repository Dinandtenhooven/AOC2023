% this is the hello world program I am trying to run
-module(program).
-export([start/0]).

start() ->
   io:fwrite("Hello, world!\n").