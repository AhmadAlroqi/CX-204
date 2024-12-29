.data
array:  .word 1, 2, 3, 4, 5, 6, 7, 8, 10  
size:   .word 9                         
result: .word 0                        

.text
main:
    la x3, array        
    lw x4, size         
    li x5, 0            

LOOP:
    lw x6, 0(x3)        
    add x5, x5, x6     
    addi x3, x3, 4      
    addi x4, x4, -1    
    bne x4, x0, LOOP

     
exit:
    la x7, result 
    li a0, 10       
    ecall
    
