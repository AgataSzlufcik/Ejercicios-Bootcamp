SELECT COUNT(*) AS filas_raw FROM ventas_cafe_raw;
SELECT COUNT(DISTINCT id_venta) AS ventas_unicas_raw FROM ventas_cafe_raw;
SELECT ROUND(SUM(total_venta), 2) AS facturacion_raw FROM ventas_cafe_raw;

CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nombre_cliente TEXT,
    email_cliente TEXT
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
    id_zona INTEGER,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_zona) REFERENCES zonas(id_zona)
);

CREATE TABLE detalle_venta (
    id_venta INTEGER,
    id_cafe INTEGER,
    formato_paquete TEXT,
    precio_unitario REAL,
    cantidad INTEGER,
    PRIMARY KEY (id_venta, id_cafe),
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_cafe) REFERENCES cafes(id_cafe)
);

CREATE TABLE valoraciones (
    id_valoracion INTEGER PRIMARY KEY,
    id_cliente INTEGER,
    id_cafe INTEGER,
    valoracion INTEGER NOT NULL,
    comentario_valoracion TEXT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_cafe) REFERENCES cafes(id_cafe)
	);

INSERT INTO clientes (id_cliente, nombre_cliente, email_cliente)
SELECT DISTINCT
id_cliente,
nombre_cliente,
email_cliente
FROM ventas_cafe_raw;


INSERT INTO cafes (id_cafe, nombre_cafe, origen_cafe, proceso_cafe, nivel_tueste)
SELECT DISTINCT
id_cafe,
nombre_cafe,
origen_cafe,
proceso_cafe,
nivel_tueste
FROM ventas_cafe_raw;

INSERT INTO zonas (id_zona, nombre_zona)
SELECT DISTINCT
id_zona,
nombre_zona
FROM ventas_cafe_raw;

INSERT INTO ventas (id_venta, fecha_venta, canal_venta, id_cliente, id_zona)
SELECT DISTINCT
id_venta,
fecha_venta,
canal_venta,
id_cliente,
id_zona
FROM ventas_cafe_raw;


INSERT INTO detalle_venta (id_venta, id_cafe, formato_paquete, precio_unitario, cantidad)
SELECT
id_venta,
id_cafe,
formato_paquete,
precio_unitario,
cantidad
FROM ventas_cafe_raw;

INSERT INTO valoraciones (id_cliente, id_cafe, valoracion, comentario_valoracion)
SELECT
id_cliente,
id_cafe,
valoracion,
comentario_valoracion
FROM ventas_cafe_raw



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

SELECT ROUND(SUM(precio_unitario * cantidad), 2) AS facturacion_normalizada
FROM detalle_venta;




--cambios - añadiendo total_venta

CREATE TABLE ventas (
    id_venta INTEGER PRIMARY KEY,
    fecha_venta TEXT,
    canal_venta TEXT,
    id_cliente INTEGER,
    id_zona INTEGER,
    total_venta NUMERIC
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_zona) REFERENCES zonas(id_zona)
);


INSERT INTO ventas (id_venta, fecha_venta, canal_venta, id_cliente, id_zona, total_venta)
SELECT DISTINCT
id_venta,
fecha_venta,
canal_venta,
id_cliente,
id_zona,
SUM(total_venta)
FROM ventas_cafe_raw
GROUP BY id_venta;

-- cambios descartados


-- 1. Los 5 cafes con mayor facturacion.

SELECT cafes.nombre_cafe,                            -- mostrar el nombre del cafe.
ROUND(SUM(detalle_venta.precio_unitario * detalle_venta.cantidad),2) AS facturacion  --suma todas las ventas de cafes, redondeadas
FROM detalle_venta                                         -- de la tabla detale_venta
JOIN cafes                                                            -- en detalle_venta solo tenemos el id del cafee, pero queremos el nombre del cafe. JOIN - unimos la tabla cafe
ON detalle_venta.id_cafe = cafes.id_cafe    --conectamos
GROUP BY cafes.nombre_cafe                        --agrupamos por nombres
ORDER BY facturacion DESC                          --ordenamos la suma de mayor a menor
LIMIT 5;                                                                -- solo 5 primeros resultados


-- 2. Zonas con mayor volumen de ventas.

SELECT zonas.nombre_zona, COUNT(ventas.id_venta) AS facturacion
FROM ventas
JOIN zonas
ON zonas.id_zona = ventas.id_zona
GROUP BY zonas.nombre_zona
ORDER BY facturacion DESC;


-- 3. Top 3 cafes por valoracion media (minimo 3 valoraciones).
 
 SELECT cafes.nombre_cafe, COUNT(valoraciones.valoracion) AS top_3
 FROM valoraciones
 JOIN cafes
 ON cafes.id_cafe = valoraciones.id_cafe
 GROUP BY nombre_cafe 
 ORDER BY top_3 DESC
 LIMIT 3; 


-- 4. Ticket medio por canal (`tienda` vs `online`).

SELECT ventas.canal_venta, ROUND(AVG(detalle_venta.precio_unitario * detalle_venta.cantidad),2) AS ticket_medio
FROM detalle_venta
JOIN ventas
ON ventas.id_venta = detalle_venta.id_venta
GROUP BY canal_venta
ORDER BY ticket_medio DESC


-- 5. Consulta libre: recomendacion de cafe para "snobs" (ventas + valoracion).

SELECT cafes.nombre_cafe, AVG(valoraciones.valoracion), COUNT(
FROM 
JOIN
ON
JOIN 
ON
