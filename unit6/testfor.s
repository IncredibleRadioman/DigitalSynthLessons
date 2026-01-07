# C code
# int sum = 0;
# int i;

# for (i = 0; i < 10; i = i + 1) {
#     sum = sum + i;
#     }

#   s0 = i, s1 = sum
    addi s1, zero, 0 # sum = 0
    addi s0, zero, 0 # i = 0
    addi t0, zero, 10 # t0 = 10
for:
    bge s0, t0, done
    add s1, s1, s0
    addi s0, s0, 1
    j for
done:
    # further part of program
    addi t1, zero, 1