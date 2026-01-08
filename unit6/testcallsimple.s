#   C code
# int main() {
#     simple();
# }

# void simple() {
#     return;
# }
main:
    jal simple #    call simple
    addi s0, zero, 4 # s0 = 0 + 4 = 4
simple:
    jr ra # return to main