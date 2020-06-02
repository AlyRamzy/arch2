vsim -gui work.main
add wave -position insertpoint sim:/main/*
force -freeze sim:/main/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/main/reset 1 0
force -freeze sim:/main/interrupt 0 0
run
force -freeze sim:/main/reset 0 0
run
run
run
run
force -freeze sim:/main/inport 16#5 0
run
force -freeze sim:/main/inport 16#10 0
run
run
run
run
run