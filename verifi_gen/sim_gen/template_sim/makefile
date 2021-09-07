#Makefile for ${env_name} uvm

seed = 0
N=0
test_id += ${test}_${N}

all: compile run

compile:
  vcs -full64 -sverilog -ntb_opts uvm-1.1 -timescale="1ns/1ps" -l comp.log -f flist.f -debug_access+cbk -debug_access+all -kdb -lca -ntb \

run:
  ./simv -l ./logs/${test_id} +ntb_random_seed=${seed} +UVM_TESTNAME=${test} +fsdb+sva_success

verdi:
  verdi -sv -full64 -f flist.f -ssf ${env_name}_top_tb.fsdb -top ${env_name}_test_top -autoalias

grep:
  grep UVM_ERROR -r ./logs

clean:
  rm -rf simv* csrc* *.tmp *.vpd *.key *.h *.log .vcs* *.txt DVE* *.err *.history