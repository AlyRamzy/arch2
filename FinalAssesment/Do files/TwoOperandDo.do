vsim -gui work.main
add wave -position insertpoint sim:/main/*
force -freeze sim:/main/clk 0 0, 1 {50 ps} -r 100
force -freeze sim:/main/reset 1 0
force -freeze sim:/main/interrupt 0 0
run
run
force -freeze sim:/main/reset 0 0
force -freeze sim:/main/inport 00000000000000000000000000000101 0
run
run
force -freeze sim:/main/inport 00000000000000000000000000011001 0
run
force -freeze sim:/main/inport 00000000000000001111111111111101 0
run
force -freeze sim:/main/inport 00000000000000001111001100100000 0
run 3000
