.text

main: 
li t6, 6 # Input for Fibonacci
li sp,0x400
jal fibbo
jal print

li a0, 10   # Exit the program
ecall

fibbo:
addi sp, sp, -16
sw ra, 0(sp) # address
sw t1, 4(sp) # n
sw t2, 8(sp) # fibb(n-2)
sw t3, 12(sp) # fibb(n-1)
mv t1,t6
li t5,1

ble t6, t5, retu  # Base case: if t6 <= 1, return n



addi t6, t1, -1
jal fibbo
mv t3, t6

addi t6,t1,-2
jal fibbo
mv t2,t6
add t6, t3, t2

retu:
lw ra, 0(sp) # address
lw t1, 4(sp) # n
lw t2, 8(sp) # fibb(n-2)
lw t3, 12(sp) # fibb(n-1)
addi sp, sp, 16
jr ra

print:
li a0, 1
mv a1, t6
ecall

jr ra