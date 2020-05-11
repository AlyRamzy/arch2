vsim -gui work.execute
add wave -position insertpoint sim:/execute/*

#not 
force -freeze sim:/execute/opcode 00001 0
force -freeze sim:/execute/in_selectors 101010000 0
force -freeze sim:/execute/in_reg_1 00000000000000000000000010000000 0
force -freeze sim:/execute/in_reg_2 00000000000000000000000000001000 0
force -freeze sim:/execute/in_reg_3 00000000000000000000000000000001 0
force -freeze sim:/execute/edit_flag 1 0
force -freeze sim:/execute/inturrupt 00 0
run
run
run 
run

#inc
force -freeze sim:/execute/opcode 00010 0
force -freeze sim:/execute/in_selectors 101010000 0
force -freeze sim:/execute/in_reg_1 00000000000000000000000010000000 0
force -freeze sim:/execute/in_reg_2 00000000000000000000000000001000 0
force -freeze sim:/execute/in_reg_3 00000000000000000000000000000001 0
force -freeze sim:/execute/edit_flag 1 0
force -freeze sim:/execute/inturrupt 00 0
run
run
run 
run

#dec
force -freeze sim:/execute/opcode 00011 0
force -freeze sim:/execute/in_selectors 101010000 0
force -freeze sim:/execute/in_reg_1 00000000000000000000000010000000 0
force -freeze sim:/execute/in_reg_2 00000000000000000000000000001000 0
force -freeze sim:/execute/in_reg_3 00000000000000000000000000000001 0
force -freeze sim:/execute/edit_flag 1 0
force -freeze sim:/execute/inturrupt 00 0
run
run
run 
run


#add
force -freeze sim:/execute/opcode 01001 0
force -freeze sim:/execute/in_selectors 101010000 0
force -freeze sim:/execute/in_reg_1 00000000000000000000000000000010 0
force -freeze sim:/execute/in_reg_2 00000000000000000000000000000100 0
force -freeze sim:/execute/in_reg_3 00000000000000000000000000000001 0
force -freeze sim:/execute/edit_flag 1 0
force -freeze sim:/execute/inturrupt 00 0
run
run
run 
run

#sub
force -freeze sim:/execute/opcode 01011 0
force -freeze sim:/execute/in_selectors 101010000 0
force -freeze sim:/execute/in_reg_1 00000000000000000000000000000010 0
force -freeze sim:/execute/in_reg_2 00000000000000000000000000000100 0
force -freeze sim:/execute/in_reg_3 00000000000000000000000000000001 0
force -freeze sim:/execute/edit_flag 1 0
force -freeze sim:/execute/inturrupt 00 0
run
run
run 
run

#and
force -freeze sim:/execute/opcode 01100 0
force -freeze sim:/execute/in_selectors 101010000 0
force -freeze sim:/execute/in_reg_1 00000000000000000000000000000010 0
force -freeze sim:/execute/in_reg_2 00000000000000000000000000000100 0
force -freeze sim:/execute/in_reg_3 00000000000000000000000000000001 0
force -freeze sim:/execute/edit_flag 1 0
force -freeze sim:/execute/inturrupt 00 0
run
run
run 
run

#or
force -freeze sim:/execute/opcode 01101 0
force -freeze sim:/execute/in_selectors 101010000 0
force -freeze sim:/execute/in_reg_1 00000000000000000000000000000010 0
force -freeze sim:/execute/in_reg_2 00000000000000000000000000000100 0
force -freeze sim:/execute/in_reg_3 00000000000000000000000000000001 0
force -freeze sim:/execute/edit_flag 1 0
force -freeze sim:/execute/inturrupt 00 0
run
run
run 
run


#iadd 
force -freeze sim:/execute/opcode 01010 0
force -freeze sim:/execute/in_selectors 101010000 0
force -freeze sim:/execute/in_reg_1 00000000000000000000000000000010 0
force -freeze sim:/execute/in_reg_2 00000000000000000000000000000100 0
force -freeze sim:/execute/in_reg_3 00000000000000000000000000000001 0
force -freeze sim:/execute/edit_flag 1 0
force -freeze sim:/execute/inturrupt 00 0
run
run
run 
run

#shl
force -freeze sim:/execute/opcode 01110 0
force -freeze sim:/execute/in_selectors 101010000 0
force -freeze sim:/execute/in_reg_1 00000000000000000000000000000010 0
force -freeze sim:/execute/in_reg_2 00000000000000000000000000000100 0
force -freeze sim:/execute/in_reg_3 00000000000000000000000000000001 0
force -freeze sim:/execute/edit_flag 1 0
force -freeze sim:/execute/inturrupt 00 0
run
run
run 
run

#shr
force -freeze sim:/execute/opcode 01111 0
force -freeze sim:/execute/in_selectors 101010000 0
force -freeze sim:/execute/in_reg_1 00000000000000000000000000000010 0
force -freeze sim:/execute/in_reg_2 00000000000000000000000000000100 0
force -freeze sim:/execute/in_reg_3 00000000000000000000000000000001 0
force -freeze sim:/execute/edit_flag 1 0
force -freeze sim:/execute/inturrupt 00 0
run
run
run 
run

#push 
force -freeze sim:/execute/opcode 10000 0
force -freeze sim:/execute/in_selectors 000000010 0
force -freeze sim:/execute/in_reg_1 00000000000000000000000000000010 0
force -freeze sim:/execute/in_reg_2 00000000000000000000000000000101 0
force -freeze sim:/execute/in_reg_3 00000000000000000000000000000001 0
force -freeze sim:/execute/edit_flag 0 0
force -freeze sim:/execute/inturrupt 00 0
run
run
run 
run

#pop
force -freeze sim:/execute/opcode 10001 0
force -freeze sim:/execute/in_selectors 000100100 0
force -freeze sim:/execute/in_reg_1 00000000000000000000000000000010 0
force -freeze sim:/execute/in_reg_2 00000000000000000000000000000101 0
force -freeze sim:/execute/in_reg_3 00000000000000000000000000000001 0
force -freeze sim:/execute/edit_flag 0 0
force -freeze sim:/execute/inturrupt 00 0
run
run
run 
run


quit -sim