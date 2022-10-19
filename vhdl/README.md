In each subdirectory, execute the testbench as follows:
```
modelsim -c -do 'vdel -all -lib work; vlib work; vcom flopoco.vhdl; vcom -2008 test.vhdl; vsim TestBench; run -all'
```