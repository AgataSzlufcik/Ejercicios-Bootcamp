""" Ejercicio — Adivina el número (versión con funciones),
Crea un programa en Python donde el ordenador piense un número aleatorio entre 1 y 100 y la usuaria tenga que adivinarlo.

---

Requisitos,
Usa random.randint(1, 100) para generar el número secreto.,
Pide intentos al usuario hasta que acierte.,
Da pistas según el intento:
"Más alto" si el intento es menor que el número secreto.,
"Más bajo" si el intento es mayor que el número secreto.,
,
Cuenta cuántos intentos necesita el usuario para acertar.,
Si la entrada no es un número, muestra un mensaje de aviso y vuelve a pedir un intento válido.,

---

Estructura obligatoria (responsabilidad por función),
El programa debe organizarse usando estas funciones:

pedir_numero(),
Responsabilidad:
Pedir un número al usuario.,
Validar que la entrada sea un número.,
Devolver el número como entero (int).,

---

jugar_partida(),
Responsabilidad:
Generar el número secreto.,
Ejecutar una partida completa.,
Contar cuántos intentos necesita el usuario.,
Devolver el número de intentos al acertar.,

---

main(),
Responsabilidad:
Controlar el flujo general del juego.,
Permitir jugar varias partidas.,
Guardar y mostrar el mejor puntaje (menos intentos).,

---

Extra (opcional),
Permitir jugar varias veces seguidas.,
Mostrar el récord de la sesión al finalizar el juego.,

---

Pistas,
Importa el módulo random.,
Usa bucles while para repetir intentos.,
Usa try / except para controlar errores cuando el usuario escriba texto en lugar de números.,


Ejemplo de interacción,

He pensado un número entre 1 y 100
¡Intenta adivinarlo!

Tu intento: 50
Más alto

Tu intento: 75
Más bajo

Tu intento: 63
¡Correcto! Lo adivinaste en 3 intentos 

INICIO
│
└─ main()
    │
    ├─ seguir = "s"
    ├─ mejor_puntaje = None
    │
    └─ BUCLE PARTIDAS (while seguir == "s")
        │
        ├─ resultado = jugar_partida()
        │
        ├─ ¿mejor_puntaje es None o resultado < mejor_puntaje?
        │      │
        │      ├─ SI → actualizar mejor_puntaje
        │      │        imprimir "Nuevo récord"
        │      │
        │      └─ NO → imprimir "Tu mejor récord sigue siendo..."
        │
        └─ preguntar si quiere jugar otra vez
               │
               ├─ "s" → repetir partida
               │
               └─ "n" → salir del bucle

    │
    ├─ imprimir "Fin del juego"
    └─ imprimir "Mejor puntaje final"


jugar_partida()
│
├─ generar numero_secreto (random.randint)
├─ intentos = 0
│
└─ BUCLE PARTIDA (while True)
     │
     ├─ intento = pedir_numero()
     ├─ intentos += 1
     │
     ├─ ¿intento < numero_secreto?
     │      └─ SI → imprimir "Más alto"
     │
     ├─ ¿intento > numero_secreto?
     │      └─ SI → imprimir "Más bajo"
     │
     └─ SI NO (acertó)
            │
            ├─ imprimir "Correcto"
            └─ return intentos


pedir_numero()
│
└─ BUCLE VALIDACIÓN (while True)
     │
     ├─ pedir input
     │
     ├─ try convertir a int
     │      │
     │      ├─ éxito → return número
     │      │
     │      └─ error → imprimir aviso
     │               repetir bucle

"""

import random
def pedir_numero(): 
        while True:
            try:
                numero_usuario = int(input("Ingresa un numero de 1-100:"))
                return numero_usuario
            except ValueError:
                print("El numero no esta en rango")

def jugar_partida():
        numero_secreto = random.randint(1, 100)
        intentos = 0

        while True:
            intentos += 1
            numero_usuario = pedir_numero()
            if numero_usuario > numero_secreto:
                print("El numero secreto es menor.")
            elif numero_usuario < numero_secreto:
                print("El numero secreto es mayor.")
            else:
                print(f"¡Felicidades! Adivinaste el numero en {intentos} intentos.")
                break 