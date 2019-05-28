@echo off
set xv_path=C:\\Xilinx\\Vivado\\2014.4\\bin
call %xv_path%/xsim reg_TB_vhd_behav -key {Behavioral:sim_1:Functional:reg_TB_vhd} -tclbatch reg_TB_vhd.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
