import json
from pathlib import Path

"""
Juego de adivinanzas pensado para empezar desde cero.

Cómo entenderlo fácil:
- El programa hace preguntas de sí/no.
- Según tu respuesta, va por un camino u otro.
- Al final intenta adivinar tu objeto.
- Si falla, te pide ayuda y aprende una pregunta nueva.
- Ese aprendizaje se guarda en un archivo JSON para la próxima vez.

Idea clave para clase:
es como un "juego que mejora con la experiencia".
"""

RUTA_BD = Path(__file__).with_name("arbol_juego.json")

ARBOLES_INICIALES = {
    "pregunta": "¿Es un animal?",
    "si": {
        "adivinanza": "perro"
    },
    "no": {
        "pregunta": "¿Es un vegetal?",
        "si": {
            "adivinanza": "lechuga"
        },
        "no": {
            "adivinanza": "piedra"
        }
    }
}


def normalizar_si_no(texto: str) -> str:
    """Convierte variantes de sí/no a un formato único: 'si' o 'no'."""
    texto = texto.strip().lower()
    mapa_si = {"s", "si", "sí", "y", "yes"}
    mapa_no = {"n", "no"}
    if texto in mapa_si:
        return "si"
    if texto in mapa_no:
        return "no"
    return ""


def pedir_si_no(pregunta: str) -> str:
    """Pregunta hasta recibir una respuesta válida (sí o no)."""
    while True:
        respuesta = input(f"{pregunta} (sí/no): ")
        rama = normalizar_si_no(respuesta)
        if rama:
            return rama
        print("Respuesta no válida. Escribe sí o no.")


def cargar_arbol() -> dict:
    """Carga lo aprendido antes; si no existe, empieza con ejemplos básicos."""
    if not RUTA_BD.exists():
        return ARBOLES_INICIALES
    try:
        with RUTA_BD.open("r", encoding="utf-8") as archivo:
            data = json.load(archivo)
        if isinstance(data, dict):
            return data
    except (OSError, json.JSONDecodeError):
        pass
    return ARBOLES_INICIALES


def guardar_arbol(arbol: dict) -> None:
    """Guarda en JSON lo que el juego sabe hasta ese momento."""
    with RUTA_BD.open("w", encoding="utf-8") as archivo:
        json.dump(arbol, archivo, ensure_ascii=False, indent=2)


def aprender_en_nodo(nodo: dict) -> None:
    """
    Si falla la adivinanza:
    - El usuario dice cuál era el objeto real.
    - El usuario aporta una pregunta para diferenciar ambos objetos.
    - El juego actualiza su "mapa de preguntas" para acertar mejor la próxima vez.
    """
    adivinanza_fallida = nodo["adivinanza"]
    nuevo_objeto = input("Me rindo. ¿Qué objeto era?: ").strip()
    while not nuevo_objeto:
        nuevo_objeto = input("Escribe un objeto válido: ").strip()

    nueva_pregunta = input(
        f"Escribe una pregunta que distinga '{nuevo_objeto}' de '{adivinanza_fallida}': "
    ).strip()
    while not nueva_pregunta:
        nueva_pregunta = input("La pregunta no puede estar vacía. Inténtalo: ").strip()

    respuesta_para_nuevo = pedir_si_no(
        f"Para '{nuevo_objeto}', ¿la respuesta a esa pregunta es sí?"
    )

    nuevo_nodo_objeto = {"adivinanza": nuevo_objeto}
    nodo_fallido = {"adivinanza": adivinanza_fallida}

    nodo.clear()
    nodo["pregunta"] = nueva_pregunta
    if respuesta_para_nuevo == "si":
        nodo["si"] = nuevo_nodo_objeto
        nodo["no"] = nodo_fallido
    else:
        nodo["si"] = nodo_fallido
        nodo["no"] = nuevo_nodo_objeto


def jugar_partida(arbol: dict) -> None:
    """Hace preguntas, llega a una adivinanza y comprueba si acertó."""
    nodo_actual = arbol

    while "pregunta" in nodo_actual:
        rama = pedir_si_no(nodo_actual["pregunta"])
        nodo_actual = nodo_actual[rama]

    confirmar = pedir_si_no(f"¿Estás pensando en '{nodo_actual['adivinanza']}'?")
    if confirmar == "si":
        print("¡Genial! He adivinado.")
        return

    aprender_en_nodo(nodo_actual)
    print("Gracias, he aprendido algo nuevo.")


def main() -> None:
    """Lanza el juego y permite varias rondas hasta que el usuario quiera salir."""
    print("Bienvenida al juego: Animal, vegetal o mineral.")
    print("Piensa en un objeto y yo intentaré adivinarlo con preguntas de sí/no.")

    arbol = cargar_arbol()

    while True:
        jugar_partida(arbol)
        seguir = pedir_si_no("¿Quieres jugar otra ronda?")
        if seguir == "no":
            guardar_arbol(arbol)
            print("Partida guardada. ¡Hasta la próxima!")
            break


if __name__ == "__main__":
    main()
