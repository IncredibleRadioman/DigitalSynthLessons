.globl main #   label main - global
.equ N, 5   #   N = 5 (variable for code)
.data   #   global data segment
A:  .word 5, 42, -88, 2, -5033, 720, 314 #  variable A
str1:   .string "RISC-V"
.align 2 #  align data to the boundary 2^2 = 4 bytes 
B:  .word 0x32A
.bss    #   variables initialized with zeros
C:  .space 4
D:  .space 1
.balign 4 #  align data to the boundary 4 bytes
.text # code segment
main:
    la t0, A #  t0 = &A
    la t1, str1 #   t1 = &str1
    la t2, B #  t2 = &B
    la t3, C #  t3 = &C
    la t4, D #  t4 = &D
    lw t5, N*4(t0) #    t5 = A[N] = A[5]
    lw t6, 0(t2) #  t6 = B
    add t5, t5, t6 #    t5 = A[N] + B
    sw t5, 0(t3) #  C = t5
    lb t5, N-1(t1) #    t5 = str1[N-1] = str1[4]
    sb t5, 0(t4) # D = str1[N-1]
    la t5, str2 #   t5 = &str2
    lb t6, 8(t5) #  t6 = str2[8]
    sb t6, 0(t1) #  str1[0] = t6 = 'r'
    jr ra
.section .rodata
str2: .string "Hello world!"
.end