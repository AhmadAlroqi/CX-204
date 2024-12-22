#hello



li t1,1

li t2,5  #a
li t3,6  #b
li t5,0 # res
mv x2,t2
mv x3,t3

main:
blt t3,x0, exit
beq  t3,x0,exit

andi t6,t3,1

bne t6, t1 , ifnot
add t5,t5,t2
ifnot:
slli t2,t2, 1
srli t3,t3,1
j main 

exit: #print and exit 
li a0,1 #print a 
mv a1,x2  
ecall

li a0,11  # print +
li a1,'*'
ecall

li a0,1 #print b 
mv a1,x3  
ecall

li a0,11  # print =
li a1,'='
ecall

li a0,1    #print result 
mv a1,t5  
ecall

li a0,10 #exit
ecall


