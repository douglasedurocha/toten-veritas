INSERT INTO products(name, price, initial_price, category, image, quantity)
VALUES
    ('Product 1', '10.00', '10.00', 'bebida', 'assets/product1.png', '10'),
    ('Product 2', '20.00', '20.00', 'salgado', 'assets/product2.png', '20'),
    ('Product 3', '30.00', '30.00', 'doce', 'assets/product3.png', '30'),
    ('Promo Product', '7.00', '10.00', 'bebida', 'assets/product1.png', '10');

INSERT INTO users(id, username, email, balance)
VALUES
    ('123', 'admin', 'admin@admin.com', '100.00'),
    ('456', 'user', 'user@user.com', '50.00');