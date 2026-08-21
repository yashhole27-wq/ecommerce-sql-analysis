-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: ecommerce_analysis
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int NOT NULL,
  `category_name` varchar(100) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Electronics'),(2,'Clothing'),(3,'Home & Kitchen'),(4,'Books'),(5,'Sports');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `registration_date` date DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Aarav Sharma','aarav.sharma@email.com','Pune','Maharashtra','2024-01-15'),(2,'Riya Patil','riya.patil@email.com','Mumbai','Maharashtra','2024-02-20'),(3,'Aditya Kulkarni','aditya.k@email.com','Pune','Maharashtra','2024-03-10'),(4,'Sneha Joshi','sneha.joshi@email.com','Nashik','Maharashtra','2024-04-05'),(5,'Rahul Deshmukh','rahul.d@email.com','Nagpur','Maharashtra','2024-05-12'),(6,'Priya Shah','priya.shah@email.com','Ahmedabad','Gujarat','2024-06-18'),(7,'Rohan Mehta','rohan.mehta@email.com','Mumbai','Maharashtra','2024-07-22'),(8,'Ananya Rao','ananya.rao@email.com','Bengaluru','Karnataka','2024-08-14'),(9,'Vikram Singh','vikram.singh@email.com','Delhi','Delhi','2024-09-01'),(10,'Neha Verma','neha.verma@email.com','Jaipur','Rajasthan','2024-10-11'),(11,'Karan Gupta','karan.gupta@email.com','Delhi','Delhi','2024-11-03'),(12,'Pooja Nair','pooja.nair@email.com','Kochi','Kerala','2024-12-09'),(13,'Arjun Iyer','arjun.iyer@email.com','Chennai','Tamil Nadu','2025-01-08'),(14,'Meera Kapoor','meera.kapoor@email.com','Delhi','Delhi','2025-02-16'),(15,'Sahil Khan','sahil.khan@email.com','Hyderabad','Telangana','2025-03-21');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `order_item_id` int NOT NULL,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `fk_order_items_order` (`order_id`),
  KEY `fk_order_items_product` (`product_id`),
  CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `fk_order_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1001,101,1,65000.00),(2,1001,103,2,3500.00),(3,1002,102,1,28000.00),(4,1002,108,1,1299.00),(5,1003,105,3,799.00),(6,1003,106,1,1499.00),(7,1004,109,1,4500.00),(8,1004,110,1,2200.00),(9,1005,114,1,2499.00),(10,1005,113,2,999.00),(11,1006,104,1,5500.00),(12,1006,115,1,4200.00),(13,1007,101,1,65000.00),(14,1008,111,3,499.00),(15,1008,112,1,899.00),(16,1009,107,1,2999.00),(17,1009,113,1,999.00),(18,1010,103,2,3500.00),(19,1010,115,1,4200.00),(20,1011,101,1,65000.00),(21,1011,102,1,28000.00),(22,1012,109,2,4500.00),(23,1012,110,1,2200.00),(24,1013,106,2,1499.00),(25,1013,108,1,1299.00),(26,1014,102,1,28000.00),(27,1014,104,1,5500.00),(28,1015,114,2,2499.00),(29,1015,107,1,2999.00),(30,1016,101,1,65000.00),(31,1016,103,1,3500.00),(32,1017,115,2,4200.00),(33,1017,104,1,5500.00),(34,1018,105,2,799.00),(35,1018,108,2,1299.00),(36,1019,109,1,4500.00),(37,1019,110,2,2200.00),(38,1020,102,1,28000.00),(39,1020,103,1,3500.00),(40,1021,101,1,65000.00),(41,1021,115,1,4200.00),(42,1022,107,2,2999.00),(43,1022,113,1,999.00),(44,1023,112,2,899.00),(45,1023,111,2,499.00),(46,1024,102,1,28000.00),(47,1024,104,1,5500.00),(48,1025,101,1,65000.00),(49,1026,103,3,3500.00),(50,1026,115,1,4200.00),(51,1027,109,1,4500.00),(52,1027,110,1,2200.00),(53,1028,106,2,1499.00),(54,1028,105,2,799.00),(55,1029,101,1,65000.00),(56,1029,102,1,28000.00),(57,1030,114,1,2499.00),(58,1030,113,2,999.00);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `order_date` date DEFAULT NULL,
  `order_status` varchar(30) DEFAULT NULL,
  `payment_method` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_orders_customer` (`customer_id`),
  CONSTRAINT `fk_orders_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1001,1,'2025-01-05','Completed','UPI'),(1002,2,'2025-01-08','Completed','Credit Card'),(1003,3,'2025-01-15','Completed','UPI'),(1004,4,'2025-01-22','Completed','Debit Card'),(1005,5,'2025-02-03','Completed','Cash on Delivery'),(1006,6,'2025-02-10','Completed','UPI'),(1007,7,'2025-02-18','Cancelled','Credit Card'),(1008,8,'2025-03-02','Completed','UPI'),(1009,9,'2025-03-12','Completed','Debit Card'),(1010,10,'2025-03-25','Completed','UPI'),(1011,11,'2025-04-05','Completed','Credit Card'),(1012,12,'2025-04-17','Completed','UPI'),(1013,13,'2025-05-03','Completed','Debit Card'),(1014,14,'2025-05-14','Completed','UPI'),(1015,15,'2025-05-28','Completed','Cash on Delivery'),(1016,1,'2025-06-06','Completed','UPI'),(1017,2,'2025-06-19','Completed','Credit Card'),(1018,3,'2025-07-04','Completed','UPI'),(1019,4,'2025-07-16','Completed','Debit Card'),(1020,5,'2025-07-29','Completed','UPI'),(1021,6,'2025-08-08','Completed','Credit Card'),(1022,7,'2025-08-21','Completed','UPI'),(1023,8,'2025-09-02','Completed','Debit Card'),(1024,9,'2025-09-15','Completed','UPI'),(1025,10,'2025-09-27','Pending','Credit Card'),(1026,11,'2025-10-05','Completed','UPI'),(1027,12,'2025-10-18','Completed','Debit Card'),(1028,13,'2025-11-03','Completed','UPI'),(1029,14,'2025-11-16','Completed','Credit Card'),(1030,15,'2025-12-05','Completed','UPI');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL,
  `product_name` varchar(100) NOT NULL,
  `category_id` int DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `stock_quantity` int DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (101,'Laptop',1,65000.00,25),(102,'Smartphone',1,28000.00,40),(103,'Wireless Headphones',1,3500.00,60),(104,'Smartwatch',1,5500.00,35),(105,'T-Shirt',2,799.00,100),(106,'Jeans',2,1499.00,75),(107,'Running Shoes',5,2999.00,50),(108,'Backpack',2,1299.00,80),(109,'Coffee Maker',3,4500.00,30),(110,'Dinner Set',3,2200.00,45),(111,'Novel',4,499.00,120),(112,'Programming Book',4,899.00,70),(113,'Yoga Mat',5,999.00,65),(114,'Cricket Bat',5,2499.00,40),(115,'Bluetooth Speaker',1,4200.00,55);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-21 19:51:57
