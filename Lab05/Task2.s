.data
array: .word 1,2,3,4,5,6,7,8,9


.text
main:
li t5,0 # should go 0-9
li t6,9  #9 (dont touch)
la t3, array
addi sp, sp, -4 

li t1,1
sw t1,0(sp)
jal ra, cal


li a0, 10 # exit the program
ecall

cal:
beq t5,t6,print
 lw t1,0(sp)

lw t2,0(t3)
addi t3,t3,4

mul t1,t1,t2

sw t1,0(sp)
addi t5,t5,1
j cal


print:
lw t1,0(sp)

li a0,1    #print result 
mv a1,t1 
ecall
addi sp, sp, 4 

jr ra
