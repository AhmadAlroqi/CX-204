li t1,5   #user input
li t2,1

main: 
bgt t2,t1, exit

init: 
li t5,0
print:
beq t5,t2, printe
addi t5, t5, 1


li a0,11  # print *
li a1,'*'
ecall
j print


printe: 
li a0,11  # print enter
li a1, 10 
ecall

addi t2,t2,1
j main


exit: 
li a0,10 #exit
ecall
