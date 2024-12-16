.text 
main: 

li x5, 0xFFFFFFF0
addi x6, x0 ,-1
sub x5, x6, x5
add a1 ,x0, x5 

li a0, 1
ecall 


li x5, 15#15
andi x10,x5,1
addi a1, x10,0
ecall 
