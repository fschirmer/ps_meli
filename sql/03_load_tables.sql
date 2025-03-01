USE meli;

-- Inserindo Customers (Compradores/Vendedores)
INSERT INTO tbCustomer (customer_id, email, nombre, apellido, sexo, dirección, fecha_de_nacimiento, teléfono)
VALUES
(1, 'cliente1@email.com', 'Carlos', 'Silva', 'M', 'Rua A, 123', GETDATE(), '11999990000'),
(2, 'cliente2@email.com', 'Maria', 'Fernandes', 'F', 'Rua B, 456', '1992-03-15', '11888881111'),
(3, 'cliente3@email.com', 'João', 'Pereira', 'M', 'Rua C, 789', '1980-10-30', '11777772222'),
(4, 'cliente4@email.com', 'Ana', 'Souza', 'F', 'Rua D, 321', '1995-05-05', '11666663333');

-- Inserindo Categorias
INSERT INTO tbCategory (category_id, descripción, path)
VALUES
(1, 'Eletrônicos', '/eletronicos'),
(2, 'Roupas', '/roupas'),
(3, 'Livros', '/livros');

-- Inserindo Itens (Vinculados a categorias e vendedores)
INSERT INTO tbItem (item_id, category_id, fecha_de_baja, seller_id)
VALUES
(1, 1, NULL, 1),
(2, 1, NULL, 2),
(3, 2, NULL, 3),
(4, 2, NULL, 4),
(5, 3, NULL, 1);

-- Inserindo Orders (Compradores fazendo pedidos)
INSERT INTO tbOrder (order_id, order_date, buyer_id)
VALUES
(1, '2024-02-01 10:00:00', 3),
(2, '2024-02-02 12:30:00', 4),
(3, '2024-02-03 14:45:00', 1);

-- Inserindo Itens nos Pedidos
INSERT INTO tbOrderItem (order_id, item_id, quantidade, preco_unitario)
VALUES
(1, 1, 2, 1500.00),
(1, 3, 1, 80.00),
(2, 2, 1, 1200.00),
(3, 4, 3, 50.00);
