# C code:
#   if (apples == oranges)
#       f = g + h;
#   apples = oranges - h;

#   s0 = apples, s1 = oranges
#   s2 = f, s3 = g, s4 = h

#   registers init
    addi s0, zero, 4 #  apples = 4
    addi s1, zero, 4 # oranges = 4
    addi s2, zero, 6 #  f = 6
    addi s3, zero, 7 # g = 7
    addi s4, zero, 0xA # h = 10 = 0xA

    bne s0, s1, L1 # if (apples != oranges) => goto L1
    add s2, s3, s4 # f = g + h
L1:
    sub s0, s1, s4 # apples = oranges - h