SELECT COUNT(*) AS filas_raw FROM ventas_cafe_raw;
SELECT COUNT(DISTINCT id_venta) AS ventas_unicas_raw FROM ventas_cafe_raw;
SELECT ROUND(SUM(total_venta), 2) AS facturacion_raw FROM ventas_cafe_raw;

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre_cliente TEXT,
    email_cliente TEXT,
    id_zona INTEGER,
    FOREIGN KEY (id_zona) REFERENCES zonas(id_zona)
);

CREATE TABLE cafes (
    id_cafe INTEGER PRIMARY KEY,
    nombre_cafe TEXT,
    origen_cafe TEXT,
    proceso_cafe TEXT,
    nivel_tueste TEXT
);

CREATE TABLE zonas (
id_zona INTEGER PRIMARY KEY,
nombre_zona TEXT
);


CREATE TABLE ventas (
    id_venta INTEGER PRIMARY KEY,
    fecha_venta TEXT,
    canal_venta TEXT,
    id_cliente INTEGER,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE detalle_venta (
    id_venta INTEGER,
    id_cafe INTEGER,
    formato_paquete TEXT,
    precio_unitario REAL,
    cantidad INTEGER,
    total_linea REAL,
    PRIMARY KEY (id_venta, id_cafe, formato_paquete),
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_cafe) REFERENCES cafes(id_cafe)
);



CREATE TABLE valoraciones (
    id_cliente INTEGER,
    id_cafe INTEGER,
    id_venta INTEGER,
    valoracion INTEGER NOT NULL,
    comentario_valoracion TEXT,
    PRIMARY KEY (id_cliente, id_cafe, id_venta),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_cafe) REFERENCES cafes(id_cafe),
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta)
);


INSERT INTO zonas (id_zona, nombre_zona)
SELECT DISTINCT id_zona, nombre_zona
FROM ventas_cafe_raw;

INSERT INTO clientes (id_cliente, nombre_cliente, email_cliente, id_zona)
SELECT DISTINCT id_cliente, nombre_cliente, email_cliente, id_zona
FROM ventas_cafe_raw;

INSERT INTO cafes (id_cafe, nombre_cafe, origen_cafe, proceso_cafe, nivel_tueste)
SELECT DISTINCT id_cafe, nombre_cafe, origen_cafe, proceso_cafe, nivel_tueste
FROM ventas_cafe_raw;

INSERT INTO ventas (id_venta, fecha_venta, canal_venta, id_cliente)
SELECT DISTINCT id_venta, fecha_venta, canal_venta, id_cliente
FROM ventas_cafe_raw;

INSERT INTO detalle_venta ( id_venta, id_cafe, formato_paquete, precio_unitario, cantidad, total_linea)
SELECT 
    id_venta,
    id_cafe,
    formato_paquete,
    precio_unitario,
    cantidad,
    total_venta
FROM ventas_cafe_raw;



INSERT INTO valoraciones (id_cliente, id_cafe, id_venta, valoracion, comentario_valoracion)
SELECT DISTINCT
    id_cliente,
    id_cafe,
    id_venta,
    valoracion,
    comentario_valoracion
FROM ventas_cafe_raw
WHERE valoracion IS NOT NULL;


SELECT COUNT(*) AS filas_raw 
FROM ventas_cafe_raw;

SELECT COUNT(*) AS filas_normalizadas_desde_detalle
FROM detalle_venta;



SELECT COUNT(DISTINCT id_venta)
FROM ventas_cafe_raw;

SELECT COUNT(*) AS eventos_unicos_normalizado
FROM ventas;



SELECT ROUND(SUM(total_venta),2)
FROM ventas_cafe_raw;

SELECT ROUND(SUM(total_linea), 2) AS facturacion_normalizada
FROM detalle_venta;

--    CONSULTAS:

-- 1. Los 5 cafes con mayor facturacion.

SELECT cafes.nombre_cafe,                            -- mostrar el nombre del cafe.
ROUND(SUM(total_linea),2) AS facturacion  --suma todas las ventas de cafes, redondeadas
FROM detalle_venta                                         -- de la tabla detale_venta
JOIN cafes                                                            -- en detalle_venta solo tenemos el id del cafee, pero queremos el nombre del cafe. JOIN - unimos la tabla cafe
ON detalle_venta.id_cafe = cafes.id_cafe    --conectamos
GROUP BY cafes.nombre_cafe                        --agrupamos por nombres
ORDER BY facturacion DESC                          --ordenamos la suma de mayor a menor
LIMIT 5;                                                                -- solo 5 primeros resultados


-- 2. Zonas con mayor volumen de ventas.

SELECT zonas.nombre_zona, count(ventas.id_venta) AS facturacion
FROM ventas
JOIN clientes
ON ventas.id_cliente = clientes.id_cliente
JOIN zonas
ON zonas.id_zona = clientes.id_zona
GROUP BY zonas.nombre_zona
ORDER BY facturacion DESC;



-- 3. Top 3 cafes por valoracion media (minimo 3 valoraciones).

SELECT cafes.nombre_cafe, ROUND(AVG(valoracion),2) AS valoracion_media
FROM valoraciones 
JOIN cafes
ON cafes.id_cafe = valoraciones.id_cafe
GROUP BY nombre_cafe
order by valoracion_media DESC
LIMIT 3;



-- 4. Ticket medio por canal (`tienda` vs `online`).

SELECT canal_venta, round(avg(total_venta), 2) as total_facturacion
FROM ventas
GROUP by canal_venta;
LIMIT 3;


-- 5. Consulta libre: recomendacion de cafe para "snobs" (ventas + valoracion).

SELECT cafes.nombre_cafe, ROUND(AVG(valoraciones.valoracion), 2) AS rating_promedio, COUNT(detalle_venta.id_venta) AS ventas
FROM cafes
JOIN detalle_venta 
    ON cafes.id_cafe = detalle_venta.id_cafe
JOIN valoraciones 
    ON cafes.id_cafe = valoraciones.id_cafe
GROUP BY cafes.id_cafe
HAVING AVG(valoraciones.valoracion) >= 4
ORDER BY rating_promedio DESC, ventas DESC;