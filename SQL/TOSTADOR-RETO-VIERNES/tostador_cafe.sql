INSERT INTO ventas_nuevas (id_venta, fecha_venta, canal_venta, id_cliente, id_zona, total_venta)
SELECT DISTINCT
    id_venta,
    fecha_venta,
    canal_venta,
    id_cliente,
    id_zona,
    total_venta
FROM ventas_cafe_raw;





