

/*--------------------------------------------------------------------------------------------------------------------------------------------*/
/*-----------------------------------------------------------Storage Procedure----------------------------------------------------------------*/
/*--------------------------------------------------------------------------------------------------------------------------------------------*/
USE frave_food;

DELIMITER //
CREATE PROCEDURE SP_REGISTER(IN firstName VARCHAR(50), IN lastName VARCHAR(50), IN phone VARCHAR(11), IN image VARCHAR(250), IN email VARCHAR(100), IN pass VARCHAR(100), IN rol INT, IN nToken VARCHAR(255))
BEGIN
	INSERT INTO Person (firstName, lastName, phone, image) VALUE (firstName, lastName, phone, image);
	
	INSERT INTO users (users, email, passwordd, persona_id, rol_id, notification_token) VALUE (firstName, email, pass, LAST_INSERT_ID(), rol, nToken);
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_LOGIN(IN email VARCHAR(100))
BEGIN
	SELECT p.uid, p.firstName, p.lastName, p.image, u.email, u.passwordd, u.rol_id, u.notification_token FROM person p
	INNER JOIN users u ON p.uid = u.persona_id
	WHERE u.email = email AND p.state = TRUE;
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_RENEWTOKENLOGIN(IN uid INT )
BEGIN
	SELECT p.uid, p.firstName, p.lastName, p.image, p.phone, u.email, u.rol_id, u.notification_token FROM person p
	INNER JOIN users u ON p.uid = u.persona_id
	WHERE p.uid = uid AND p.state = TRUE;
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_ADD_CATEGORY(IN category VARCHAR(50), IN description VARCHAR(100))
BEGIN
	INSERT INTO categories (category, description) VALUE (category, description);
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_USER_BY_ID(IN ID INT)
BEGIN
	SELECT p.uid, p.firstName, p.lastName, p.phone, p.image, u.email, u.rol_id, u.notification_token FROM person p
	INNER JOIN users u ON p.uid = u.persona_id
	WHERE p.uid = 1 AND p.state = TRUE;
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_UPDATE_PROFILE(IN ID INT, IN firstName VARCHAR(50), IN lastName VARCHAR(50), IN phone VARCHAR(11))
BEGIN
	UPDATE person
		SET firstName = firstName,
			 lastName = lastName,
			 phone = phone
	WHERE person.uid = ID;
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_USER_UPDATED(IN ID INT)
BEGIN
	SELECT p.firstName, p.lastName, p.image, u.email, u.rol_id FROM person p
	INNER JOIN users u ON p.uid = u.persona_id
	WHERE p.uid = 1 AND p.state = TRUE;
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_GET_PRODUCTS_TOP()
BEGIN
	SELECT pro.id, pro.nameProduct, pro.description, pro.price, pro.status, ip.picture, c.category, c.id AS category_id FROM products pro
	INNER JOIN categories c ON pro.category_id = c.id
	INNER JOIN imageProduct ip ON pro.id = ip.product_id
	INNER JOIN ( SELECT product_id, MIN(id) AS id_image FROM imageProduct GROUP BY product_id) p3 ON ip.product_id = p3.product_id AND ip.id = p3.id_image
	LIMIT 10;
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_SEARCH_PRODUCT(IN nameProduct VARCHAR(100))
BEGIN
	SELECT pro.id, pro.nameProduct, pro.description, pro.price, pro.status, ip.picture, c.category, c.id AS category_id FROM products pro
	INNER JOIN categories c ON pro.category_id = c.id
	INNER JOIN imageProduct ip ON pro.id = ip.product_id
	INNER JOIN ( SELECT product_id, MIN(id) AS id_image FROM imageProduct GROUP BY product_id) p3 ON ip.product_id = p3.product_id AND ip.id = p3.id_image
	WHERE pro.nameProduct LIKE CONCAT('%', nameProduct , '%');
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_SEARCH_FOR_CATEGORY(IN IDCATEGORY INT)
BEGIN
	SELECT pro.id, pro.nameProduct, pro.description, pro.price, pro.status, ip.picture, c.category, c.id AS category_id FROM products pro
	INNER JOIN categories c ON pro.category_id = c.id
	INNER JOIN imageProduct ip ON pro.id = ip.product_id
	INNER JOIN ( SELECT product_id, MIN(id) AS id_image FROM imageProduct GROUP BY product_id) p3 ON ip.product_id = p3.product_id AND ip.id = p3.id_image
	WHERE pro.category_id = IDCATEGORY;
END//


/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_LIST_PRODUCTS_ADMIN()
BEGIN
	SELECT pro.id, pro.nameProduct, pro.description, pro.price, pro.status, ip.picture, c.category, c.id AS category_id FROM products pro
	INNER JOIN categories c ON pro.category_id = c.id
	INNER JOIN imageProduct ip ON pro.id = ip.product_id
	INNER JOIN ( SELECT product_id, MIN(id) AS id_image FROM imageProduct GROUP BY product_id) p3 ON ip.product_id = p3.product_id AND ip.id = p3.id_image;
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_ALL_ORDERS_STATUS(IN statuss VARCHAR(30))
BEGIN
	SELECT o.id AS order_id, o.delivery_id, CONCAT(pe.firstName, " ", pe.lastName) AS delivery, pe.image AS deliveryImage, o.client_id, CONCAT(p.firstName, " ", p.lastName) AS cliente, p.image AS clientImage, p.phone AS clientPhone, o.address_id, a.street, a.reference, a.Latitude, a.Longitude, o.status, o.pay_type, o.amount, o.currentDate
	FROM orders o
	INNER JOIN person p ON o.client_id = p.uid
	INNER JOIN addresses a ON o.address_id = a.id
	LEFT JOIN person pe ON o.delivery_id = pe.uid
	WHERE o.`status` = statuss;
END//



/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_ORDER_DETAILS(IN IDORDER INT)
BEGIN
	SELECT od.id, od.order_id, od.product_id, p.nameProduct, ip.picture, od.quantity, od.price AS total
	FROM orderdetails od
	INNER JOIN products p ON od.product_id = p.id
	INNER JOIN imageProduct ip ON p.id = ip.product_id
	INNER JOIN ( SELECT product_id, MIN(id) AS id_image FROM imageProduct GROUP BY product_id) p3 ON ip.product_id = p3.product_id AND ip.id = p3.id_image
	WHERE od.order_id = IDORDER;
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE SP_ALL_DELIVERYS()
BEGIN
	SELECT p.uid AS person_id, CONCAT(p.firstName, ' ', p.lastName) AS nameDelivery, p.phone, p.image, u.notification_token FROM person p
	INNER JOIN users u ON p.uid = u.persona_id
	WHERE u.rol_id = 3 AND p.state = 1;
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/


DELIMITER //
CREATE PROCEDURE SP_ORDERS_BY_DELIVERY(IN ID INT, IN statuss VARCHAR(30))
BEGIN
	SELECT o.id AS order_id, o.delivery_id, o.client_id, CONCAT(p.firstName, " ", p.lastName) AS cliente, p.image AS clientImage, p.phone AS clientPhone, o.address_id, a.street, a.reference, a.Latitude, a.Longitude, o.status, o.pay_type, o.amount, o.currentDate
	FROM orders o
	INNER JOIN person p ON o.client_id = p.uid
	INNER JOIN addresses a ON o.address_id = a.id
	WHERE o.status = statuss AND o.delivery_id = ID;
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/


DELIMITER //
CREATE PROCEDURE SP_ORDERS_FOR_CLIENT(IN ID INT)
BEGIN
	SELECT o.id, o.client_id, o.delivery_id, ad.reference, ad.Latitude AS latClient, ad.Longitude AS lngClient ,CONCAT(p.firstName, ' ', p.lastName)AS delivery, p.phone AS deliveryPhone, p.image AS imageDelivery, o.address_id, o.latitude, o.longitude, o.`status`, o.amount, o.pay_type, o.currentDate 
	FROM orders o
	LEFT JOIN person p ON p.uid = o.delivery_id
	INNER JOIN addresses ad ON o.address_id = ad.id 
	WHERE o.client_id = ID
	ORDER BY o.id DESC;
END//

/*---------------------------------------------------------------------------------------------------------------------------------------*/
/*---------------------------------------------------DATA TEST-----------------------------------------------------*/
/*---------------------------------------------------------------------------------------------------------------------------------------*/

/*ADMIN - 1 | CLIENT - 2 | DELIVERY - 3*/

/*USER ADMIN DEFAULT*/
CALL SP_REGISTER('Frave', 'Developer', '986587000', 'without-image.png', 'frave@frave.com', '$2b$10$loiXWqS2XD3Xa5rPwShlwu9tcX3QQYwMHtXNVU0yIrIDQiHigybUC', 1, '');


CALL SP_ADD_CATEGORY('Drinks', 'Description Drinks');
CALL SP_ADD_CATEGORY('Fast Food','Fast Food Description');
CALL SP_ADD_CATEGORY('Soda','Soda Description');
CALL SP_ADD_CATEGORY('Juices','Jucies description');
CALL SP_ADD_CATEGORY('Pizza','pizza description');
CALL SP_ADD_CATEGORY('Snacks','Snacks Description');
CALL SP_ADD_CATEGORY('Salad','Salad Description');
CALL SP_ADD_CATEGORY('Ice Cream','Ice Cream description');


INSERT INTO products (nameProduct, description, price, category_id) VALUES 
	('Heineken', 'heineken Beer heineken Beer heineken Beer heineken Beer heineken Beer heineken Beer heineken Beer heineke', 15, 1),
	('Corona', 'Corona description', 16, 1),
	('Coca Cola', 'Coca Cola description', 5, 3),
	('Pepsi', 'Pepsi description', 7, 3),
	('Sprite', 'Sprite Description', 7, 3),
	('Fanta', 'Fanta Description', 6, 3),
	('Inka cola', 'Inka Cola Description', 9, 3),
	('Hamburguesas', 'Hamburguesas description', 23, 2),
	('Pizza', 'Pizza description', 8.5, 2),
	('Fast food', 'Fast food description', 35, 2),
	('Salad 1', 'Salad 1 description', 45, 7),
	('Salad 2', 'Salad 2 description', 38, 7),
	('Salad 3', 'Salad 3 description', 28, 7),
	('Salad 4', 'Salad 4 description', 39, 7),
	('Salad 5', 'Salad 5 description', 59, 7),
	('Pizza two', 'Pizza two description', 59, 2);
	
INSERT INTO imageProduct (picture, product_id) VALUES 
	('image-1629821931703.jpg', 1),('image-1629821931725.png', 1),('image-1629821931706.jpg', 1),
	('image-1629870138818.jpg', 2),('image-1629870138832.jpg', 2),('image-1629870138806.jpg', 2),
	('image-1629870179686.jpg', 3),('image-1629870179668.jpg', 3),('image-1629870179673.jpg', 3),
	('image-1629870261732.jpg', 4),('image-1629870261705.jpg', 4),('image-1629870261720.jpg', 4),
	('image-1629870352886.jpg', 5),('image-1629870352860.jpg', 5),('image-1629870352878.jpg', 5),
	('image-1629870430590.jpg', 6),('image-1629870430603.jpg', 6),
	('image-1629870531978.jpg', 7),('image-1629870531950.jpg', 7),('image-1629870531968.jpg', 7),
	('image-1629870638120.jpg', 8),('image-1629870638087.jpg', 8),('image-1629870638103.jpg', 8),
	('image-1629870722161.jpg', 9),('image-1629870722097.jpg', 9),('image-1629870722142.jpg', 9),
	('image-1629870861994.jpg', 10),('image-1629870861987.jpg', 10),('image-1629870861988.jpg', 10),
	('image-1629870963896.jpg', 11),('image-1629870963870.jpg', 11),('image-1629870963885.jpg', 11),
	('image-1629871015906.jpg', 12),('image-1629871015857.jpg', 12),('image-1629871015882.jpg', 12),
	('image-1629871040235.jpg', 13),('image-1629871040124.jpg', 13),('image-1629871040218.jpg', 13),
	('image-1629871070308.jpg', 14),('image-1629871070269.jpg', 14),('image-1629871070286.jpg', 14),
	('image-1629871097936.jpg', 15),('image-1629871097906.jpg', 15),('image-1629871097926.jpg', 15),
	('image-1629871137001.jpg', 16),('image-1629871136311.jpg', 16),('image-1629871136326.jpg', 16);























