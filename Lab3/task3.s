.data 
valaue: .byte 1,2,3,4,5

.text 

main :

        la x1,valaue
        lb x3,0(x1)
        lb x4,1(x1)
        lb x5,2(x1)
        lb x6,3(x1)
        lb x7,4(x1)
        
        sw x3,0(x1)
        sw x4,4(x1)
        sw x5,8(x1)
        sw x6,12(x1)
        sw x7,16(x1)
