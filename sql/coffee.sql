CREATE DATABASE IF NOT EXISTS `coffee` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `coffee`;

SET FOREIGN_KEY_CHECKS = 0;

-- cart
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `no` int NOT NULL AUTO_INCREMENT,
  `id` varchar(50),
  `sugar` varchar(20),
  `ice` varchar(20),
  `customerID` varchar(50),
  `orderQ` int,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;
INSERT INTO `cart` VALUES 
(11,'lavender-milktea','半糖','少冰','guest',4),
(12,'cold-brew','半糖','少冰','guest',1);

-- coupons
DROP TABLE IF EXISTS `coupons`;
CREATE TABLE `coupons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customerID` varchar(50),
  `code` varchar(20),
  `discount` int DEFAULT 50,
  `isUsed` tinyint(1) DEFAULT 0,
  `issueDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- orders
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(100),
  `address` varchar(255),
  `remarks` text,
  `payment_method` varchar(50),
  `discount_code` varchar(50),
  `subtotal` decimal(10,2),
  `total` decimal(10,2),
  `order_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
INSERT INTO `orders` VALUES
(1,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:32:39'),
(2,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:36:54'),
(3,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:39:24'),
(4,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:39:27'),
(5,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:40:54'),
(6,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:40:56'),
(7,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:41:55'),
(8,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:44:56'),
(9,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:45:10'),
(10,'顧客','dsfdsf','ddcd','cod','dfdsfds',120.00,180.00,'2025-06-01 14:50:20'),
(11,'顧客','qdqwd','dqwwqdwq','cod','wqe',300.00,360.00,'2025-06-01 14:52:22');

-- order_items
DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int,
  `product_name` varchar(100),
  `product_price` decimal(10,2),
  `quantity` int,
  `sugar` varchar(20),
  `ice` varchar(20),
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
INSERT INTO `order_items` VALUES
(1,1,'洛神花草茶 (壺)',120.00,4,'無糖','少冰'),
(2,1,'洛神花草茶 (壺)',120.00,4,'微糖','少冰'),
(3,1,'薰衣草奶茶 (杯)',60.00,1,'半糖','少冰'),
(4,10,'薰衣草奶茶 (杯)',60.00,2,'半糖','少冰'),
(5,11,'咖啡拿鐵',60.00,1,'半糖','少冰'),
(6,11,'辦公室系列-小心酸',80.00,1,'無糖','少冰');

-- comment
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `commentId` int NOT NULL AUTO_INCREMENT,
  `commentName` varchar(45),
  `email` varchar(100),
  `rate` int,
  `content` text,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`commentId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4;
INSERT INTO `comment` VALUES 
(1,'oo','oo@gmail.com',5,'店員很親切很好聊天','2025-06-06 16:01:59'),
(2,'bobby','bobby@gmail.com',5,'瑜珈課程好有趣!','2025-06-06 16:02:42'),
(3,'oo','oo@gmail.com',5,'咖啡有料 5顆星!!','2025-06-06 16:03:19'),
(4,'oo','oo@gmail.com',5,'貓咪好勾追','2025-06-06 16:04:54'),
(5,'oo','oo@gmail.com',4,'讚讚讚!!!!!!!!!!!!','2025-06-06 16:05:02'),
(6,'oo','oo@gmail.com',4,'咖啡很好喝~','2025-06-06 16:18:58'),
(7,'oo','oo@gmail.com',4,'Good!!','2025-06-06 16:21:22');

-- members
DROP TABLE IF EXISTS `members`;
CREATE TABLE `members` (
  `id` varchar(100) NOT NULL,
  `pwd` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
INSERT INTO `members` VALUES 
('bobby','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4','bobby@gmail.com'),
('george','1234','george1234@gmail.com'),
('hello','1234','hello111@gmail.com'),
('test','1234',''),
('vivi','1234','vivi6666@gmail.com');

-- randad
DROP TABLE IF EXISTS `randad`;
CREATE TABLE `randad` (
  `ADID` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `file_path` varchar(20) NOT NULL,
  `ad_file` varchar(20) NOT NULL,
  PRIMARY KEY (`ADID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
INSERT INTO `randad` VALUES 
(1, '../image/01.png', '01.png'),
(2, '../image/02.png', '02.png'),
(3, '../image/03.png', '03.png');

SET FOREIGN_KEY_CHECKS = 1;
