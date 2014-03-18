luatmsim
========

lua turing machine simulator

I made this on a whim one afternoon. No guarantee of it working correctly and no liability of the author in that regard.

Sample session:

```
Initial tape:
001#
~~~^
From state s to state t on input # with action L
001#
~~^
From state t to state w on input 1 with action #
00[91m#[0m#
~~^
From state w to state x on input # with action R
00##
~~~^
From state x to state x on input # with action 1
00#[91m1[0m
~~~^
From state x to state s on input 1 with action L
00#1
~~^
From state s to state t on input # with action L
00#1
~^
From state t to state u on input 0 with action #
0[91m#[0m#1
~^
From state u to state v on input # with action R
0##1
~~^
From state v to state v on input # with action 0
0#[91m0[0m1
~~^
From state v to state s on input 0 with action L
0#01
~^
From state s to state t on input # with action L
0#01
^
From state t to state u on input 0 with action #
[91m#[0m#01
^
From state u to state v on input # with action R
##01
~^
From state v to state v on input # with action 0
#[91m0[0m01
~^
From state v to state s on input 0 with action L
#001
^
From state s to state t on input # with action L
##001
^
From state t to state y on input # with action R
##001
~^
From state y to state z on input # with action R
##001
~~^
From state z to state z on input 0 with action R
##001
~~~^
From state z to state z on input 0 with action R
##001
~~~~^
From state z to state z on input 1 with action R
##001#
~~~~~^
From state z to state h on input # with action #
##001[91m#[0m
~~~~~^
001 was accepted: Halted after 22 steps
```
