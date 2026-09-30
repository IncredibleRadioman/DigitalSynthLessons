#   Golden-модель блока возведения в 5 степень
#   математика из питона
def pow5_alg(x):
    return  pow(x, 5) & 0xff

#   типа железное возведение
def pow5_hw(x):
    y = 1
    for mul in range(0, 5):
        y = (y * x) & 0xff
    return y

#   генерация
print("Hello!!")
for x in range(0, 10):
    alg_val = pow5_alg(x)
    hw_val = pow5_hw(x);
    if (    alg_val == hw_val):
        print("Correct! x: ", hex(x).ljust(6), " y: ", hex(hw_val).ljust(6))
    else :
        print("Error! x: ", hex(x).ljust(6), " y(model): ", hex(alg_val).ljust(6),
        "; y(hw): ", hex(hw_val).ljust(6))
