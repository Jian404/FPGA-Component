.PHONY: comp_vcs run_vcs run_verdi all

ALL_DEFINE = +define+SIMULATION 

filelist = ../filelist/filelist.f

comp_vcs:
	vcs \
	-full64 \
	+v2k \
	-sverilog \
	-debug_all \
	-l ./comp_log/comp.log \
	${ALL_DEFINE} \
	-f ${filelist}

run_vcs:
	./testbench.sv \
	-l ./sim_log/sim.log 

run_verdi:
	verdi \
	-sv \
	${ALL_DEFINE} \
	-f ${filelist} \
	-ssf ./tst.fsdb

all:
	comp_vcs run_vcs run_verdi
