#   C code
# int i;
# int scores[200];

# for (i = 0; i < 200; i = i + 1)
#     scores[i] = scores[i] + 1;

#   s0 = scores base addr
#   s1 = i
    addi s1, zero, 0 #  i = 0
    addi t2, zero, 200 #    t2 = 200
for:
    bge s1, t2, done #  if i >= 200 => goto done
    slli t0, s1, 2 #    t0 = i * 4
    add t0, t0, s0  #   scores[i] address = base + t0
    lw t1, 0(t0) #  t1 = scores[i]
    addi t1, t1, 10 #   t1 = scores[i] + 10
    sw t1, 0(t0) #  scores[i] = t1
    addi s1, s1, 1
    j for
done:
    # further part of program
    addi t3, zero, 1