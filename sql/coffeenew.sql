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
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
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
  `code` varchar(50) DEFAULT NULL,
  `customerID` varchar(50) DEFAULT NULL,
  `isUsed` tinyint(1) DEFAULT '0',
  `type` enum('free_shipping','discount50') DEFAULT 'discount50',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
INSERT INTO `coupons` VALUES (1,'FREE1748956706230','nn',1,'free_shipping','2025-06-03 13:18:26'),(2,'FREE1748957056696','nn',1,'free_shipping','2025-06-03 13:24:16'),(3,'FREE1748957490637','nn',1,'free_shipping','2025-06-03 13:31:30'),(4,'FREE1748958089502','nn',1,'free_shipping','2025-06-03 13:41:29'),(5,'FREE1748971905843','11233',1,'free_shipping','2025-06-03 17:31:45');
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
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,'洛神花草茶 (壺)',120.00,4,'無糖','少冰'),(2,1,'洛神花草茶 (壺)',120.00,4,'微糖','少冰'),(3,1,'薰衣草奶茶 (杯)',60.00,1,'半糖','少冰'),(4,10,'薰衣草奶茶 (杯)',60.00,2,'半糖','少冰'),(5,11,'咖啡拿鐵',60.00,1,'半糖','少冰'),(6,11,'辦公室系列-小心酸',80.00,1,'無糖','少冰'),(7,12,'薰衣草奶茶 (杯)',60.00,4,'半糖','少冰'),(8,12,'冰滴咖啡',110.00,1,'半糖','少冰'),(9,12,'風味咖啡拿鐵',80.00,1,'半糖','少冰'),(10,12,'風味咖啡拿鐵',80.00,1,'半糖','少冰'),(11,14,'薰衣草奶茶 (杯)',60.00,1,'半糖','少冰'),(12,14,'辦公室系列-小確辛',80.00,5,'半糖','少冰'),(13,15,'蘋果氣泡飲',50.00,1,'半糖','少冰'),(14,15,'伯爵茶 (杯)',45.00,3,'無糖','冰的'),(15,17,'薰衣草奶茶 (杯)',60.00,1,'半糖','少冰'),(16,17,'薰衣草奶茶 (杯)',60.00,1,'半糖','少冰'),(17,18,'薰衣草奶茶 (杯)',60.00,2,'微糖','去冰'),(18,18,'薰衣草奶茶 (杯)',60.00,2,'微糖','去冰'),(19,19,'薰衣草奶茶 (杯)',60.00,1,'半糖','少冰'),(20,19,'薰衣草奶茶 (杯)',60.00,1,'半糖','少冰'),(21,20,'薰衣草奶茶 (杯)',60.00,1,'半糖','少冰'),(22,20,'薰衣草奶茶 (杯)',60.00,1,'半糖','少冰'),(23,20,'薰衣草奶茶 (杯)',60.00,3,'半糖','少冰'),(24,20,'薰衣草奶茶 (杯)',60.00,3,'半糖','少冰'),(25,20,'卜派力士活力飲',70.00,1,'微糖','少冰'),(26,20,'卜派力士活力飲',70.00,1,'微糖','少冰'),(27,21,'薰衣草奶茶 (杯)',60.00,2,'半糖','少冰'),(28,21,'薰衣草奶茶 (杯)',60.00,2,'半糖','少冰'),(29,22,'lavender-milktea',60.00,3,'半糖','少冰'),(30,22,'lavender-milktea',60.00,3,'半糖','少冰'),(31,23,'ice-brick-coffee',180.00,2,'半糖','溫的'),(32,23,'ice-brick-coffee',180.00,2,'半糖','溫的'),(33,23,'tea-cup-green',30.00,1,'微糖','少冰'),(34,23,'tea-cup-green',30.00,1,'微糖','少冰'),(35,24,'lavender-milktea',60.00,2,'半糖','少冰'),(36,24,'lavender-milktea',60.00,2,'半糖','少冰'),(37,24,'ice-brick-coffee',180.00,1,'半糖','少冰'),(38,24,'lavender-milktea',60.00,2,'半糖','溫的'),(39,25,'lavender-milktea',60.00,2,'半糖','少冰'),(40,25,'lavender-milktea',60.00,2,'半糖','少冰'),(41,25,'ice-brick-coffee',180.00,1,'半糖','少冰'),(42,26,'lavender-milktea',60.00,2,'半糖','少冰'),(43,26,'lavender-milktea',60.00,2,'半糖','少冰'),(44,26,'ice-brick-coffee',180.00,1,'半糖','少冰'),(45,26,'lavender-milktea',60.00,1,'無糖','去冰'),(46,26,'lavender-milktea',60.00,1,'無糖','去冰'),(47,28,'lavender-milktea',60.00,1,'半糖','少冰'),(48,28,'functional-popeye-drink',70.00,2,'無糖','少冰'),(49,29,'薰衣草奶茶 (杯)',60.00,2,'半糖','少冰'),(50,29,'蘋果氣泡飲',50.00,2,'無糖','少冰'),(51,30,'蘋果氣泡飲',50.00,2,'無糖','少冰'),(52,30,'紓咖紅茶 (壺)',70.00,2,'無糖','少冰'),(53,32,'薰衣草奶茶 (杯)',60.00,3,'微糖','少冰'),(54,32,'紓咖綠茶 (壺)',70.00,3,'微糖','冰的'),(55,33,'薰衣草奶茶 (杯)',60.00,2,'半糖','少冰'),(56,33,'薰衣草茶 (杯))',45.00,1,'半糖','少冰'),(57,34,'伯爵茶 (杯)',45.00,2,'半糖','少冰'),(58,34,'蘋果紅茶 (杯)',30.00,1,'微糖','少冰'),(59,36,'蘋果紅茶 (杯)',30.00,1,'微糖','少冰'),(60,36,'薰衣草茶 (杯))',45.00,2,'微糖','冰的'),(61,37,'冰磚咖啡',180.00,2,'無糖','溫的'),(62,37,'薰衣草茶 (壺)',120.00,2,'半糖','少冰'),(63,38,'薰衣草奶茶 (杯)',60.00,1,'無糖','少冰'),(64,38,'辦公室系列-小甘苦',80.00,2,'微糖','少冰'),(65,39,'辦公室系列-小甘苦',80.00,2,'微糖','少冰'),(66,39,'冰滴咖啡',110.00,1,'微糖','冰的'),(67,40,'冰滴咖啡',110.00,2,'微糖','冰的'),(68,40,'日式抹茶 (杯)',40.00,2,'無糖','少冰'),(69,41,'薰衣草奶茶 (杯)',60.00,2,'微糖','少冰'),(70,41,'洛神花草茶 (壺)',120.00,2,'微糖','冰的'),(71,41,'薰衣草奶茶 (杯)',60.00,2,'半糖','少冰'),(72,42,'冰滴咖啡',110.00,1,'微糖','冰的'),(73,42,'玫瑰伯爵茶 (壺)',140.00,2,'微糖','少冰'),(74,43,'lavender-milktea',60.00,2,'微糖','去冰'),(75,43,'americano',40.00,1,'半糖','冰的'),(76,45,'sparkling-apple',50.00,2,'半糖','少冰'),(77,46,'tea-cup-milk-earl-grey',60.00,2,'半糖','少冰'),(78,48,'tea-pot-wild-ginger',120.00,1,'微糖','少冰'),(79,50,'tea-cup-yuzu-green',30.00,1,'微糖','少冰'),(80,51,'tea-pot-blueberry',120.00,1,'半糖','去冰'),(81,52,'tea-pot-blueberry',120.00,1,'半糖','去冰'),(82,53,'ice-brick-coffee',180.00,1,'微糖','少冰'),(83,53,'sparkling-lemon',70.00,1,'無糖','少冰'),(84,54,'辦公室系列-小感嘆',80.00,1,'微糖','少冰'),(85,55,'薰衣草奶茶 (杯)',60.00,1,'半糖','少冰'),(86,56,'office-sigh',80.00,1,'微糖','冰的'),(87,57,'cold-brew',110.00,1,'無糖','少冰'),(88,58,'office-sigh',80.00,1,'半糖','冰的'),(89,58,'sparkling-yuzu',50.00,1,'微糖','少冰'),(90,59,'sparkling-strawberry',50.00,1,'微糖','少冰'),(91,59,'lavender-milktea',60.00,1,'微糖','溫的'),(92,60,'lavender-milktea',60.00,1,'微糖','少冰'),(93,62,'lavender-milktea',60.00,1,'半糖','少冰'),(94,63,'tea-pot-roselle',120.00,1,'無糖','去冰'),(95,63,'tea-pot-blueberry',120.00,1,'微糖','溫的'),(96,63,'strawberry-milk',45.00,1,'微糖','少冰'),(97,64,'office-sigh',80.00,1,'半糖','少冰'),(98,65,'tea-cup-yuzu-green',30.00,1,'微糖','少冰'),(99,66,'cold-brew',110.00,1,'無糖','少冰'),(100,66,'office-sour',80.00,1,'微糖','少冰'),(101,66,'office-sour',80.00,1,'微糖','少冰'),(102,66,'office-scheme',80.00,1,'微糖','少冰'),(103,66,'tea-pot-lemon-grass',120.00,1,'無糖','少冰'),(104,67,'office-scheme',80.00,1,'微糖','少冰'),(105,67,'tea-pot-lemon-grass',120.00,1,'無糖','少冰'),(106,67,'office-sigh',80.00,1,'半糖','少冰'),(107,67,'tea-pot-blueberry',120.00,1,'微糖','去冰'),(108,68,'office-scheme',80.00,1,'微糖','少冰'),(109,68,'tea-pot-lemon-grass',120.00,1,'無糖','少冰'),(110,68,'office-sigh',80.00,1,'半糖','少冰'),(111,68,'tea-pot-lemon-grass',120.00,1,'無糖','溫的'),(112,69,'office-scheme',80.00,1,'微糖','少冰'),(113,69,'tea-pot-lemon-grass',120.00,1,'無糖','少冰'),(114,69,'office-sigh',80.00,1,'半糖','少冰'),(115,69,'office-sigh',80.00,1,'微糖','少冰'),(116,70,'office-scheme',80.00,1,'微糖','少冰'),(117,70,'tea-pot-lemon-grass',120.00,1,'無糖','少冰'),(118,70,'office-sigh',80.00,1,'半糖','少冰');
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
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:32:39'),(2,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:36:54'),(3,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:39:24'),(4,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:39:27'),(5,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:40:54'),(6,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:40:56'),(7,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:41:55'),(8,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:44:56'),(9,'顧客','wl3u04','cl3t.,','cod','wefewf',1020.00,1080.00,'2025-06-01 14:45:10'),(10,'顧客','dsfdsf','ddcd','cod','dfdsfds',120.00,180.00,'2025-06-01 14:50:20'),(11,'顧客','qdqwd','dqwwqdwq','cod','wqe',300.00,360.00,'2025-06-01 14:52:22'),(12,'顧客','sasacsa','scascs','cod','cssa',510.00,570.00,'2025-06-01 15:52:38'),(13,'顧客','qdqwd','dqwwqdwq','cod','wqe',300.00,360.00,'2025-06-01 15:56:32'),(14,'顧客','你家','中原大學','cod','vswdvfw',460.00,520.00,'2025-06-01 15:57:31'),(15,'顧客','dfnhdsbhfdsb','fsuidfhuidfh','cod','wefewf',185.00,245.00,'2025-06-02 05:17:26'),(16,'顧客','','',NULL,'',0.00,60.00,'2025-06-02 14:41:09'),(17,'顧客','sadsadsa','sdsad',NULL,'sadsadsa',120.00,180.00,'2025-06-02 14:44:27'),(18,'顧客','sadsad','dsds','cod','sdsa',240.00,300.00,'2025-06-02 14:50:48'),(19,'你是','妳嫁','討厭','cod','cdffieje',120.00,180.00,'2025-06-02 15:04:42'),(20,'sads','sadad','sadas','cod','sd',260.00,320.00,'2025-06-02 15:09:57'),(21,'你好','asmdomaiodjmsa','jdiwcnuied','cod','asdsad',240.00,300.00,'2025-06-02 15:25:24'),(22,'1234','wre','erew','cod','ewrwe',360.00,420.00,'2025-06-02 15:53:14'),(23,'1234','sqws','sqws','cod','qsq',780.00,840.00,'2025-06-02 15:54:43'),(24,'11233','wdqwd','wdqd','cod','wqdw',240.00,300.00,'2025-06-02 16:04:29'),(25,'11233','wdqwd','wdqd','cod','wqdw',240.00,300.00,'2025-06-02 16:04:45'),(26,'1234','sdsad','dads','cod','asdsa',240.00,300.00,'2025-06-02 16:12:52'),(27,'11233','wdqwd','wdqd','cod','wqdw',240.00,300.00,'2025-06-02 16:17:59'),(28,'11233','sdfsfsd','sdfds','cod','fdsf',60.00,120.00,'2025-06-02 16:18:33'),(29,'顧客','asdsa','sadsa','cod','adsd',120.00,180.00,'2025-06-02 16:23:52'),(30,'顧客','','',NULL,'',240.00,300.00,'2025-06-02 16:24:36'),(31,'顧客','sdsa','sds','cod','sad',100.00,160.00,'2025-06-02 16:24:43'),(32,'顧客','','',NULL,'',390.00,450.00,'2025-06-02 16:24:56'),(33,'顧客','','',NULL,'',165.00,225.00,'2025-06-02 16:52:52'),(34,'顧客','','',NULL,'',120.00,180.00,'2025-06-02 16:53:22'),(35,'顧客','','',NULL,'',270.00,330.00,'2025-06-02 16:55:22'),(36,'顧客','wdd','wdw','cod','wqdwq',30.00,90.00,'2025-06-02 16:59:22'),(37,'顧客','wewq','we','cod','wewq',360.00,420.00,'2025-06-02 17:05:49'),(38,'顧客','sadsa','fede','cod','das',60.00,120.00,'2025-06-02 17:07:42'),(39,'顧客','sadsa','dsa','cod','sdas',270.00,330.00,'2025-06-02 17:09:13'),(40,'顧客','sdsad','ads','cod','asds',220.00,280.00,'2025-06-02 17:09:34'),(41,'顧客','ddfds','dds','cod','df',480.00,540.00,'2025-06-02 17:17:26'),(42,'顧客','df','dsf','cod','df',110.00,170.00,'2025-06-02 17:17:44'),(43,'nnw3','wqeqw','wqewq','cod','wqewq',160.00,220.00,'2025-06-02 18:53:00'),(44,'nnw3','wqeqw','wqewq','cod','wqewq',160.00,220.00,'2025-06-02 18:58:09'),(45,'nnw3','sadsa','sad','cod','sads',100.00,160.00,'2025-06-02 18:58:27'),(46,'nnw3','qwdwq','qwd','cod','dwqwq',120.00,180.00,'2025-06-02 19:02:40'),(47,'nnw3','qwdwq','qwd','cod','dwqwq',120.00,180.00,'2025-06-02 19:06:31'),(48,'nnw3','sdf','sdf','cod','fds',120.00,180.00,'2025-06-02 19:06:50'),(49,'nnw3','sdf','sdf','cod','fds',120.00,180.00,'2025-06-02 19:08:49'),(50,'nnw3','dsc','dcds','cod','csd',30.00,90.00,'2025-06-02 19:09:05'),(51,'11233','wefew','ewewj','cod','wefe',120.00,180.00,'2025-06-03 01:12:02'),(52,'dckwdnc','dqgwydguyd','wqdvwqgd','cod','dfqtydf',120.00,180.00,'2025-06-03 01:14:56'),(53,'dckwdnc','wsqw','sw','cod','ws',250.00,310.00,'2025-06-03 01:32:10'),(54,'nnw3','志浩的家','志浩愛你!','cod','3445',80.00,140.00,'2025-06-03 02:09:30'),(55,'nnw3','dwe','wde','cod','wd',60.00,120.00,'2025-06-03 02:14:37'),(56,'nnw3','dwed','wedfew','cod','wde',80.00,140.00,'2025-06-03 02:16:39'),(57,'nnw3','dsc','dsc','cod','sdc',110.00,170.00,'2025-06-03 02:16:56'),(58,'11233','志浩的家','志浩愛你','cod','wde',130.00,190.00,'2025-06-03 03:03:42'),(59,'nn','dsfsdf','dfdsfs','cod',NULL,110.00,170.00,'2025-06-03 13:18:26'),(60,'nn','','',NULL,'FREE1748956706230',60.00,60.00,'2025-06-03 13:24:01'),(61,'nn','','',NULL,'FREE1748956706230',60.00,120.00,'2025-06-03 13:24:16'),(62,'nn','dsff','fdsf','cod','FREE1748957056696',60.00,60.00,'2025-06-03 13:25:45'),(63,'nn','sadsa','sadd','cod',NULL,285.00,345.00,'2025-06-03 13:31:30'),(64,'nn','asdsa','asds',NULL,'FREE1748957490637',80.00,80.00,'2025-06-03 13:31:48'),(65,'nn','sc','cd','cod',NULL,30.00,90.00,'2025-06-03 13:41:29'),(66,'11233','','','cod',NULL,190.00,250.00,'2025-06-03 17:31:45'),(67,'11233','智皓','志浩的家','cod','FREE1748971905843',120.00,120.00,'2025-06-04 09:12:52'),(68,'11233','wfewfw','wfnudi','cod',NULL,120.00,180.00,'2025-06-04 10:36:44'),(69,'nnw3','','','cod',NULL,80.00,140.00,'2025-06-04 11:08:19'),(70,'nn','scd','cwdc','cod','FREE1748958089502',280.00,280.00,'2025-06-04 11:10:44');
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
INSERT INTO `productss` VALUES (1,'americano','美式咖啡','咖啡類','buy.html?product=americano','../image/coffee.png',40.00,99),(2,'latte','咖啡拿鐵','咖啡類','buy.html?product=latte','../image/coffee.png',60.00,50),(3,'flavored-latte','風味咖啡拿鐵','咖啡類','buy.html?product=flavored-latte','../image/coffee.png',80.00,90),(4,'ice-brick-coffee','冰磚咖啡','咖啡類','buy.html?product=ice-brick-coffee','../image/coffee.png',180.00,50),(5,'cold-brew','冰滴咖啡','咖啡類','buy.html?product=cold-brew','../image/coffee2.png',110.00,64),(6,'dirty-coffee','髒髒咖啡','咖啡類','buy.html?product=dirty-coffee','../image/coffee3.png',45.00,80),(7,'office-sour','辦公室系列-小心酸','手沖咖啡','buy.html?product=office-sour','../image/poc.png',80.00,88),(8,'office-bittersweet','辦公室系列-小甘苦','手沖咖啡','buy.html?product=office-bittersweet','../image/poc.png',80.00,66),(9,'office-relax','辦公室系列-小放空','手沖咖啡','buy.html?product=office-relax','../image/poc.png',80.00,80),(10,'office-sigh','辦公室系列-小感嘆','手沖咖啡','buy.html?product=office-sigh','../image/poc.png',80.00,91),(11,'office-scheme','辦公室系列-小心機','手沖咖啡','buy.html?product=office-scheme','../image/poc.png',80.00,45),(12,'office-blessing','辦公室系列-小確辛','手沖咖啡','buy.html?product=office-blessing','../image/poc.png',80.00,55),(13,'tea-pot-lavender','薰衣草茶 (壺)','花草茶類','buy.html?product=tea-pot-lavender','../image/herbal tea.png',120.00,68),(14,'tea-pot-lemon-grass','檸檬香茅草茶 (壺)','花草茶類','buy.html?product=tea-pot-lemon-grass','../image/herbal tea.png',120.00,84),(15,'tea-pot-wild-ginger','野薑花草茶 (壺)','花草茶類','buy.html?product=tea-pot-wild-ginger','../image/herbal tea.png',120.00,79),(16,'tea-pot-roselle','洛神花草茶 (壺)','花草茶類','buy.html?product=tea-pot-roselle','../image/herbal tea.png',120.00,67),(17,'tea-pot-blueberry','藍莓果茶 (壺)','花草茶類','buy.html?product=tea-pot-blueberry','../image/herbal tea.png',120.00,96),(18,'tea-pot-rose-earl-grey','玫瑰伯爵茶 (壺)','花草茶類','buy.html?product=tea-pot-rose-earl-grey','../image/herbal tea.png',140.00,58),(19,'tea-pot-black','紓咖紅茶 (壺)','花草茶類','buy.html?product=tea-pot-black','../image/herbal tea.png',70.00,58),(20,'tea-pot-green','紓咖綠茶 (壺)','花草茶類','buy.html?product=tea-pot-green','../image/herbal tea.png',70.00,77),(21,'tea-cup-black','紓咖紅茶 (杯)','茶類','buy.html?product=tea-cup-black','../image/herbal tea.png',30.00,100),(22,'tea-cup-green','紓咖綠茶 (杯)','茶類','buy.html?product=tea-cup-green','../image/herbal tea.png',30.00,98),(23,'tea-cup-yuzu-green','柚子綠茶 (杯)','茶類','buy.html?product=tea-cup-yuzu-green','../image/herbal tea.png',30.00,98),(24,'tea-cup-apple-black','蘋果紅茶 (杯)','茶類','buy.html?product=tea-cup-apple-black','../image/herbal tea.png',30.00,98),(25,'tea-cup-matcha','日式抹茶 (杯)','茶類','buy.html?product=tea-cup-matcha','../image/herbal tea.png',40.00,98),(26,'tea-cup-earl-grey','伯爵茶 (杯)','茶類','buy.html?product=tea-cup-earl-grey','../image/herbal tea.png',45.00,95),(27,'ttea-cup-lavender','薰衣草茶 (杯))','茶類','buy.html?product=ttea-cup-lavender','../image/herbal tea.png',45.00,97),(28,'tea-cup-blueberry','小藍莓茶 (杯)','茶類','buy.html?product=tea-cup-blueberry','../image/herbal tea.png',50.00,100),(29,'strawberry-milk','草莓奶茶 (杯)','奶茶 / 可可','buy.html?product=strawberry-milk','../image/milktea.png',45.00,99),(30,'matcha-milk','抹茶牛奶 (杯)','奶茶 / 可可','buy.html?product=matcha-milk','../image/milktea.png',60.00,100),(31,'tea-cup-milk-earl-grey','伯爵奶茶 (杯)','奶茶 / 可可','buy.html?product=tea-cup-milk-earl-grey','../image/milktea.png',60.00,98),(32,'lavender-milktea','薰衣草奶茶 (杯)','奶茶 / 可可','buy.html?product=lavender-milktea','../image/milktea.png',60.00,38),(33,'spanish-cocoa','西班牙可可 (杯)','奶茶 / 可可','buy.html?product=spanish-cocoa','../image/milktea.png',30.00,100),(34,'spanish-cocoa-milk','西班牙可可奶 (杯)','奶茶 / 可可','buy.html?product=spanish-cocoa-milk','../image/milktea.png',60.00,100),(35,'sparkling-yuzu','柚子氣泡飲','氣泡水','buy.html?product=sparkling-yuzu','../image/sparkling_water.png',50.00,99),(36,'sparkling-lemon','清新檸檬氣泡飲','氣泡水','buy.html?product=sparkling-lemon','../image/sparkling_water.png',70.00,99),(37,'sparkling-apple','蘋果氣泡飲','氣泡水','buy.html?product=sparkling-apple','../image/sparkling_water.png',50.00,93),(38,'sparkling-strawberry','草莓氣泡飲','氣泡水','buy.html?product=sparkling-strawberry','../image/sparkling_water.png',50.00,99),(39,'sparkling-rose','粉彩玫瑰氣泡飲','氣泡水','buy.html?product=sparkling-rose','../image/sparkling_water.png',60.00,100),(40,'sparkling-blueberry','藍莓氣泡飲','氣泡水','buy.html?product=sparkling-blueberry','../image/sparkling_water.png',60.00,100),(41,'functional-dazzling-lady','妖嬌女魔法藥水腸胃保健','功能性飲料- 發泡飲','buy.html?product=functional-dazzling-lady','../image/sw.png',70.00,100),(42,'functional-energy-broth','元寶堅尼活力湯','功能性飲料- 發泡飲','buy.html?product=functional-energy-broth','../image/sw.png',70.00,100),(43,'functional-nezuko-elixir','彌豆子青春甘露','功能性飲料- 發泡飲','buy.html?product=functional-nezuko-elixir','../image/sw.png',70.00,100),(44,'functional-vampire-golden-cup','吸血鬼安眠金杯','功能性飲料- 發泡飲','buy.html?product=functional-vampire-golden-cup','../image/sw.png',50.00,100),(45,'functional-popeye-drink','卜派力士活力飲','功能性飲料- 發泡飲','buy.html?product=functional-popeye-drink','../image/sw.png',70.00,96);
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

-- Dump completed on 2025-06-04 19:12:25
