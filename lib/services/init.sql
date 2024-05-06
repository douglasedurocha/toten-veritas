CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    price DECIMAL NOT NULL,
    initial_price DECIMAL,
    category VARCHAR(50),
    image TEXT,
    quantity INT NOT NULL
);

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    username VARCHAR (50) NOT NULL,
    email VARCHAR (50) NOT NULL,
    balance DECIMAL NOT NULL
);

CREATE TABLE order (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE cart_items (
    id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL,
    order_id INTEGER NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES users(id) ON DELETE CASCADE
);