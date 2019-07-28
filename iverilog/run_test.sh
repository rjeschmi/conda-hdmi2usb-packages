#!/bin/bash

set -e
set +x

$PREFIX/bin/iverilog -V
$PREFIX/bin/iverilog -h || true

cd test

# Hello world test
echo
echo
echo "Hello World Test ====="
$PREFIX/bin/iverilog -v -o hello_world hello_world.v 
echo "----------------------"
cat hello_world
echo "----------------------"
./hello_world | tee output.log
echo "----------------------"
grep -q 'Hello, World' output.log
echo "----------------------"

# Counter
echo
echo
echo "Counter Test ========="
$PREFIX/bin/iverilog -o test_counter counter_tb.v counter.v
echo "----------------------"
cat test_counter
echo "- - - - - - - - - - --"
vvp -n test_counter
echo "----------------------"
$PREFIX/bin/iverilog -o test_counter -c counter_list.txt
echo "- - - - - - - - - - --"
vvp -n test_counter
echo "----------------------"

# More advanced test
echo
echo
echo "FSM Test ============="
$PREFIX/bin/iverilog -o test_fsm fsm.v
echo "----------------------"
cat test_fsm
echo "----------------------"
./test_fsm
echo "----------------------"
