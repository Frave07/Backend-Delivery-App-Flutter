CREATE DATABASE frave_food;

USE frave_food;

CREATE TABLE roles
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	rol VARCHAR(50) NOT NULL,
	description VARCHAR(100) NOT NULL,
	state BOOL DEFAULT 1
);

INSERT INTO roles (rol, description) VALUES ('Admin', 'Admin'), ('Client', 'Client'), ('Delivery', 'Delivery');

CREATE TABLE Person
(
	uid INT PRIMARY KEY AUTO_INCREMENT,
	firstName VARCHAR(50) NULL,
	lastName VARCHAR(50) NULL,
	phone VARCHAR(11) NULL,
	image VARCHAR(250) NULL,
	state BOOL DEFAULT 1,
	created DATETIME DEFAULT NOW()
);

CREATE TABLE addresses
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	street VARCHAR(100) NULL,
	reference VARCHAR(100) NULL,
	Latitude VARCHAR(50) NULL,
	Longitude VARCHAR(50) NULL,
	persona_id INT NOT NULL,
	FOREIGN KEY (persona_id) REFERENCES Person(uid)
);

CREATE TABLE users
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	users VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL,
	passwordd VARCHAR(100) NOT NULL,
	persona_id INT NOT NULL,
	rol_id INT NOT NULL,
	notification_token VARCHAR(255) NULL,
	UNIQUE KEY (email),
	FOREIGN KEY (persona_id) REFERENCES Person(uid),
	FOREIGN KEY (rol_id) REFERENCES roles(id)
);


CREATE TABLE categories
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	category VARCHAR(50) NOT NULL,
	description VARCHAR(100) NULL 
);


CREATE TABLE products
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nameProduct VARCHAR(50) NOT NULL,
	description VARCHAR(200) NULL,
	price DOUBLE(11,2) NOT NULL,
	status BOOL DEFAULT 1,
	category_id INT NOT NULL,
	
	FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE imageProduct
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	picture VARCHAR(255) NULL,
	product_id INT NOT NULL,
	
	FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE orders
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	client_id INT NOT NULL,
	delivery_id INT NULL,
	address_id INT NOT NULL,
	latitude VARCHAR(50) NULL,
	longitude VARCHAR(50) NULL,
	status VARCHAR(50) DEFAULT "PAID OUT",
	receipt VARCHAR(100),
	amount DOUBLE(11,2),
	pay_type VARCHAR(50) NOT NULL,
	currentDate DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (client_id) REFERENCES Person(uid),
	FOREIGN KEY (delivery_id) REFERENCES Person(uid),
	FOREIGN KEY (address_id) REFERENCES addresses(id)
);


CREATE TABLE orderDetails
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	order_id INT NOT NULL,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	price DOUBLE(11,2) NOT NULL,
	FOREIGN KEY(order_id) REFERENCES orders(id),
	FOREIGN KEY(product_id) REFERENCES Products(id)
);



























	










