INSERT INTO products(name, price, initial_price, category, image, quantity)
VALUES
    ('Refrigerante', '10.00', '10.00', 'bebida', '/home/ubuntu/images/product1.png', '10'),
    ('Coxinha', '20.00', '20.00', 'salgado', '/home/ubuntu/images/assets/product2.png', '20'),
    ('Brigadeiro', '30.00', '30.00', 'doce', '/home/ubuntu/images/assets/product3.png', '30'),
    ('Hambúrguer', '7.00', '10.00', 'salgado', '/home/ubuntu/images/assets/product1.png', '10');

INSERT INTO users(id, username, email, balance)
VALUES
    ('123', 'admin', 'admin@admin.com', '100.00'),
    ('456', 'user', 'user@user.com', '50.00');