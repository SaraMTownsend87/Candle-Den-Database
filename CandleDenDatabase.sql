
-- -------------------------------------
-- Inventory Database
-- -------------------------------------

DROP DATABASE IF EXISTS `CandlesDen_inventory`;
CREATE DATABASE `CandlesDen_inventory`;
USE `CandlesDen_inventory`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;


CREATE TABLE `products` (
  `product_id` int(24) NOT NULL AUTO_INCREMENT,
  `Scent` varchar(50) NOT NULL,
  `Small_Quantity` int(10) NOT NULL,
  `Medium_Quantity` int(10) NOT NULL,
  `Large_Quantity` int(10) NOT NULL,
  
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `products` VALUES (1,'Lavender',100,64,5);
INSERT INTO `products` VALUES (2,'Jasmine',45,85,64);
INSERT INTO `products` VALUES (3,'Citrus',55,9,153);
INSERT INTO `products` VALUES (4,'Bergamot Orange',85,64,184);
INSERT INTO `products` VALUES (5,'Grapefruit',21,65,48);
INSERT INTO `products` VALUES (6,'Lilac',22,15,85);
INSERT INTO `products` VALUES (7,'Pumpkin',98,110,2);
INSERT INTO `products` VALUES (8,'Cinnamon',11,65,150);
INSERT INTO `products` VALUES (9,'Vanilla',31,85,149);
INSERT INTO `products` VALUES (10,'Patchouli',65,78,46);
INSERT INTO `products` VALUES (11,'Lemongrass',25,65,28);
INSERT INTO `products` VALUES (12,'Vetiver',135,135,135);
INSERT INTO `products` VALUES (13,'Pine',1,45,2);
INSERT INTO `products` VALUES (14,'Peony',54,74,124);
INSERT INTO `products` VALUES (15,'Amber',69,15,83);
INSERT INTO `products` VALUES (16,'Rose',135,154,186);
INSERT INTO `products` VALUES (17,'Lemon',1,25,65);
INSERT INTO `products` VALUES (18,'Sandalwood',38,15,78);
INSERT INTO `products` VALUES (19,'Peppermint',25,64,18);
INSERT INTO `products` VALUES (20,'Cranberry',64,15,85);
INSERT INTO `products` VALUES (21,'Cherry',73,15,98);
INSERT INTO `products` VALUES (22,'Musk',45,61,88);
INSERT INTO `products` VALUES (23,'Eucalyptus',91,78,64);
INSERT INTO `products` VALUES (24,'Gardenia',12,58,64);


CREATE TABLE `cost` (
  `cost_id` int(10) NOT NULL AUTO_INCREMENT,
  `size` varchar(10) NOT NULL,
  `cost_amount` int(10) NOT NULL,
  
  PRIMARY KEY (`cost_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `cost` VALUES (1,'Small',9.99);
INSERT INTO `cost` VALUES (2,'Medium',19.99);
INSERT INTO `cost` VALUES (3,'Large',29.99);



-- ------------------------------
-- Customer datebase 
-- -------------------------------

DROP DATABASE IF EXISTS `customer_info`;
CREATE DATABASE `customer_info`; 
USE `customer_info`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;


CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` char(2) NOT NULL,
  `Zip` varchar(5) not NULL,
  `phone` varchar(50) DEFAULT NULL,
 
  
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `customers` VALUES (1,'Rachel Green','547 Rockefeller st','New York City','NY','10001','315-252-7305');
INSERT INTO `customers` VALUES (2,'Monica Geller','8706 nw 35 st','Coral Springs','FL','33083','304-659-1170');
INSERT INTO `customers` VALUES (3,'Ross Geller','900 Exposition Blvd','Los Angeles','CA','90007','415-144-6037');
INSERT INTO `customers` VALUES (4,'Pheobe Buffay','5010 Maple Ave','Dallas','TX','75235','254-750-0784');
INSERT INTO `customers` VALUES (5,'Joey Tribianni','1600 Pennsylvania Avenue NW','Washington','DC','20500','971-888-9129');
INSERT INTO `customers` VALUES (6,'Chandler Bing','177 N State St','Chicago','IL','60601','971-888-9129');

-- ------------------------------
-- Order datebase 
-- -------------------------------

DROP DATABASE IF EXISTS `order_info`;
CREATE DATABASE `order_info`; 
USE `order_info`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;

CREATE TABLE `order_status` (
  `order_status_id` int(10) NOT NULL,
  `order_status_name` varchar(20) NOT NULL,
  PRIMARY KEY (`order_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `order_status` VALUES (1,'Processed');
INSERT INTO `order_status` VALUES (2,'Shipped');
INSERT INTO `order_status` VALUES (3,'Delivered');


 
  
Create TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `shipped_date` date DEFAULT NULL,
 
  PRIMARY KEY (`order_id`),
  KEY `fk_orders_customers_id` (`customer_id`),
  KEY `fk_orders_order_status_id` (`status`),
  
  CONSTRAINT `fk_orders_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_order_statuses` FOREIGN KEY (`status`) REFERENCES `order_statuses` (`order_status_id`) ON UPDATE CASCADE
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `orders` VALUES (1,1,'2023-07-21',2,'2023-08-01');
 INSERT INTO `orders` VALUES (2,2,'2023-08-06',1,NULL);
INSERT INTO `orders` VALUES (3,3,'2023-01-25',3,'2023-01-30');
INSERT INTO `orders` VALUES (4,4,'2022-12-15',1,'2023-12-17');
INSERT INTO `orders` VALUES (5,5,'2023-05-05',3,'2023-05-09');
INSERT INTO `orders` VALUES (6,6,'2023-08-01',2,'2023-08-06');


CREATE TABLE `order_items` (
  `order_id` int(10) NOT NULL AUTO_INCREMENT,
  `product_id` int(10) NOT NULL,
  `quantity` int(10) NOT NULL,
  `cost_id` int(10) NOT NULL,

  PRIMARY KEY (`order_id`,`product_id`),
  KEY `fk_ordered_items_products_id` (`product_id`),
  CONSTRAINT `fk_ordered_items_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_ordered_items_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON UPDATE CASCADE,
   CONSTRAINT `fk_ordered_items_cost` FOREIGN KEY (`cost_id`) REFERENCES `cost` (`cost_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `order_items` VALUES (1,24,4,1);
INSERT INTO `order_items` VALUES (2,11,2,3);
INSERT INTO `order_items` VALUES (3,4,4,2);
INSERT INTO `order_items` VALUES (4,16,2,2);
INSERT INTO `order_items` VALUES (5,3,10,3);
INSERT INTO `order_items` VALUES (6,1,7,3);

-- ------------------------------
-- Payment datebase 
-- -------------------------------

DROP DATABASE IF EXISTS `Payment_info`;
CREATE DATABASE `Payment_info`; 
USE `Payment_info`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;

CREATE TABLE `payment_methods` (
  `payment_method_id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`payment_method_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `payment_methods` VALUES (1,'Credit Card');
INSERT INTO `payment_methods` VALUES (2,'ApplePay');
INSERT INTO `payment_methods` VALUES (3,'PayPal');
INSERT INTO `payment_methods` VALUES (4,'GooglePay');
INSERT INTO `payment_methods` VALUES (5,'Gift Card');

CREATE TABLE `Transaction` (
  `transaction_id` int(10) NOT NULL,
  `customer_id` int(10) NOT NULL,
  `Transaction_total` decimal(9,2) NOT NULL,
  `payment_method_id` int(10),
  `purchase_date` date NOT NULL,
  
  PRIMARY KEY (`transaction_id`),
  KEY `FK_customer_id` (`customer_id`),
  KEY `FK_payment_method_id` (`payment_method_id`),
  CONSTRAINT `FK_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`payment_method_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `transaction` VALUES (1,1,39.99,1,'2023-07-21');
INSERT INTO `transaction` VALUES (2,2,59.99,2,'2023-08-06');
INSERT INTO `transaction` VALUES (3,3,79.96,3,'2023-01-25');
INSERT INTO `transaction` VALUES (4,4,39.99,5,'2022-12-15');
INSERT INTO `transaction` VALUES (5,5,299.99,1,'2023-05-05');
INSERT INTO `transaction` VALUES (6,6,209.93,4,'2023-08-01');


