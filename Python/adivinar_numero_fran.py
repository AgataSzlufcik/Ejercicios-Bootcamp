import random

def main():
    seguir= "s"
    mejor_puntaje = None

    while seguir == "s":
        resultado = jugar_partida()
        if mejor_puntaje is None or resultado < mejor_puntaje:
            mejor_puntaje = resultado
            print("Nuevo récord")
        else:
            print(f"Tu mejor récord siguen siendo {mejor_puntaje}")

        seguir = input("Quieres jugar otra partida (s/n)")
        if seguir.upper()== "S":
            seguir= "s"
        else:
            seguir = "n"
    print("Fin del juego")
    print("Mejor puntaje final", mejor_puntaje)


def jugar_partida():
    numero_secreto = random.randint(1,100)
    intentos = 0
    while True:
        intento = pedir_numero()
        intentos += 1
        if intento < numero_secreto:
            print("Más alto")
        elif intento > numero_secreto:
            print("Más bajo")
        else:
            print("Correcto")
            return intentos

def pedir_numero():
    while True:

        try: numero_secreto= int(input("Introduce un número entre 1 y 100: "))

        except ValueError:
            print("Aviso repetir bucle")
            continue        
        else:
            return numero_secreto


if __name__ == "__main__":
    main()