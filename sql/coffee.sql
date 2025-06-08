DROP DATABASE IF EXISTS `coffee`;
CREATE DATABASE `coffee` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `coffee`;

-- ----------------------------
-- Table structure for `members`
-- ----------------------------
DROP TABLE IF EXISTS `members`;

CREATE TABLE `members` (
  `id` varchar(100) NOT NULL,
  `pwd` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `role` varchar(20) DEFAULT 'user', -- 新增：用來辨識是否為 admin
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `members` (`id`, `pwd`, `email`, `role`) VALUES
('bobby','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4','bobby@gmail.com', 'user'),
('george','1234','george1234@gmail.com', 'user'),
('hello','1234','hello111@gmail.com', 'user'),
('test','1234','', 'user'),
('vivi','1234','vivi6666@gmail.com', 'user'),
('222','1234','admin@test.com', 'admin'); -- 管理員帳號

DROP TABLE IF EXISTS `cart`;

CREATE TABLE `cart` (
  `no` int NOT NULL AUTO_INCREMENT,
  `id` varchar(50) DEFAULT NULL,
  `sugar` varchar(20) DEFAULT NULL,
  `ice` varchar(20) DEFAULT NULL,
  `customerID` varchar(50) DEFAULT NULL,
  `orderQ` int DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `cart` (`no`, `id`, `sugar`, `ice`, `customerID`, `orderQ`) VALUES
(11, 'lavender-milktea', '半糖', '少冰', 'guest', 4),
(12, 'cold-brew', '半糖', '少冰', 'guest', 1);

DROP TABLE IF EXISTS `coupons`;

CREATE TABLE `coupons` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customerID` varchar(50) DEFAULT NULL,
  `code` varchar(20) DEFAULT NULL,
  `discount` int DEFAULT '50',
  `isUsed` tinyint(1) DEFAULT '0',
  `issueDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 初始無資料，如需新增請補上：
-- INSERT INTO `coupons` (`customerID`, `code`, `discount`, `isUsed`) VALUES ('testuser', 'WELCOME50', 50, 0);


DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `remarks` text,
  `payment_method` varchar(50) DEFAULT NULL,
  `discount_code` varchar(50) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `order_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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


DROP TABLE IF EXISTS `order_items`;

CREATE TABLE `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  `product_price` decimal(10,2) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `sugar` varchar(20) DEFAULT NULL,
  `ice` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `order_items` VALUES 
(1,1,'洛神花草茶 (壺)',120.00,4,'無糖','少冰'),
(2,1,'洛神花草茶 (壺)',120.00,4,'微糖','少冰'),
(3,1,'薰衣草奶茶 (杯)',60.00,1,'半糖','少冰'),
(4,10,'薰衣草奶茶 (杯)',60.00,2,'半糖','少冰'),
(5,11,'咖啡拿鐵',60.00,1,'半糖','少冰'),
(6,11,'辦公室系列-小心酸',80.00,1,'無糖','少冰');


DROP TABLE IF EXISTS `productss`;

CREATE TABLE `productss` (
  `no` int NOT NULL AUTO_INCREMENT,
  `id` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category` varchar(100) NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `inventory` int DEFAULT '0',
  PRIMARY KEY (`no`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `productss` VALUES
(1,'americano','美式咖啡','咖啡類','buy.html?product=americano','../image/coffee.png',40.00,100),
(2,'latte','咖啡拿鐵','咖啡類','buy.html?product=latte','../image/coffee.png',60.00,50),
(3,'flavored-latte','風味咖啡拿鐵','咖啡類','buy.html?product=flavored-latte','../image/coffee.png',80.00,90),
(4,'ice-brick-coffee','冰磚咖啡','咖啡類','buy.html?product=ice-brick-coffee','../image/coffee.png',180.00,60),
(5,'cold-brew','冰滴咖啡','咖啡類','buy.html?product=cold-brew','../image/coffee2.png',110.00,70),
(6,'dirty-coffee','髒髒咖啡','咖啡類','buy.html?product=dirty-coffee','../image/coffee3.png',45.00,80),
(7,'office-sour','辦公室系列-小心酸','手沖咖啡','buy.html?product=office-sour','../image/poc.png',80.00,90),
(8,'office-bittersweet','辦公室系列-小甘苦','手沖咖啡','buy.html?product=office-bittersweet','../image/poc.png',80.00,70),
(9,'office-relax','辦公室系列-小放空','手沖咖啡','buy.html?product=office-relax','../image/poc.png',80.00,80),
(10,'office-sigh','辦公室系列-小感嘆','手沖咖啡','buy.html?product=office-sigh','../image/poc.png',80.00,100),
(11,'office-scheme','辦公室系列-小心機','手沖咖啡','buy.html?product=office-scheme','../image/poc.png',80.00,50),
(12,'office-blessing','辦公室系列-小確辛','手沖咖啡','buy.html?product=office-blessing','../image/poc.png',80.00,60),
(13,'tea-pot-lavender','薰衣草茶 (壺)','花草茶類','buy.html?product=tea-pot-lavender','../image/herbal tea.png',120.00,70),
(14,'tea-pot-lemon-grass','檸檬香茅草茶 (壺)','花草茶類','buy.html?product=tea-pot-lemon-grass','../image/herbal tea.png',120.00,90),
(15,'tea-pot-wild-ginger','野薑花草茶 (壺)','花草茶類','buy.html?product=tea-pot-wild-ginger','../image/herbal tea.png',120.00,80),
(16,'tea-pot-roselle','洛神花草茶 (壺)','花草茶類','buy.html?product=tea-pot-roselle','../image/herbal tea.png',120.00,70),
(17,'tea-pot-blueberry','藍莓果茶 (壺)','花草茶類','buy.html?product=tea-pot-blueberry','../image/herbal tea.png',120.00,100),
(18,'tea-pot-rose-earl-grey','玫瑰伯爵茶 (壺)','花草茶類','buy.html?product=tea-pot-rose-earl-grey','../image/herbal tea.png',140.00,60),
(19,'tea-pot-black','紓咖紅茶 (壺)','花草茶類','buy.html?product=tea-pot-black','../image/herbal tea.png',70.00,60),
(20,'tea-pot-green','紓咖綠茶 (壺)','花草茶類','buy.html?product=tea-pot-green','../image/herbal tea.png',70.00,80),
(21,'tea-cup-black','紓咖紅茶 (杯)','茶類','buy.html?product=tea-cup-black','../image/herbal tea.png',30.00,100),
(22,'tea-cup-green','紓咖綠茶 (杯)','茶類','buy.html?product=tea-cup-green','../image/herbal tea.png',30.00,100),
(23,'tea-cup-yuzu-green','柚子綠茶 (杯)','茶類','buy.html?product=tea-cup-yuzu-green','../image/herbal tea.png',30.00,100),
(24,'tea-cup-apple-black','蘋果紅茶 (杯)','茶類','buy.html?product=tea-cup-apple-black','../image/herbal tea.png',30.00,100),
(25,'tea-cup-matcha','日式抹茶 (杯)','茶類','buy.html?product=tea-cup-matcha','../image/herbal tea.png',40.00,100),
(26,'tea-cup-earl-grey','伯爵茶 (杯)','茶類','buy.html?product=tea-cup-earl-grey','../image/herbal tea.png',45.00,100),
(27,'ttea-cup-lavender','薰衣草茶 (杯))','茶類','buy.html?product=ttea-cup-lavender','../image/herbal tea.png',45.00,100),
(28,'tea-cup-blueberry','小藍莓茶 (杯)','茶類','buy.html?product=tea-cup-blueberry','../image/herbal tea.png',50.00,100),
(29,'strawberry-milk','草莓奶茶 (杯)','奶茶 / 可可','buy.html?product=strawberry-milk','../image/milktea.png',45.00,100),
(30,'matcha-milk','抹茶牛奶 (杯)','奶茶 / 可可','buy.html?product=matcha-milk','../image/milktea.png',60.00,100),
(31,'tea-cup-milk-earl-grey','伯爵奶茶 (杯)','奶茶 / 可可','buy.html?product=tea-cup-milk-earl-grey','../image/milktea.png',60.00,100),
(32,'lavender-milktea','薰衣草奶茶 (杯)','奶茶 / 可可','buy.html?product=lavender-milktea','../image/milktea.png',60.00,100),
(33,'spanish-cocoa','西班牙可可 (杯)','奶茶 / 可可','buy.html?product=spanish-cocoa','../image/milktea.png',30.00,100),
(34,'spanish-cocoa-milk','西班牙可可奶 (杯)','奶茶 / 可可','buy.html?product=spanish-cocoa-milk','../image/milktea.png',60.00,100),
(35,'sparkling-yuzu','柚子氣泡飲','氣泡水','buy.html?product=sparkling-yuzu','../image/sparkling_water.png',50.00,100),
(36,'sparkling-lemon','清新檸檬氣泡飲','氣泡水','buy.html?product=sparkling-lemon','../image/sparkling_water.png',70.00,100),
(37,'sparkling-apple','蘋果氣泡飲','氣泡水','buy.html?product=sparkling-apple','../image/sparkling_water.png',50.00,100),
(38,'sparkling-strawberry','草莓氣泡飲','氣泡水','buy.html?product=sparkling-strawberry','../image/sparkling_water.png',50.00,100),
(39,'sparkling-rose','粉彩玫瑰氣泡飲','氣泡水','buy.html?product=sparkling-rose','../image/sparkling_water.png',60.00,100),
(40,'sparkling-blueberry','藍莓氣泡飲','氣泡水','buy.html?product=sparkling-blueberry','../image/sparkling_water.png',60.00,100),
(41,'functional-dazzling-lady','妖嬌女魔法藥水腸胃保健','功能性飲料- 發泡飲','buy.html?product=functional-dazzling-lady','../image/sw.png',70.00,100),
(42,'functional-energy-broth','元寶堅尼活力湯','功能性飲料- 發泡飲','buy.html?product=functional-energy-broth','../image/sw.png',70.00,100),
(43,'functional-nezuko-elixir','彌豆子青春甘露','功能性飲料- 發泡飲','buy.html?product=functional-nezuko-elixir','../image/sw.png',70.00,100),
(44,'functional-vampire-golden-cup','吸血鬼安眠金杯','功能性飲料- 發泡飲','buy.html?product=functional-vampire-golden-cup','../image/sw.png',50.00,100),
(45,'functional-popeye-drink','卜派力士活力飲','功能性飲料- 發泡飲','buy.html?product=functional-popeye-drink','../image/sw.png',70.00,100);

DROP TABLE IF EXISTS `randad`;

CREATE TABLE `randad` (
  `ADID` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `file_path` varchar(255) NOT NULL,
  `ad_file` varchar(255) NOT NULL,
  PRIMARY KEY (`ADID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

INSERT INTO `randad` (`ADID`, `file_path`, `ad_file`) VALUES
(1, '../image/01.png', '01.png'),
(2, '../image/02.png', '02.png'),
(3, '../image/03.png', '03.png');

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `commentId` int NOT NULL AUTO_INCREMENT,
  `commentName` varchar(45) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `rate` int DEFAULT NULL,
  `content` text,
  `date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`commentId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `comment` (`commentId`, `commentName`, `email`, `rate`, `content`, `date`) VALUES
(1,'oo','oo@gmail.com',5,'店員很親切很好聊天','2025-06-06 16:01:59'),
(2,'bobby','bobby@gmail.com',5,'瑜珈課程好有趣!','2025-06-06 16:02:42'),
(3,'oo','oo@gmail.com',5,'咖啡有料 5顆星!!','2025-06-06 16:03:19'),
(4,'oo','oo@gmail.com',5,'貓咪好勾追','2025-06-06 16:04:54'),
(5,'oo','oo@gmail.com',4,'讚讚讚!!!!!!!!!!!!','2025-06-06 16:05:02'),
(6,'oo','oo@gmail.com',4,'咖啡很好喝~','2025-06-06 16:18:58'),
(7,'oo','oo@gmail.com',4,'Good!!','2025-06-06 16:21:22');

