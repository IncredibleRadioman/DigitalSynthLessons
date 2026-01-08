#   C code
# int main() {
#     int y;
#     y = diffofsums(2, 3, 4, 5);
# }

# int diffofsums(inf f, int g, int h, int i) {
#     int result;
#     result = (f + g) - (h + i);

#     return result;
# }

main:
    addi a0, zero, 2 #  arg0 = 2
    addi a1, zero, 3 #  arg1 = 3
    addi a2, zero, 4 #  arg2 = 4
    addi a3, zero, 5 #  arg3 = 5
    jal diffofsums
    add s7, a0, zero
    j finish #  goto finish label
diffofsums:
    #   save registers to stack
    addi sp, sp, -12 # memory mapping in stack for 3 registers
    #   minus - addresses decrement
    sw s3, 8(sp) #  s3 -> stack
    sw t0, 4(sp) #  t0 -> stack
    sw t1, 0(sp) #  t1 -> stack
    #   function
    add t0, a0, a1
    add t1, a2, a3
    sub s3, t0, t1
    add a0, s3, zero #  save result
    #   load register from stack
    lw s3, 8(sp) 
    lw t0, 4(sp)
    lw t1, 0(sp)
    addi sp, sp, 12 #   clear memory mapping
    #   return to main
    jr ra
finish:
    addi t3, zero, 0