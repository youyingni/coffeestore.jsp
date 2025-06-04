CREATE DATABASE  IF NOT EXISTS `coffee` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `coffee`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: coffee
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `no` int NOT NULL AUTO_INCREMENT,
  `id` varchar(50) DEFAULT NULL,
  `sugar` varchar(20) DEFAULT NULL,
  `ice` varchar(20) DEFAULT NULL,
  `customerID` varchar(50) DEFAULT NULL,
  `orderQ` int DEFAULT NULL,
  PRIMARY KEY (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (11,'lavender-milktea','半糖','少冰','guest',4),(12,'cold-brew','半糖','少冰','guest',1);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,'洛神花草茶 (壺)',120.00,4,'無糖','少冰'),(2,1,'洛神花草茶 (壺)',120.00,4,'微糖','少冰'),(3,1,'薰衣草奶茶 (杯)',60.00,1,'半糖','少冰'),(4,10,'薰衣草奶茶 (杯)',60.00,2,'半糖','少冰'),(5,11,'咖啡拿鐵',60.00,1,'半糖','少冰'),(6,11,'辦公室系列-小心酸',80.00,1,'無糖','少冰');
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:32:39'),(2,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:36:54'),(3,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:39:24'),(4,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:39:27'),(5,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:40:54'),(6,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:40:56'),(7,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:41:55'),(8,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:44:56'),(9,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:45:10'),(10,'顧客','dsfdsf','ddcd','cod','dfdsfds',120.00,180.00,'2025-06-01 14:50:20'),(11,'顧客','qdqwd','dqwwqdwq','cod','wqe',300.00,360.00,'2025-06-01 14:52:22');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productss`
--

DROP TABLE IF EXISTS `productss`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productss`
--

LOCK TABLES `productss` WRITE;
/*!40000 ALTER TABLE `productss` DISABLE KEYS */;
INSERT INTO `productss` VALUES (1,'americano','美式咖啡','咖啡類','buy.html?product=americano','../image/coffee.png',40.00,100),(2,'latte','咖啡拿鐵','咖啡類','buy.html?product=latte','../image/coffee.png',60.00,50),(3,'flavored-latte','風味咖啡拿鐵','咖啡類','buy.html?product=flavored-latte','../image/coffee.png',80.00,90),(4,'ice-brick-coffee','冰磚咖啡','咖啡類','buy.html?product=ice-brick-coffee','../image/coffee.png',180.00,60),(5,'cold-brew','冰滴咖啡','咖啡類','buy.html?product=cold-brew','../image/coffee2.png',110.00,70),(6,'dirty-coffee','髒髒咖啡','咖啡類','buy.html?product=dirty-coffee','../image/coffee3.png',45.00,80),(7,'office-sour','辦公室系列-小心酸','手沖咖啡','buy.html?product=office-sour','../image/poc.png',80.00,90),(8,'office-bittersweet','辦公室系列-小甘苦','手沖咖啡','buy.html?product=office-bittersweet','../image/poc.png',80.00,70),(9,'office-relax','辦公室系列-小放空','手沖咖啡','buy.html?product=office-relax','../image/poc.png',80.00,80),(10,'office-sigh','辦公室系列-小感嘆','手沖咖啡','buy.html?product=office-sigh','../image/poc.png',80.00,100),(11,'office-scheme','辦公室系列-小心機','手沖咖啡','buy.html?product=office-scheme','../image/poc.png',80.00,50),(12,'office-blessing','辦公室系列-小確辛','手沖咖啡','buy.html?product=office-blessing','../image/poc.png',80.00,60),(13,'tea-pot-lavender','薰衣草茶 (壺)','花草茶類','buy.html?product=tea-pot-lavender','../image/herbal tea.png',120.00,70),(14,'tea-pot-lemon-grass','檸檬香茅草茶 (壺)','花草茶類','buy.html?product=tea-pot-lemon-grass','../image/herbal tea.png',120.00,90),(15,'tea-pot-wild-ginger','野薑花草茶 (壺)','花草茶類','buy.html?product=tea-pot-wild-ginger','../image/herbal tea.png',120.00,80),(16,'tea-pot-roselle','洛神花草茶 (壺)','花草茶類','buy.html?product=tea-pot-roselle','../image/herbal tea.png',120.00,70),(17,'tea-pot-blueberry','藍莓果茶 (壺)','花草茶類','buy.html?product=tea-pot-blueberry','../image/herbal tea.png',120.00,100),(18,'tea-pot-rose-earl-grey','玫瑰伯爵茶 (壺)','花草茶類','buy.html?product=tea-pot-rose-earl-grey','../image/herbal tea.png',140.00,60),(19,'tea-pot-black','紓咖紅茶 (壺)','花草茶類','buy.html?product=tea-pot-black','../image/herbal tea.png',70.00,60),(20,'tea-pot-green','紓咖綠茶 (壺)','花草茶類','buy.html?product=tea-pot-green','../image/herbal tea.png',70.00,80),(21,'tea-cup-black','紓咖紅茶 (杯)','茶類','buy.html?product=tea-cup-black','../image/herbal tea.png',30.00,100),(22,'tea-cup-green','紓咖綠茶 (杯)','茶類','buy.html?product=tea-cup-green','../image/herbal tea.png',30.00,100),(23,'tea-cup-yuzu-green','柚子綠茶 (杯)','茶類','buy.html?product=tea-cup-yuzu-green','../image/herbal tea.png',30.00,100),(24,'tea-cup-apple-black','蘋果紅茶 (杯)','茶類','buy.html?product=tea-cup-apple-black','../image/herbal tea.png',30.00,100),(25,'tea-cup-matcha','日式抹茶 (杯)','茶類','buy.html?product=tea-cup-matcha','../image/herbal tea.png',40.00,100),(26,'tea-cup-earl-grey','伯爵茶 (杯)','茶類','buy.html?product=tea-cup-earl-grey','../image/herbal tea.png',45.00,100),(27,'ttea-cup-lavender','薰衣草茶 (杯))','茶類','buy.html?product=ttea-cup-lavender','../image/herbal tea.png',45.00,100),(28,'tea-cup-blueberry','小藍莓茶 (杯)','茶類','buy.html?product=tea-cup-blueberry','../image/herbal tea.png',50.00,100),(29,'strawberry-milk','草莓奶茶 (杯)','奶茶 / 可可','buy.html?product=strawberry-milk','../image/milktea.png',45.00,100),(30,'matcha-milk','抹茶牛奶 (杯)','奶茶 / 可可','buy.html?product=matcha-milk','../image/milktea.png',60.00,100),(31,'tea-cup-milk-earl-grey','伯爵奶茶 (杯)','奶茶 / 可可','buy.html?product=tea-cup-milk-earl-grey','../image/milktea.png',60.00,100),(32,'lavender-milktea','薰衣草奶茶 (杯)','奶茶 / 可可','buy.html?product=lavender-milktea','../image/milktea.png',60.00,100),(33,'spanish-cocoa','西班牙可可 (杯)','奶茶 / 可可','buy.html?product=spanish-cocoa','../image/milktea.png',30.00,100),(34,'spanish-cocoa-milk','西班牙可可奶 (杯)','奶茶 / 可可','buy.html?product=spanish-cocoa-milk','../image/milktea.png',60.00,100),(35,'sparkling-yuzu','柚子氣泡飲','氣泡水','buy.html?product=sparkling-yuzu','../image/sparkling_water.png',50.00,100),(36,'sparkling-lemon','清新檸檬氣泡飲','氣泡水','buy.html?product=sparkling-lemon','../image/sparkling_water.png',70.00,100),(37,'sparkling-apple','蘋果氣泡飲','氣泡水','buy.html?product=sparkling-apple','../image/sparkling_water.png',50.00,100),(38,'sparkling-strawberry','草莓氣泡飲','氣泡水','buy.html?product=sparkling-strawberry','../image/sparkling_water.png',50.00,100),(39,'sparkling-rose','粉彩玫瑰氣泡飲','氣泡水','buy.html?product=sparkling-rose','../image/sparkling_water.png',60.00,100),(40,'sparkling-blueberry','藍莓氣泡飲','氣泡水','buy.html?product=sparkling-blueberry','../image/sparkling_water.png',60.00,100),(41,'functional-dazzling-lady','妖嬌女魔法藥水腸胃保健','功能性飲料- 發泡飲','buy.html?product=functional-dazzling-lady','../image/sw.png',70.00,100),(42,'functional-energy-broth','元寶堅尼活力湯','功能性飲料- 發泡飲','buy.html?product=functional-energy-broth','../image/sw.png',70.00,100),(43,'functional-nezuko-elixir','彌豆子青春甘露','功能性飲料- 發泡飲','buy.html?product=functional-nezuko-elixir','../image/sw.png',70.00,100),(44,'functional-vampire-golden-cup','吸血鬼安眠金杯','功能性飲料- 發泡飲','buy.html?product=functional-vampire-golden-cup','../image/sw.png',50.00,100),(45,'functional-popeye-drink','卜派力士活力飲','功能性飲料- 發泡飲','buy.html?product=functional-popeye-drink','../image/sw.png',70.00,100);
/*!40000 ALTER TABLE `productss` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-01 23:18:26
