USE meli

DROP TABLE IF EXISTS tbOrderItem;
DROP TABLE IF EXISTS tbOrder;
DROP TABLE IF EXISTS tbItem;
DROP TABLE IF EXISTS tbCategory;
DROP TABLE IF EXISTS tbCustomer;

CREATE TABLE tbCustomer(
    customer_id INT PRIMARY KEY,
    email VARCHAR(250),
    nombre VARCHAR(250),
    apellido VARCHAR(250),
    sexo CHAR(1),
    dirección VARCHAR(250),
    fecha_de_nacimiento DATE,
    teléfono VARCHAR(50)
)

CREATE TABLE tbCategory(
    category_id INT PRIMARY KEY,
    descripción VARCHAR(250),
    path VARCHAR(250)
)

CREATE TABLE tbItem(
    item_id INT PRIMARY KEY,
    category_id INT,
    preco DECIMAL(10,2) NOT NULL,
    fecha_de_baja DATE,
    seller_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES tbCategory(category_id),
    FOREIGN KEY (seller_id) REFERENCES tbCustomer(customer_id)
)

CREATE TABLE tbOrder(
    order_id INT PRIMARY KEY,
    order_date DATETIME,
    buyer_id INT NOT NULL,
    FOREIGN KEY (buyer_id) REFERENCES tbCustomer(customer_id)
)

CREATE TABLE tbOrderItem(
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, item_id),
    FOREIGN KEY (order_id) REFERENCES tbOrder(order_id),
    FOREIGN KEY (item_id) REFERENCES tbItem(item_id)
)
