# C code
# int pow = 1;
# int x = 0;

# do {
#     pow = pow * 2;
#     x = x + 1;
# } while (pow != 128)

#   s0 = pow, s1 = x
    addi s0, zero, 1 #pow = 1
    add s1, zero, zero # x = 0
    addi t0, zero, 128 # t0 = 128
while:
    slli s0, s0, 1
    addi s1, s1, 1
    bne s0, t0, while
done:
    # further part of program
    addi t1, zero, 1