Respiremos: si hoy os sentis con el cerebro haciendo ruido, es normal.
Esta "chuletilla" es para ordenar ideas sin agobio.

## Contexto del ejercicio (la peli de hoy)

Sois el equipo de datos de **Rural Gym**, una cadena de gimnasios repartida por zonas rurales de Asturias.
Os han pasado una base de datos con vuestros propios nombres dentro (si, en serio) y os piden ayuda para que el modelo no sea un caos.
Quieren poder responder cosas reales de negocio:

1. que clases estan petadas (HIIT del Multiverso arrasa, por cierto),
2. en que sedes hay mas movimiento,
3. quienes son los socios mas fieles.

Teneis el fichero `rural-gym.db` listo para abrir en DB Browser.
Traduccion simple: no estamos haciendo teoria por hacerla, estamos montando la base para tomar decisiones de verdad.

## 1) Que hemos visto (en claro)

1. Que es una base de datos relacional y no relacional.
2. Conceptos clave: PK, FK, clave compuesta, dependencia funcional.
3. Cardinalidad entre entidades (1:1, 1:N, N:M).
4. Normalizacion: 1FN, 2FN, 3FN (y BCNF como revision extra).
5. Como volver al analisis con SQL (`JOIN`, `GROUP BY`, `ORDER BY`).

Si ahora mismo piensas "he visto demasiado", no pasa nada. Con que te quedes con la ruta mental, ya vamos bien.

## 2) Relacional vs no relacional (version corta)

- Relacional: tablas conectadas, estructura fija, ideal para datos de negocio bien definidos.
- No relacional: estructura flexible, util cuando el dato cambia mucho o es muy heterogeneo.

Frase para quedarte tranquila:

- Relacional = orden y relaciones claras.
- No relacional = flexibilidad cuando todo cambia mucho.

## 3) Conceptos minimos que debes dominar

- `PK`: identifica una fila unica.
- `FK`: conecta una tabla con otra.
- Clave compuesta: PK con 2 o mas columnas.
  Ejemplo: `detalle_reserva(id_reserva, id_clase)`.
- Dependencia funcional (`X -> Y`): conocer X determina Y.
  Ejemplo: `id_centro -> nombre_centro`.

Mini traduccion humana:

- PK: "el DNI" de cada fila.
- FK: "el cable" que conecta tablas.

## 4) Cardinalidad (como pensarlo)

- `1:N`: un centro tiene muchos socios.
- `1:N`: un socio puede tener muchas reservas.
- `N:M`: una reserva puede tener varias clases y una clase puede aparecer en muchas reservas.
  Se resuelve con `detalle_reserva`.

Regla rapida:

Si una relacion suena a "muchos con muchos", casi siempre necesitaremos tabla intermedia.

## 5) Ruta mental para normalizar sin perderte

1. Empieza por una tabla en bruto (raw).
2. Marca que campos se repiten demasiado.
3. Aplica 1FN: una celda = un valor.
4. Aplica 2FN: fuera dependencias parciales (si PK compuesta).
5. Aplica 3FN: fuera dependencias transitivas.
6. Revisa BCNF: si `X -> Y`, `X` debe ser superclave.

Mantra de clase:

1. primero entiendo,
2. luego separo,
3. luego compruebo.

## 6) Modelo objetivo de referencia

```text
centros(id_centro PK, nombre_centro)
socios(id_socio PK, nombre_socio, email_socio, id_centro FK)
clases(id_clase PK, nombre_clase, tipo_clase, duracion_min)
reservas(id_reserva PK, fecha_reserva, id_socio FK)
detalle_reserva(id_reserva PK/FK, id_clase PK/FK, cantidad)
```

## 7) Lo que ya tienes listo en el .db

Abre `rural-gym.db` en DB Browser y encontraras:

**Tablas** (estructura normalizada):
`centros` → `socios` → `reservas` → `detalle_reserva` ← `clases`

**Vistas** (pestana Views, ya calculadas):

| Vista | Para que sirve |
|---|---|
| `vista_reservas_completas` | Todo junto y desnormalizado — ideal para ver POR QUE normalizamos |
| `vista_clases_demanda` | Ranking de clases mas populares |
| `vista_socios_por_centro` | Cuantos socios tiene cada sede |
| `vista_socios_activos` | Quien ha reservado y cuanto |
| `vista_actividad_semanal` | Evolucion de reservas semana a semana |

**Pista LEFT JOIN escondida:**
Hay 3 socios que NUNCA han reservado: Francisco Jimenez, Lucia Llaneza y Oksana Tokmakova.
Con un `JOIN` normal desaparecen. Con `LEFT JOIN` aparecen. Prueba las dos y compara.

## 8) Como sabemos que esta bien

Checklist rapido:

1. Hay duplicados innecesarios? Si si, rediseña.
2. Puedes insertar una clase sin crear reserva? Deberias poder.
3. Si borras una reserva, pierdes datos maestros? No deberia pasar.
4. Cada FK tiene sentido de negocio? Debe ser clara.
5. Puedes responder preguntas con JOIN + GROUP BY? Si, vas bien.

Si fallas en alguno, no es drama: es pista de que el modelo se puede mejorar.

## 9) Meta de hoy

No buscamos SQL perfecto.
Buscamos razonamiento correcto de modelado.
Si entiendes por que separas tablas, vas por el camino bueno.

Resumen final en plan colega:

No hace falta saberselo todo de memoria hoy.
Si sabes explicar por que creaste cada tabla y como se conecta con las demas, ya estas aprendiendo de verdad.
