.data 

value: .word 0x12345678

.text 
main:
      la x1,value
      lw x3,0(x1)
            
            
       slli x4,x3,24
       srli x3,x3,8
       slli x5,x3,16 
       addi x9,x9,-1
       srli x9,x9,8
       and x5,x9,x5
       srli x3,x3,8
            
       slli x6,x3,8
       srli x9,x9,8
       and x6,x6,x9
       srli x3,x3,8
            
       add x8,x3,x5
       add x8,x6,x8
       add x8,x8,x4
            
           
            
            
