
.text 
li x3,0x10000000
li x4,0x10000000
li x5,0 #i
li x6,100# end i 

LOOP:
sb x5,0(x4)
addi x5, x5, 1# cond
add x4,x3,x5
bne x5, x6, LOOP
    
exit:
li a0, 4       
ecall