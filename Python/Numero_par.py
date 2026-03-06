numero_usuario = None

while numero_usuario is None or numero_usuario < 1 or numero_usuario > 100:
    try:
        numero_usuario = int(input("Ingresa un número de 1-100: "))

        if numero_usuario < 1 or numero_usuario > 100:
            print("Número fuera de rango")
    except ValueError:
        print("Debes escribir un numero")

if numero_usuario % 2 == 0:
    print("El número es par")
else:
    print("El número es impar")