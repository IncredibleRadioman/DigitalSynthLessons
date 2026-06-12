.text

start:        li t4, 0x10000000
              li t2, 10
              li t3, 1
              addi t4, t4, 0x4
              
 fibonacci:    lw t0, -4(t4)
               lw t1, 0(t4)
               mv a0, t1
               add t1, t0, t1
               mv t0, a0
               sub t2, t2, t3
               addi t4, t4, 0x4
               sw t1, 0(t4)
               bnez t2, fibonacci
     
     .data          
fib_data:
    .word 0x1
    .word 0x1