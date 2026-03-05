def parenpar():
    nombre = input("¿Cómo te llamas? ").strip()
 
    if nombre.lower() == "juan":
        print(f"Lo siento {nombre}, de pequeño te caíste en una marmita llena de números...")
        print("Órdenes de arriba, no puedes jugar.")
        return

    print(f"Bienvenido {nombre}, el objetivo es analizar si el número es par.")

    while True:
        try:
            numero_usuario = int(input(f"{nombre}, escribe aquí tu número para valorarlo: "))

            if numero_usuario % 2 == 0:
                print(f"El número {numero_usuario} es Par. ¡Logrado!")
            else:
                print(f"¡A ver oh! Éste no es par, intenta otro.")


            while True:
                respuesta = input(f"¿{nombre}, ¿quieres probar con otro número? (s/n): ").lower().strip()
                if respuesta == "n":
                    print(f"¡Hasta luegoooooooooooooo, {nombre}!")
                    return

                elif respuesta == "s":
                    break
                else:
                    print(f"Por favor, {nombre} escribe solo 's' o 'n', no la líes.")

        except ValueError:
            print("Gallu, pon un número que valga. No molestes sino.")


parenpar()

