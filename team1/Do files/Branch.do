force -freeze sim:/main/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/main/reset 1 0
force -freeze sim:/main/interrupt 0 0
run
force -freeze sim:/main/reset 0 0
run
force -freeze sim:/main/inport 16#30 0
run
force -freeze sim:/main/inport 16#50 0
run
force -freeze sim:/main/inport 16#100 0
run
force -freeze sim:/main/inport 16#300 0
run
force -freeze sim:/main/inport 16#FFFFFFFF 0
run
run
run
run
run
run
force -freeze sim:/main/interrupt 1 0
run
run
run
run
force -freeze sim:/main/interrupt 0 0
run
run
force -freeze sim:/main/inport 16#200 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
run
force -freeze sim:/main/interrupt 1 0
run
run
run
run
force -freeze sim:/main/interrupt 0 0
run
run
run
run
run
run
run
run
run
run
run
run
run
run