@echo off
set xv_path=C:\\Xilinx\\Vivado\\2014.4\\bin
call %xv_path%/xelab  -wto fec7a0c71bb9458db5067d3271e2e154 -m64 --debug typical --relax -L xil_defaultlib -L secureip --snapshot MultiCycle_MIPS_tb_behav xil_defaultlib.MultiCycle_MIPS_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
