#   C code
# int main() {
#     int y;
#     y = f1(1, 2);
# }

# int f1(inf a, int b) {
#     int i, x;
#     x = (a + b) * (a - b);

#     for (i = 0; i < a; i++)
#       x = x + f2(b + i);
#   return x;
# }

# int f2(int p) {
#     int r;
#     r = p + 5;
#     return (r + p);
# }
main:
    addi a0, zero, 1 #  arg0 = 1
    addi a1, zero, 2 #  arg1 = 2
    jal f1
    
    j finish #  goto finish label

#   a0 = a, a1 = b, s4 = i, s5 = x
f1:
    addi sp, sp, -12 #  memory map for 3 registers
    #   save all preserved registers
    sw ra, 8(sp)
    sw s4, 4(sp)
    sw s5, 0(sp)

    #   function
    add s5, a0, a1
    sub t3, a0, a1
    mul s5, s5, t3
    addi s4, zero, 0
for:
    bge s4, a0, return #    i >= a => goto return
    addi sp, sp, -8 #   memory map for 2 registers (nonpreserved)
    sw a0, 4(sp)
    sw a1, 0(sp)
    add a0, a1, s4
    jal f2  
    add s5, s5, a0 # x = x + f2(b + i);
    lw a0, 4(sp)
    lw a1, 0(sp)
    addi sp, sp, 8  #   clear memory
    addi s4, s4, 1 #    i++
    j for
return:
    add a0, zero, s5
    lw ra, 8(sp)
    lw s4, 4(sp)
    lw s5, 0(sp)
    addi sp, sp, 12
    jr ra

f2:
    addi sp, sp, -4 #   memory map for 1 register
    sw s4, 0(sp)
    addi s4, a0, 5
    add a0, s4, a0
    lw s4, 0(sp)
    addi sp, sp, 4
    jr ra

finish:
    add s7, a0, zero