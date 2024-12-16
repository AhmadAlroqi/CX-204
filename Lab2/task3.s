#Task3.2
addi x9,x0,5
addi x5,x0,3
addi x6,x0,1

sll x8,x6,x5
xor x10,x9,x8
#print 
addi a1, x10,0
li a0, 1
ecall
