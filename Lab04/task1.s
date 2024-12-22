.data
EQUAL:      .string "equal\n"
NOT_EQUAL:  .string "Not equal\n"

.text
li x3,5
li x4,6

bne x3,x4,ELSE 

la a1,EQUAL
j EXIT

ELSE:
la a1,NOT_EQUAL

EXIT:
li,a0,4
ecall