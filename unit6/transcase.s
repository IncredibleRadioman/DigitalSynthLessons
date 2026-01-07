#   C code
# switch (button) {
#     case 1: amt = 20; break;

#     case 2: amt = 50; break;

#     case 3: amt = 100; break;

#     default: amt = 0;
# }

#   s0 = button, s1 = amt
#   s2 = f, s3 = g, s4 = h

#   registers init
    addi s0, zero, 1 #  apples = 4
#   code
case1:
    addi t0, zero, 1 #  t0 = 1
    bne s0, t0, case2 # button != 1 ? => goto case2
    addi s1, zero, 20  # amt = 20
    j done
case2:
    addi t0, zero, 2 #  t0 = 2
    bne s0, t0, case3 # button != 2 ? => goto case3
    addi s1, zero, 50 #  amt = 50
    j done
case3:
    addi t0, zero, 3 #  t0 = 3
    bne s0, t0, default # button != 3 ? => goto default
    addi s1, zero, 100 # amt = 100
    j done
default:
    add s1, zero, zero # amt = 0
done:
    # further part of program
    addi t1, zero, 1