#importar libreria 
import random

#1. Generar un número en el rango numerico del 0 al 100 numer=(1,100)
numero_secreto = random.randint(1,100)

#2. Crear un contador de intentos con valor inicial=0.
contador = 0

#3. Crear un mensaje de bienvenida al usuario
print("Bienvenido en el juego! Adivina el numero secreto del 1 al 100: ") 

#4. Crear el bucle
while True:
    
    #5. Pedir al usuario que ingrese un numero
    numero_usuario = int(input("Ingresa un numero de 1-100: "))
    #6. Incrementar el contador de intentos
    contador += 1
    #7. Comparar el numero ingresado con el numero secreto
    if numero_usuario > numero_secreto:
        print("El numero secreto es menor.")
    elif numero_usuario < numero_secreto:
        print("El numero secreto es mayor.")
    else:
        print(f"¡Felicidades! Adivinaste el numero en {contador} intentos.")
        seguir_jugando = input("¿Quieres jugar de nuevo? (si/no): ")
        if seguir_jugando == "si":
            continue
        else:
            print("Gracias por jugar! Nos vemos en el otro juego")
            break
    
  
