datos = {
  "personas": [
    {
      "nombre": "Ana",
      "direccion": {
        "ciudad": "Oviedo"
      }
    },
    {
      "nombre": "Luis",
      "direccion": {
        "ciudad": "Madrid"
      }
    },
    {
      "nombre": "Sara",
      "direccion": {
        "ciudad": "Sevilla"
      }
    }
  ]
}
print(datos["personas"][1]["nombre"], "vive en", datos["personas"][1]["direccion"]["ciudad"])