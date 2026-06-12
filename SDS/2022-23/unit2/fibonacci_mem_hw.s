.text

start:        li t4, 0x10000000
              li t2, 10
              li t0, 1
              li t1, 1
              sh t0, 0(t4)
              addi t4, t4, 2
              sh t1, 0(t4)
             
 fibonacci:    mv a0, t1
               add t1, t0, t1
               mv t0, a0
               addi t2, t2, -1
               addi t4, t4, 2
               sh t1, 0(t4)
               bnez t2, fibonacci
     
     .data          
fib_data:
    .word 0x1
    .word 0x1