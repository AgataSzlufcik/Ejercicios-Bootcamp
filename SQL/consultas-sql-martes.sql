SELECT * FROM Invoice;   --que quiero ver - SELECT, de que tabla - Invoice. Muestra todas las columnas de Invoice

SELECT CustomerId AS Cliente, InvoiceDate AS Fecha_Factura, Total FROM Invoice;  -- Muestra solo CustomerId, InvoiceDate y Total

SELECT  Total FROM Invoice WHERE Total > 10;  -- Muestra facturas con Total > 10.,

SELECT Total FROM Invoice WHERE BillingCountry = "USA"; --Muestra facturas del país USA.,

SELECT Total FROM Invoice ORDER BY Total DESC; --Ordena las facturas por Total de mayor a menor.,

SELECT Total FROM Invoice ORDER BY Total DESC LIMIT 5; --Muestra solo las 5 facturas con mayor Total.,

SELECT DISTINCT BillingCountry FROM Invoice; --Lista los países de facturación sin duplicados.,

SELECT Count (*) FROM Invoice; --Cuenta cuántas facturas hay en total.,

SELECT CustomerId, Count (*)  AS Total FROM Invoice GROUP BY CustomerId; --Cuenta cuántas facturas tiene cada CustomerId.,

SELECT BillingCountry, round(AVG(Total),2) AS Total FROM Invoice GROUP BY  BillingCountry ORDER BY Total DESC; --Calcula el ticket medio (AVG(Total)) por BillingCountry y ordénalo de mayor a menor.

SELECT * FROM Invoice Where Total >= 5 AND Total <=10; -- Muestra las facturas con Total entre 5 y 15.,

SELECT * FROM Invoice WHERE BillingCountry = "USA" OR BillingCountry = "Canada" ORDER BY BillingCountry DESC; --Muestra facturas de USA o Canada
 
SELECT BillingCountry, SUM(Total) FROM Invoice   GROUP BY BillingCountry;  --Calcula el gasto total (SUM(Total)) por país.,

SELECT BillingCountry , COUNT(*), SUM(Total) FROM Invoice GROUP BY BillingCountry HAVING Count(*)> 10; -- Muestra solo países con más de 10 facturas (HAVING).,

SELECT CustomerId FROM Invoice GROUP BY CustomerId ORDER BY SUM(Total) DESC LIMIT 10; --Muestra top 10 clientes por gasto total.,

SELECT BillingCountry, COUNT(*),  round(AVG(Total),2) FROM Invoice GROUP BY BillingCountry; --Muestra para cada país: total facturas y ticket medio., COUNT nos mide el volumen de operaciones y SUM el volumen económico.

 SELECT * FROM Invoice WHERE strftime('%Y', InvoiceDate) = "2012"; --Muestra facturas del año 2012 (strftime('%Y', InvoiceDate)).,

 SELECT * FROM Invoice ORDER BY  Total DESC, InvoiceDate DESC Limit 5; --Muestra el top 5 de facturas con mayor total y, en empate, ordena por fecha más reciente.
 

SELECT  CustomerId, COUNT (*) AS Compras
            FROM Invoice
			WHERE Compras = 1
			GROUP BY CustomerId;
            

  
         

