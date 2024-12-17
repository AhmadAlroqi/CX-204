
#Task3.2
addi x9,x0,5 #enter the input 
addi x5,x0,3 #toggle 
addi x6,x0,1

sll x8,x6,x5
xor x10,x9,x8
#print 
addi a1, x10,0
li a0, 1
ecall

#Task3.3
li x5,13#1101
srli x6,x5,16
xor x5,x5,x6
srli x6,x5,8
xor x5,x5,x6
srli x6,x5,4
xor x5,x5,x6
srli x6,x5,2
xor x5,x5,x6
srli x6,x5,1
xor x5,x5,x6
andi x10,x5,1


#Task3.4
li x5, 0xABCDFFFF
li x6,0xFF
#mulit
li x7,2
slli x7,x7,3

sll x6,x6,x7
and x10,x5,x6


#Task3.5
li x5, 0xABCDFFFF
li x6,0xFF
#mulit
li x7,2
slli x7,x7,3

sll x6,x6,x7
and x10,x5,x6

slli x10,x10,8
srai x10 ,x10,24


#print 
addi a1, x10,0
li a0, 1
ecall
#print 
addi a1, x10,0
li a0, 1
ecall
