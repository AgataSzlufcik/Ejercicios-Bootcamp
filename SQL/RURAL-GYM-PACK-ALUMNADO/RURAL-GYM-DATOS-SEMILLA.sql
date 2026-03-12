-- =============================================================
--  RURAL GYM | Base de datos de práctica
--  Bootcamp Data Analyst · Semana 06 · Jueves
-- =============================================================
--
--  TABLAS (modelo normalizado 3FN):
--    centros          → sedes rurales de Asturias
--    socios           → personas inscritas (alumnas + profes)
--    clases           → actividades disponibles
--    reservas         → cabecera de cada reserva (1 por visita)
--    detalle_reserva  → qué clases incluye cada reserva
--                       (clave primaria compuesta: id_reserva + id_clase)
--
--  VISTAS (pestaña Views en DB Browser):
--    vista_reservas_completas  → todo desnormalizado
--    vista_clases_demanda      → ranking de clases más populares
--    vista_socios_por_centro   → socios por sede
--    vista_socios_activos      → socios que han reservado (JOIN)
--    vista_actividad_semanal   → tendencia de reservas por fecha
--
--  PISTA LEFT JOIN:
--    Hay 3 socios SIN ninguna reserva:
--      · Francisco Jimenez     (id 214)
--      · Lucia Llaneza         (id 221)
--      · Oksana Tokmakova      (id 224)
--    → Con LEFT JOIN aparecen; con JOIN normal desaparecen.
--      ¡Prueba las dos y compara!
-- =============================================================

DROP VIEW IF EXISTS vista_actividad_semanal;
DROP VIEW IF EXISTS vista_reservas_completas;
DROP VIEW IF EXISTS vista_clases_demanda;
DROP VIEW IF EXISTS vista_socios_por_centro;
DROP VIEW IF EXISTS vista_socios_activos;
DROP TABLE IF EXISTS detalle_reserva;
DROP TABLE IF EXISTS reservas;
DROP TABLE IF EXISTS clases;
DROP TABLE IF EXISTS socios;
DROP TABLE IF EXISTS centros;

CREATE TABLE centros (
    id_centro INTEGER PRIMARY KEY,
    nombre_centro TEXT NOT NULL
);

CREATE TABLE socios (
    id_socio INTEGER PRIMARY KEY,
    nombre_socio TEXT NOT NULL,
    email_socio TEXT,
    id_centro INTEGER NOT NULL,
    FOREIGN KEY (id_centro) REFERENCES centros(id_centro)
);

CREATE TABLE clases (
    id_clase INTEGER PRIMARY KEY,
    nombre_clase TEXT NOT NULL,
    tipo_clase TEXT NOT NULL,
    duracion_min INTEGER NOT NULL
);

CREATE TABLE reservas (
    id_reserva INTEGER PRIMARY KEY,
    fecha_reserva TEXT NOT NULL,
    id_socio INTEGER NOT NULL,
    FOREIGN KEY (id_socio) REFERENCES socios(id_socio)
);

CREATE TABLE detalle_reserva (
    id_reserva INTEGER NOT NULL,
    id_clase INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    PRIMARY KEY (id_reserva, id_clase),
    FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva),
    FOREIGN KEY (id_clase) REFERENCES clases(id_clase)
);

-- Centros (zonas rurales + alrededores)
INSERT INTO centros (id_centro, nombre_centro) VALUES
(1, 'La Arquera (Malleza, Salas)'),
(2, 'Nava'),
(3, 'La Felguera'),
(4, 'Sotrondio'),
(5, 'Anes (Siero)'),
(6, 'Pola de Laviana'),
(7, 'Villaviciosa'),
(8, 'Santiao d''ambiedes'),
(9, 'Pilona'),
(10, 'Porrua'),
(11, 'Faes'),
(12, 'Gozon'),
(13, 'San Martin de Luina'),
(14, 'Santa Cruz de Mieres'),
(15, 'Trubia'),
(16, 'Teverga'),
(17, 'Serin'),
(18, 'Santianes, Pilona'),
(19, 'Oviedo, Colloto'),
(20, 'Carbayin Alto'),
(21, 'Aller'),
(22, 'Pola de Lena');

-- Socios (alumnado)
INSERT INTO socios (id_socio, nombre_socio, email_socio, id_centro) VALUES
(201, 'Agata Szlufcik', 'agata.szlufcik@ruralcamp.local', 1),
(202, 'Alain Larruscain Santamaria', 'alain.larruscain@ruralcamp.local', 2),
(203, 'Alejandro Posada Gonzalez', 'alejandro.posada@ruralcamp.local', 3),
(204, 'Alejandro Rene Reyes Reyes', 'alejandrorene.reyes@ruralcamp.local', 4),
(205, 'Arantxa Puig Rodriguez', 'arantxa.puig@ruralcamp.local', 5),
(206, 'Arantxa Sacacia Aguado', 'arantxa.sacacia@ruralcamp.local', 6),
(207, 'Carolina Tomas Franco', 'carolina.tomas@ruralcamp.local', 7),
(208, 'Cheyenne Castro Gonzalez', 'cheyenne.castro@ruralcamp.local', 8),
(209, 'Chiara Contreras Mariani', 'chiara.contreras@ruralcamp.local', 9),
(210, 'Claudio Perez', 'claudio.perez@ruralcamp.local', 10),
(211, 'Diana Martinez Trigal', 'diana.martinez@ruralcamp.local', 11),
(212, 'Eva Ponton Gonzalez', 'eva.ponton@ruralcamp.local', 12),
(213, 'Francisco Diaz Busto', 'francisco.diaz@ruralcamp.local', 13),
(214, 'Francisco Jimenez', 'francisco.jimenez@ruralcamp.local', 14),
(215, 'Graciela Alvarez Fernandez', 'graciela.fernandez@ruralcamp.local', 15),
(216, 'Jeniree Del Valle Tovar Lunar', 'jeniree.tovar@ruralcamp.local', 16),
(217, 'Jose Antonio Pascual Puges', 'joseantonio.pascual@ruralcamp.local', 17),
(218, 'Juan Garcia Fernandez-Miranda', 'juan.garcia@ruralcamp.local', 18),
(219, 'Julia Roman Herrero', 'julia.roman@ruralcamp.local', 19),
(220, 'Lucia Pelaez Gonzalez', 'lucia.pelaez@ruralcamp.local', 20),
(221, 'Lucia Llaneza', 'lucia.llaneza@ruralcamp.local', 21),
(222, 'Maria Lamas', 'maria.lamas@ruralcamp.local', 22),
(223, 'Michelle Olivares Maldonado', 'michelle.olivares@ruralcamp.local', 2),
(224, 'Oksana Tokmakova', 'oksana.tokmakova@ruralcamp.local', 3),
(225, 'Sara Bailon Sarmiento', 'sara.bailon@ruralcamp.local', 2),
(226, 'Ivan Gonzalez Asenjo', 'ivan.gonzalez@ruralcamp.local', 3),
(227, 'Anais Rodriguez', 'anais.rodriguez@ruralcamp.local', 19),
(228, 'Yeraldin Salazar', 'yeraldin.salazar@ruralcamp.local', 7);

-- Clases de gimnasio (toque friki divertido)
INSERT INTO clases (id_clase, nombre_clase, tipo_clase, duracion_min) VALUES
(11, 'HIIT del Multiverso (con Anais)', 'cardio', 50),
(12, 'Gluteos de Acero (con Yeraldin)', 'fuerza', 50),
(13, 'Espalda Jedi', 'fuerza', 45),
(14, 'Spinning en la Galaxia', 'cardio', 45),
(15, 'Yoga Ninja Recovery', 'movilidad', 50),
(16, 'Core Saiyan', 'fuerza', 35);

-- Reservas repartidas en 6 semanas (feb-mar 2026)
-- Sin reservas: Francisco Jimenez (214), Lucia Llaneza (221), Oksana Tokmakova (224)
INSERT INTO reservas (id_reserva, fecha_reserva, id_socio) VALUES
-- Semana 2026-02-05
(1001, '2026-02-05', 201),  -- Agata
(1002, '2026-02-05', 203),  -- Alejandro Posada
(1003, '2026-02-05', 207),  -- Carolina
(1004, '2026-02-05', 210),  -- Claudio
(1005, '2026-02-05', 215),  -- Graciela
-- Semana 2026-02-12
(1006, '2026-02-12', 202),  -- Alain
(1007, '2026-02-12', 205),  -- Arantxa Puig
(1008, '2026-02-12', 208),  -- Cheyenne
(1009, '2026-02-12', 213),  -- Francisco Diaz
(1010, '2026-02-12', 218),  -- Juan
(1011, '2026-02-12', 201),  -- Agata (vuelve)
-- Semana 2026-02-19
(1012, '2026-02-19', 204),  -- Alejandro Rene
(1013, '2026-02-19', 206),  -- Arantxa Sacacia
(1014, '2026-02-19', 209),  -- Chiara
(1015, '2026-02-19', 211),  -- Diana
(1016, '2026-02-19', 216),  -- Jeniree
(1017, '2026-02-19', 220),  -- Lucia Pelaez
-- Semana 2026-02-26
(1018, '2026-02-26', 212),  -- Eva
(1019, '2026-02-26', 217),  -- Jose Antonio
(1020, '2026-02-26', 219),  -- Julia
(1021, '2026-02-26', 222),  -- Maria
(1022, '2026-02-26', 225),  -- Sara
(1023, '2026-02-26', 203),  -- Alejandro Posada (vuelve)
-- Semana 2026-03-05
(1024, '2026-03-05', 223),  -- Michelle
(1025, '2026-03-05', 226),  -- Ivan
(1026, '2026-03-05', 227),  -- Anais
(1027, '2026-03-05', 207),  -- Carolina (vuelve)
(1028, '2026-03-05', 205),  -- Arantxa Puig (vuelve)
-- Semana 2026-03-12
(1029, '2026-03-12', 228),  -- Yeraldin
(1030, '2026-03-12', 202),  -- Alain (vuelve)
(1031, '2026-03-12', 210),  -- Claudio (vuelve)
(1032, '2026-03-12', 213),  -- Francisco Diaz (vuelve)
(1033, '2026-03-12', 201),  -- Agata (3a vez, la mas fiel del gym!)
(1034, '2026-03-12', 206),  -- Arantxa Sacacia (vuelve)
(1035, '2026-03-12', 220);  -- Lucia Pelaez (vuelve)

-- Detalle: varias reservas con 2 lineas (muestra la clave compuesta en accion)
INSERT INTO detalle_reserva (id_reserva, id_clase, cantidad) VALUES
-- 2026-02-05
(1001, 11, 1),  -- Agata: HIIT del Multiverso
(1001, 15, 1),  -- Agata: Yoga Ninja Recovery  ← 2 actividades, misma reserva
(1002, 13, 1),  -- Alejandro Posada: Espalda Jedi
(1003, 14, 1),  -- Carolina: Spinning en la Galaxia
(1003, 16, 1),  -- Carolina: Core Saiyan
(1004, 12, 1),  -- Claudio: Gluteos de Acero
(1005, 15, 1),  -- Graciela: Yoga Ninja Recovery
-- 2026-02-12
(1006, 11, 1),  -- Alain: HIIT del Multiverso
(1007, 15, 1),  -- Arantxa Puig: Yoga Ninja
(1007, 13, 1),  -- Arantxa Puig: Espalda Jedi
(1008, 14, 2),  -- Cheyenne: 2 plazas Spinning
(1009, 16, 1),  -- Francisco Diaz: Core Saiyan
(1010, 12, 2),  -- Juan: 2 plazas Gluteos de Acero
(1011, 11, 1),  -- Agata vuelve: HIIT
-- 2026-02-19
(1012, 16, 1),  -- Alejandro Rene: Core Saiyan
(1013, 15, 1),  -- Arantxa Sacacia: Yoga Ninja
(1013, 14, 1),  -- Arantxa Sacacia: Spinning
(1014, 13, 1),  -- Chiara: Espalda Jedi
(1015, 12, 1),  -- Diana: Gluteos de Acero
(1016, 11, 1),  -- Jeniree: HIIT del Multiverso
(1017, 16, 1),  -- Lucia Pelaez: Core Saiyan
-- 2026-02-26
(1018, 13, 1),  -- Eva: Espalda Jedi
(1019, 15, 1),  -- Jose Antonio: Yoga Ninja
(1020, 14, 1),  -- Julia: Spinning en la Galaxia
(1021, 11, 1),  -- Maria: HIIT del Multiverso
(1022, 16, 1),  -- Sara: Core Saiyan
(1022, 12, 1),  -- Sara: Gluteos de Acero
(1023, 13, 2),  -- Alejandro Posada vuelve: 2 plazas Espalda Jedi
-- 2026-03-05
(1024, 12, 1),  -- Michelle: Gluteos de Acero
(1025, 14, 1),  -- Ivan: Spinning en la Galaxia
(1026, 11, 1),  -- Anais: HIIT del Multiverso
(1026, 15, 1),  -- Anais: Yoga Ninja Recovery
(1027, 16, 1),  -- Carolina vuelve: Core Saiyan
(1028, 13, 1),  -- Arantxa Puig vuelve: Espalda Jedi
-- 2026-03-12
(1029, 11, 1),  -- Yeraldin: HIIT del Multiverso
(1029, 12, 1),  -- Yeraldin: Gluteos de Acero  ← tiene que representarla!
(1030, 15, 2),  -- Alain vuelve: 2 plazas Yoga Ninja
(1031, 13, 1),  -- Claudio vuelve: Espalda Jedi
(1032, 14, 1),  -- Francisco Diaz vuelve: Spinning
(1033, 11, 1),  -- Agata 3a vez: HIIT (la mas fiel del gym!)
(1034, 16, 1),  -- Arantxa Sacacia vuelve: Core Saiyan
(1035, 12, 1);  -- Lucia Pelaez vuelve: Gluteos de Acero

-- =============================================================
--  VISTAS (visibles en DB Browser > pestaña Views)
-- =============================================================

-- VISTA 1: Reservas completas desnormalizadas
-- Util para comparar con el modelo normalizado
CREATE VIEW vista_reservas_completas AS
SELECT
    r.id_reserva,
    r.fecha_reserva,
    s.nombre_socio,
    ce.nombre_centro,
    c.nombre_clase,
    c.tipo_clase,
    c.duracion_min,
    dr.cantidad
FROM reservas r
JOIN socios s       ON r.id_socio   = s.id_socio
JOIN centros ce     ON s.id_centro  = ce.id_centro
JOIN detalle_reserva dr ON r.id_reserva = dr.id_reserva
JOIN clases c       ON dr.id_clase  = c.id_clase;

-- VISTA 2: Demanda por clase
CREATE VIEW vista_clases_demanda AS
SELECT
    c.id_clase,
    c.nombre_clase,
    c.tipo_clase,
    c.duracion_min,
    COUNT(DISTINCT dr.id_reserva) AS num_reservas,
    SUM(dr.cantidad)              AS total_plazas
FROM clases c
LEFT JOIN detalle_reserva dr ON c.id_clase = dr.id_clase
GROUP BY c.id_clase
ORDER BY total_plazas DESC;

-- VISTA 3: Socios por centro (cuantos miembros tiene cada sede)
CREATE VIEW vista_socios_por_centro AS
SELECT
    ce.id_centro,
    ce.nombre_centro,
    COUNT(s.id_socio) AS total_socios
FROM centros ce
LEFT JOIN socios s ON ce.id_centro = s.id_centro
GROUP BY ce.id_centro
ORDER BY total_socios DESC;

-- VISTA 4: Socios activos (han hecho al menos una reserva)
CREATE VIEW vista_socios_activos AS
SELECT DISTINCT
    s.id_socio,
    s.nombre_socio,
    ce.nombre_centro,
    COUNT(r.id_reserva) AS total_reservas
FROM socios s
JOIN centros ce ON s.id_centro = ce.id_centro
JOIN reservas r ON s.id_socio = r.id_socio
GROUP BY s.id_socio
ORDER BY total_reservas DESC;

-- VISTA 5: Actividad semanal (evolución de reservas por fecha)
CREATE VIEW vista_actividad_semanal AS
SELECT
    r.fecha_reserva,
    COUNT(DISTINCT r.id_reserva) AS num_reservas,
    COUNT(DISTINCT r.id_socio)   AS socios_distintos,
    SUM(dr.cantidad)             AS plazas_totales
FROM reservas r
JOIN detalle_reserva dr ON r.id_reserva = dr.id_reserva
GROUP BY r.fecha_reserva
ORDER BY r.fecha_reserva;

-- =============================================================
--  CONSULTAS SUGERIDAS (copiar en la pestaña SQL de DB Browser)
-- =============================================================

-- 1. ¿Qué clase arrasa en el gym?
-- SELECT * FROM vista_clases_demanda;

-- 2. ¿Cuántos socios tiene cada sede rural?
-- SELECT * FROM vista_socios_por_centro;

-- 3. Ver todas las reservas con todos los datos (vista desnormalizada)
-- SELECT * FROM vista_reservas_completas;

-- 4. ¿Cómo ha evolucionado la actividad semana a semana?
-- SELECT * FROM vista_actividad_semanal;

-- 5. ¿Quiénes reservan más actividades por visita?
-- SELECT nombre_socio, SUM(cantidad) AS actividades_totales
-- FROM vista_reservas_completas
-- GROUP BY nombre_socio
-- HAVING actividades_totales > 1
-- ORDER BY actividades_totales DESC;

-- 6. LEFT JOIN: socios que NUNCA han reservado (los que se escapan con JOIN normal)
-- SELECT s.id_socio, s.nombre_socio, ce.nombre_centro, r.id_reserva
-- FROM socios s
-- JOIN centros ce ON s.id_centro = ce.id_centro
-- LEFT JOIN reservas r ON s.id_socio = r.id_socio
-- WHERE r.id_reserva IS NULL;

-- 7. ¿Cuántas clases de fuerza vs cardio vs movilidad hay?
-- SELECT tipo_clase, COUNT(*) AS num_clases, AVG(duracion_min) AS media_minutos
-- FROM clases
-- GROUP BY tipo_clase;

-- 8. ¿Qué socios son los más fieles (más de 1 reserva)?
-- SELECT s.nombre_socio, COUNT(r.id_reserva) AS veces_reservado
-- FROM socios s
-- JOIN reservas r ON s.id_socio = r.id_socio
-- GROUP BY s.id_socio
-- HAVING veces_reservado > 1
-- ORDER BY veces_reservado DESC;
