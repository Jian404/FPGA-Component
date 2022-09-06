.PHONY: comp_vcs run_vcs run_verdi all

ALL_DEFINE = +define+SIMULATION 

filelist = ../filelist/filelist.f

comp_vcs:
	vcs \
	-full64 \
	+v2k \
	-sverilog \
	-debug_all \
	-l comp.log \
	${ALL_DEFINE} \
	${NOVAS_HOME}/share/PLI/VCS/LINUX64/novas.tab \
	${NOVAS_HOME}/share/PLI/VCS/LINUX64/pli.a \
	-f ../filelist/filelist.f

run_vcs:
	../testbench/tb.sv \
	-l sim.log 

run_verdi:
	verdi \
	-sv \
	${ALL_DEFINE} \
	-f ../filelist/filelist.f \
	-ssf ./tst.fsdb

all:
	comp_vcs run_vcs run_verdi
