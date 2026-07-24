###############################################
#define variables
TESTNAME	?= apb_protocol_chek
TB_NAME		?= test_bench
RADIX		?= decimal
REGRESS_LIST	?=pat.list

#==============================================
drc:
	@echo "--------------------------------------"
	@echo "Checking RTL Syntax with Verilator..."
	@echo "--------------------------------------"
	verilator --lint-only -Wall -f rtl.f
	@echo "--------------------------------------"
	@echo "Status: DONE - No errors found"
	@echo "--------------------------------------"
all: build run

all_wave: build run wave

all_cov: build_cov run_cov

build: 
	mkdir -p log
	cp -rf ../testcases/$(TESTNAME).v run_test.v
	vlib work
	vmap work work
	vlog -f compile.f | tee compile.log
build_cov:
	mkdir -p log
	cp -rf ../testcases/$(TESTNAME).v run_test.v
	vlib work
	vmap work work
	vlog +cover=bcesft -f compile.f
run:
	vsim -debugDB -l $(TESTNAME).log -voptargs=+acc -assertdebug -c $(TB_NAME) -do "log -r /*; run -all; quit" -wlf vsim.wlf
	cp $(TESTNAME).log ./log
	mv $(TESTNAME).log sim.log
run_cov:
	vsim -coverage -l $(TESTNAME).log -c $(TB_NAME) -voptargs="+cover=bcesft" -assertdebug -do "coverage save -onexit $(TESTNAME).ucdb; log -r/*;run -all"
	cp $(TESTNAME).log ./log
	mv $(TESTNAME).log sim.log
wave:
	vsim -i -view vsim.wlf -do "add wave vsim:/$(TB_NAME)/*; radix -$(RADIX)" &	
gen_cov:
	mkdir -p coverage
	vcover merge IP.ucdb *.ucdb
	vcover report IP.ucdb -output coverage/summary_report.txt
	vcover report -zeros -details -code bcesft -annotate -All -codeAll IP.ucdb -output coverage/detail_report.txt
gen_html:
	mkdir -p coverage
	vcover merge IP.ucdb *.ucdb
	vcover report -zeros -details -code bcesft -annotate -testhitdataAll -html IP.ucdb



clean:
	rm -rf work
	rm -rf vsim.dbg
	rm -rf *.ini
	rm -rf *.log
	rm -rf *.wlf
	rm -rf transcript
	rm -rf *.ucdb
	rm -rf run_test.v
