.data
value1: .word 0x1234      
value2: .word 0x5678       
result: .word 0            

.text
main:
 
    la x5, value1          
    lw x5, 0(x5)          
    la x6, value2          
    lw x6, 0(x6)           
    add x7, x5, x6         

    la x8, result
    sw x7, 0(x8)

    li a7, 10              
    ecall