.data
n:   .word 6   
result: .word 1    

.text
main:
    li x1, 1         
    la x2, n         
    lw a0, 0(x2)     
    li x3, 1         
    
    
    jal x6 loop

    la x4, result      
    sw x3, 0(x4) 
    
    li a0 ,10
    ecall
        
loop:
    ble x1, a0, calculate 
    j exit               

calculate:
    mul x3, x3, x1  
    addi x1, x1, 1  
    j loop          
    
exit:
    jalr x0, x6 0
          