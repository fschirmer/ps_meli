USE meli;

-- Inserindo Customers (Compradores/Vendedores)
INSERT INTO tbCustomer(customer_id, email, nombre, apellido, sexo, dirección, fecha_de_nacimiento, teléfono)
VALUES
(1, 'cliente1@email.com', 'Carlos', 'Silva', 'M', 'Rua A, 123', GETDATE(), '11999990000'),
(2, 'cliente2@email.com', 'Maria', 'Fernandes', 'F', 'Rua B, 456', '1992-03-15', '11888881111'),
(3, 'cliente3@email.com', 'João', 'Pereira', 'M', 'Rua C, 789', '1980-10-30', '11777772222'),
(4, 'cliente4@email.com', 'Ana', 'Souza', 'F', 'Rua D, 321', '1995-05-05', '11666663333');

-- Inserindo Categorias
INSERT INTO tbCategory(category_id, descripción, path)
VALUES
(1, 'Eletrônicos', '/eletronicos'),
(2, 'Roupas', '/roupas'),
(3, 'Livros', '/livros');

-- Inserindo Itens (Vinculados a categorias e vendedores)
INSERT INTO tbItem(item_id, category_id, precio, fecha_de_baja, seller_id)
VALUES
(1, 1, 10.51, NULL, 1),
(2, 1, 154.25, NULL, 2),
(3, 2, 1.13, NULL, 3),
(4, 2, 1200.00, NULL, 4),
(5, 3, 13.89, NULL, 1);

-- Inserindo Orders (Compradores fazendo pedidos)
INSERT INTO tbOrder(order_id, order_date, buyer_id)
VALUES
(1, '2020-01-01 10:00:00', 3),
(2, '2020-01-02 12:30:00', 4),
(3, '2020-01-03 14:45:00', 2),
(4, '2020-01-03 14:45:00', 2),
(5, '2020-01-03 14:45:00', 2),
(6, '2020-01-03 14:45:00', 1),
(7, '2020-08-01 10:00:00', 3),
(8, '2020-08-02 12:30:00', 4),
(9, '2020-08-03 14:45:00', 2),
(10, '2020-08-03 14:45:00', 2),
(11, '2020-08-03 14:45:00', 2),
(12, '2020-08-03 14:45:00', 2);

-- Inserindo Itens nos Pedidos
INSERT INTO tbOrderItem (order_id, item_id, cantidad, precio_unitario)
VALUES
(1, 1, 2, 1500.00),
(1, 5, 2, 1500.00),
(1, 3, 1, 80.00),
(2, 2, 1, 1200.00),
(3, 1, 1, 10.00),
(4, 1, 1, 10.00),
(5, 5, 5, 50.00),
(6, 5, 5, 50.00),
(7, 1, 2, 1500.00),
(7, 5, 2, 1500.00),
(7, 3, 1, 80.00),
(8, 2, 1, 1200.00),
(9, 1, 1, 10.00),
(10, 1, 1, 10.00),
(11, 5, 5, 50.00),
(12, 5, 5, 50.00);
