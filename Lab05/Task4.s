.text

main: 
li t1,5
li t6,1
jal fac

jal print

li a0, 10   # Exit the program
ecall

fac:
blt t1,t6,retu #t6=1
addi sp, sp, -8 
sw t1,4(sp)
sw ra,0(sp)

addi t1,t1,-1

jal fac

lw t1,4(sp)
lw ra,0(sp)
addi sp, sp, 8
mul t2,t1,t2
jr ra

retu:
li t2, 1 
jr ra

print:
li a0, 1    # Print the result
mv a1, t2
ecall

jr ra
