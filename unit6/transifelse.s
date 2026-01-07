# C code:
#   if (apples == oranges)
#       f = g + h;
#   else
#       apples = oranges - h;

#   s0 = apples, s1 = oranges
#   s2 = f, s3 = g, s4 = h

#   registers init
    addi s0, zero, 4 #  apples = 4
    addi s1, zero, 4 # oranges = 4
    addi s2, zero, 6 #  f = 6
    addi s3, zero, 7 # g = 7
    addi s4, zero, 0x1 # h = 1 = 0x1
#   code
    bne s0, s1, L1 # if (apples != oranges) => goto L1
    #   if part
    add s2, s3, s4 # f = g + h
    j L2
L1: #   else part
    sub s0, s1, s4 # apples = oranges - h
L2: # further part of program
    addi t0, zero, 1