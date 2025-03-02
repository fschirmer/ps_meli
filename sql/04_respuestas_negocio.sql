USE meli;

/*
1. Listar los usuarios que cumplan años el día de hoy cuya cantidad de ventas realizadas en enero 2020 sea superior a
1500.
*/

SELECT
    cus.customer_id, cus.nombre, cus.email, COUNT(DISTINCT ord.order_id) AS total_ventas
FROM tbOrder ord
INNER JOIN tbOrderItem ord_ite
ON ord.order_id = ord_ite.order_id
INNER JOIN tbItem ite
ON ord_ite.item_id = ite.item_id
INNER JOIN tbCustomer cus
ON cus.customer_id = ite.seller_id
WHERE
    cus.fecha_de_nacimiento = CAST(GETDATE() AS DATE)
    AND YEAR(ord.order_date) = 2020
    AND MONTH(ord.order_date) = 1
GROUP BY cus.customer_id, cus.nombre, cus.email
HAVING COUNT(*) > 1500;

/*
2. Por cada mes del 2020, se solicita el top 5 de usuarios que más vendieron($) en la categoría Celulares. Se requiere
el mes y año de análisis, nombre y apellido del vendedor, cantidad de ventas realizadas, cantidad de productos vendidos
y el monto total transaccionado.
*/

-- As vendas devem ser contabilizadas por pedido ou item?
-- Ex.: Existe o pedido 1 e neste pedido constam dois itens do mesmo vendedor. Neste caso é uma única venda
-- considerando o pedido, ou 2 vendas, considerando dois itens no pedido. Neste caso o itme não é a quantidade.
WITH VentasMensuales AS (
    SELECT
        YEAR(ord.order_date) AS ano, MONTH(ord.order_date) AS mes, cus.nombre, cus.apellido,
        COUNT(DISTINCT ord.order_id) AS cantidad_de_ventas_realizadas,
        SUM(cantidad) AS cantidad_de_productos_vendidos,
        SUM(cantidad * precio_unitario) AS monto_total_transaccionado,
        ROW_NUMBER() OVER (PARTITION BY YEAR(ord.order_date), MONTH(ord.order_date)
                           ORDER BY SUM(cantidad * precio_unitario) DESC) AS top_5_usuarios
    FROM tbOrder ord
    INNER JOIN tbOrderItem ord_ite
    ON ord.order_id = ord_ite.order_id
    INNER JOIN tbItem ite
    ON ord_ite.item_id = ite.item_id
    INNER JOIN tbCategory cat
    ON ite.category_id = cat.category_id
    INNER JOIN tbCustomer cus
    ON ite.seller_id = cus.customer_id
    WHERE
        cat.path = 'Celular'
        AND YEAR(ord.order_date) = 2020
    GROUP BY YEAR(ord.order_date), MONTH(ord.order_date), cus.nombre, cus.apellido
)
SELECT
    ano, mes, nombre, apellido, cantidad_de_ventas_realizadas, cantidad_de_productos_vendidos,
    monto_total_transaccionado
FROM VentasMensuales
WHERE
    top_5_usuarios < 6;

/*
3. Se solicita poblar una nueva tabla con el precio y estado de los Ítems a fin del día. Tener en cuenta que debe ser
reprocesable. Vale resaltar que en la tabla Item, vamos a tener únicamente el último estado informado por la PK
definida. (Se puede resolver a través de StoredProcedure)
*/

CREATE TABLE tbItemSnapshot (
    snapshot_date DATE NOT NULL,
    item_id INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    fecha_de_baja VARCHAR(50) NULL,
    PRIMARY KEY (snapshot_date, item_id)
);

CREATE PROCEDURE UpdateItemSnapshot
AS
BEGIN
    -- Usando MERGE para inserir ou atualizar dados
    MERGE INTO tbItemSnapshot AS target
    USING (SELECT item_id, precio, fecha_de_baja FROM tbItem) AS source
    ON target.item_id = source.item_id AND target.snapshot_date = CAST(GETDATE() AS DATE)
    WHEN MATCHED THEN
        UPDATE SET target.precio = source.precio, target.fecha_de_baja = source.fecha_de_baja
    WHEN NOT MATCHED BY TARGET THEN
        INSERT (snapshot_date, item_id, precio, fecha_de_baja)
        VALUES (CAST(GETDATE() AS DATE), source.item_id, source.precio, source.fecha_de_baja);
END;

SELECT * FROM tbItemSnapshot;

SELECT * FROM tbItem;

EXEC UpdateItemSnapshot;

SELECT * FROM tbItemSnapshot;