#   C code
# int main() {
#     int y;
#     int n = 3;
#     y = factorial(n);
# }

# int factorial(int n) {
#     if (n <= 1)
#       return 1;

#     else
#       return (n * factorial(n - 1))
# }
main:
    addi a0, zero, 1 #  n = 3
    jal factorial
    
    j finish #  goto finish label

#   a0 = n
factorial:
    #   memory map for 2 registers: a0 and ra
    addi sp, sp, -8
    #   save a0 and ra to stack
    sw a0, 4(sp)
    sw ra, 0(sp)
    #   temp variable = 1 (for if constant)
    bgt a0, t0, else # n > 1 - goto else
    addi a0, zero, 1 #  true => return 1
    #   clear stack
    addi sp, sp, 8
    #   return
    jr ra
else:
    #   recursion
    addi a0, a0, -1 # n = n - 1
    jal factorial # recursion call
    #   load n to t1
    lw t1, 4(sp)
    lw ra, 0(sp)
    #   clear stack
    addi sp, sp, 8
    #   a0 = n * factorial(n - 1)
    mul a0, t1, a0
    #   return
    jr ra

finish:
    add s7, a0, zero