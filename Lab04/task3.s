.data
vector1: .byte 1, 2, 3, 4, 5, 6, 7, 8
vector2: .byte 9, 10, 11, 12, 13, 14, 15, 16
result : .byte 0, 0, 0, 0, 0, 0, 0, 0

.text
.globl main
main:
    li x5, 0
    li x6, 8
    la x3, vector1
    la x4, vector2
    la x7, result

LOOP:
    lb x8, 0(x3)
    lb x9, 0(x4)
    add x10, x8, x9
    sw x10, 0(x7)
    addi x3, x3, 1
    addi x4, x4, 1
    addi x7, x7, 1
    addi x5, x5, 1
    bne x5, x6, LOOP


EXIT:
    li a0, 10
    ecall
