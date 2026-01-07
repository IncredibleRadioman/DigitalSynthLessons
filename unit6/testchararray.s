# C code
# int i;
# for (i = 0; i < 10; i = i + 1)
#     chararray[i] = chararray[i] - 1;

#   s0 = base addr chararray
    addi s0, zero, 0x1522FFF0
#   s1 = i
    addi s1, zero, 0
    addi t3, zero, 10
for:
    bge s1, t3, done
    add t4, s0, s1 #    t4 = &chararray[i]
    lb t5, 0(t4) #  t5 = chararray[i]
    addi t5, t5, -32 #  t5 = chararray[i] - 32
    sb t5, 0(t4) #  chararray[i] = t5
    addi s1, s1, 1  # i = i + 1
    j for
done:
    addi s2, zero, 1