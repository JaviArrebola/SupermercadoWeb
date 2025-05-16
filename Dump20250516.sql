CREATE DATABASE  IF NOT EXISTS `supermercadodb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `supermercadodb`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: supermercadodb
-- ------------------------------------------------------
-- Server version	8.2.0

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
-- Table structure for table `administrador`
--

DROP TABLE IF EXISTS `administrador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `administrador` (
  `id` int NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `id` FOREIGN KEY (`id`) REFERENCES `empleados` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrador`
--

LOCK TABLES `administrador` WRITE;
/*!40000 ALTER TABLE `administrador` DISABLE KEYS */;
INSERT INTO `administrador` VALUES (1),(2);
/*!40000 ALTER TABLE `administrador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_venta`
--

DROP TABLE IF EXISTS `detalle_venta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_venta` (
  `id_venta` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int DEFAULT NULL,
  `precio_unitario` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_venta`,`id_producto`),
  KEY `id_producto_idx` (`id_producto`),
  CONSTRAINT `id_producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`),
  CONSTRAINT `id_venta` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id_venta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_venta`
--

LOCK TABLES `detalle_venta` WRITE;
/*!40000 ALTER TABLE `detalle_venta` DISABLE KEYS */;
INSERT INTO `detalle_venta` VALUES (1,3,2,2.50),(1,10,1,0.85),(2,1,2,1.20),(2,6,2,0.95),(2,11,1,1.50),(3,2,2,1.80),(3,5,1,2.30),(4,14,2,2.80),(4,15,1,3.80),(5,9,1,0.40),(5,18,2,1.90),(5,27,1,1.30),(6,4,3,1.10),(6,20,1,1.00),(7,12,2,1.90),(7,13,1,3.50),(7,36,1,1.20),(8,26,2,1.90),(8,30,1,3.00),(9,16,1,3.80),(9,23,2,1.70),(9,24,1,5.50),(10,7,2,1.00),(10,33,1,2.40),(11,10,1,0.85),(11,38,2,3.90),(12,6,1,0.95),(12,19,2,1.90),(12,35,1,1.20),(13,9,1,0.40),(13,22,3,2.00),(14,2,1,1.80),(14,32,2,2.20),(14,36,1,1.20),(15,13,1,3.50),(15,17,1,1.60),(15,25,2,2.60),(16,6,3,0.95),(16,28,1,2.90),(17,20,1,1.00),(17,29,2,2.10),(17,31,1,2.60),(18,24,2,5.50),(18,34,1,2.50),(19,3,2,2.50),(20,8,3,1.20),(20,18,1,1.90),(21,5,1,2.30),(21,39,2,3.90),(22,15,2,3.80),(22,19,1,1.90),(23,12,1,1.90),(23,27,2,1.30),(24,10,1,0.85),(24,21,2,1.00),(24,28,1,2.90),(25,1,1,1.20),(25,24,2,5.50),(26,2,3,1.80),(26,36,1,1.20),(27,6,2,0.95),(27,33,2,2.40),(28,22,3,2.00),(28,38,1,3.90),(29,17,2,1.60),(29,35,1,1.20),(30,9,1,0.40),(30,37,1,1.80),(30,40,2,1.40),(31,3,2,2.50),(31,5,1,2.30),(31,12,3,1.90),(31,17,2,1.60),(31,27,1,1.30),(31,36,1,1.20),(32,10,2,0.85),(32,14,1,2.80),(32,18,2,1.90),(32,22,3,2.00),(32,24,1,5.50),(33,2,2,1.80),(33,4,1,1.10),(33,6,2,0.95),(33,26,1,1.90),(33,30,1,3.00),(33,33,2,2.40),(34,7,2,1.00),(34,19,1,1.90),(34,24,2,5.50),(34,36,1,1.20),(34,38,2,3.90),(35,9,1,0.40),(35,11,3,1.50),(35,21,2,1.00),(35,28,2,2.90),(35,32,1,2.20),(35,35,1,1.20),(36,1,2,1.20),(36,5,1,4.50),(36,13,2,6.20),(36,17,3,3.37),(36,25,1,0.89),(36,30,3,2.50),(37,3,2,2.30),(37,5,2,4.50),(37,7,1,2.80),(37,31,2,4.33),(37,34,1,1.78),(37,40,2,2.25),(38,2,2,1.50),(38,4,2,3.10),(38,12,3,0.99),(38,15,2,3.60),(38,38,1,1.10),(39,1,2,1.20),(39,10,3,5.00),(39,17,2,3.37),(39,23,1,3.20),(39,29,2,3.99),(40,2,2,1.50),(40,8,3,1.70),(40,26,2,1.65),(40,35,2,2.69),(40,39,1,2.17),(41,6,3,2.00),(41,12,2,0.99),(41,14,2,2.90),(41,20,2,4.75),(41,27,1,3.45),(42,7,3,2.80),(42,11,2,3.75),(42,18,1,1.89),(42,19,2,2.45),(42,32,2,3.05),(42,36,1,3.95),(43,1,2,1.20),(43,4,2,3.10),(43,9,2,1.90),(43,29,2,3.99),(43,40,2,2.25),(44,10,2,5.00),(44,14,2,2.90),(44,21,2,2.55),(44,25,2,0.89),(44,33,1,5.20),(45,2,2,1.50),(45,11,3,3.75),(45,22,2,1.49),(45,24,1,4.60),(45,27,2,3.45),(46,3,2,2.30),(46,5,1,4.50),(46,6,2,2.00),(46,16,1,4.10),(46,19,3,2.45),(47,13,1,6.20),(47,14,2,2.90),(47,17,2,3.37),(47,28,2,2.58),(47,35,2,2.69),(48,1,3,1.20),(48,7,2,2.80),(48,12,3,0.99),(48,18,2,1.89),(48,30,2,2.50),(48,33,2,5.20),(49,10,1,5.00),(49,23,1,3.20),(49,26,2,1.65),(49,31,2,4.33),(49,36,2,3.95),(50,2,1,1.50),(50,6,3,2.00),(50,15,2,3.60),(50,38,2,1.10),(50,39,3,2.17),(51,1,2,1.20),(51,3,2,2.30),(51,5,2,4.50),(51,22,2,1.49),(51,34,2,1.78),(52,2,2,1.50),(52,8,3,1.70),(52,21,2,2.55),(52,24,2,4.60),(52,37,1,4.80),(53,1,2,1.20),(53,4,2,3.10),(53,13,2,6.20),(53,30,2,2.50),(53,36,1,3.95),(53,40,2,2.25),(54,11,2,3.75),(54,17,2,3.37),(54,20,1,4.75),(54,23,2,3.20),(54,25,2,0.89),(55,6,3,2.00),(55,9,2,1.90),(55,12,4,0.99),(55,14,3,2.90),(55,39,1,2.17),(56,2,2,1.50),(56,5,2,4.50),(56,13,2,6.20),(56,26,2,1.65),(56,33,1,5.20),(57,3,1,2.30),(57,7,3,2.80),(57,19,2,2.45),(57,28,2,2.58),(57,35,2,2.69),(58,10,2,5.00),(58,12,3,0.99),(58,16,2,4.10),(58,29,2,3.99),(58,34,2,1.78),(59,1,2,1.20),(59,4,2,3.10),(59,8,2,1.70),(59,17,2,3.37),(59,18,3,1.89),(60,6,2,2.00),(60,21,2,2.55),(60,32,3,3.05),(60,38,2,1.10),(60,39,2,2.17);
/*!40000 ALTER TABLE `detalle_venta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleados` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `password` varchar(30) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefono` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleados`
--

LOCK TABLES `empleados` WRITE;
/*!40000 ALTER TABLE `empleados` DISABLE KEYS */;
INSERT INTO `empleados` VALUES (1,'Mariana López','aK3p9Lm2','mariana.lopez@email.com',112345678),(2,'Carlos Gómez','bQ8r2Tx5','carlos.gomez@email.com',119876543),(3,'Sofía Martínez','zR4t8Ys1','sofia.martinez@email.com',114567890),(4,'Luciano Torres','nV6d1Wp3','luciano.torres@email.com',117654321),(5,'Valentina Ruiz','pK2x7Qm4','valentina.ruiz@email.com',113456789),(6,'Martín Fernández','hT5v9Ae6','martin.fernandez@email.com',118765432),(7,'Julieta Sánchez','dM9q2Lt7','julieta.sanchez@email.com',116543210),(8,'Tomás Navarro','xL3p5Wr8','tomas.navarro@email.com',115678901),(9,'Camila Rojas','fG7k3Vb1','camila.rojas@email.com',117891234),(10,'Nicolás Castro','mE2n6Sy9','nicolas.castro@email.com',112398745);
/*!40000 ALTER TABLE `empleados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock` int DEFAULT NULL,
  `codigo_barras` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Leche entera 1L',1.20,150,NULL),(2,'Pan de molde blanco 500g',1.80,120,NULL),(3,'Huevos blancos docena',2.50,85,NULL),(4,'Arroz largo fino 1Kg',1.10,200,NULL),(5,'Aceite de girasol 1L',2.30,90,NULL),(6,'Fideos spaghetti 500g',0.95,130,NULL),(7,'Harina de trigo 1Kg',1.00,110,NULL),(8,'Azúcar blanca 1Kg',1.20,100,NULL),(9,'Sal fina 500g',0.40,140,NULL),(10,'Tomate triturado lata 400g',0.85,150,NULL),(11,'Atún en aceite 170g',1.50,75,NULL),(12,'Galletitas dulces surtidas 300g',1.90,95,NULL),(13,'Yerba mate 1Kg',3.50,70,NULL),(14,'Café molido 250g',2.80,60,NULL),(15,'Té en saquitos x25',1.10,80,NULL),(16,'Queso cremoso 500g',3.80,55,NULL),(17,'Jamón cocido 200g',2.70,65,NULL),(18,'Manteca 200g',1.60,70,NULL),(19,'Yogur bebible 1L',1.90,90,NULL),(20,'Jugo en polvo naranja',0.40,160,NULL),(21,'Agua mineral 2L',1.00,180,NULL),(22,'Gaseosa cola 2.25L',2.00,140,NULL),(23,'Cerveza rubia lata 473ml',1.70,130,NULL),(24,'Vino tinto Malbec 750ml',5.50,50,NULL),(25,'Papel higiénico x4 rollos',2.60,100,NULL),(26,'Detergente líquido 750ml',1.90,85,NULL),(27,'Lavandina 1L',1.30,120,NULL),(28,'Shampoo 400ml',2.90,90,NULL),(29,'Jabón de tocador x3',2.10,100,NULL),(30,'Desodorante en aerosol',3.00,70,NULL),(31,'Pañales x20 unidades',7.50,60,NULL),(32,'Toallas femeninas x8',2.40,80,NULL),(33,'Cereal azucarado 300g',2.20,85,NULL),(34,'Galletas saladas 250g',1.50,110,NULL),(35,'Mayonesa 250g',1.20,100,NULL),(36,'Mostaza 250g',1.10,95,NULL),(37,'Ketchup 500g',1.80,90,NULL),(38,'Queso rallado 150g',2.50,75,NULL),(39,'Helado crema americana 1L',3.90,60,NULL),(40,'Chocolate con leche 100g',1.40,80,NULL);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ventas`
--

DROP TABLE IF EXISTS `ventas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ventas` (
  `id_venta` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_venta`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (1,'2025-05-01 08:00:00',5.40),(2,'2025-05-01 08:10:00',7.90),(3,'2025-05-01 08:20:00',4.80),(4,'2025-05-01 08:30:00',12.60),(5,'2025-05-01 08:40:00',9.10),(6,'2025-05-01 08:50:00',6.30),(7,'2025-05-01 09:00:00',10.70),(8,'2025-05-01 09:10:00',8.50),(9,'2025-05-01 09:20:00',13.20),(10,'2025-05-01 09:30:00',4.40),(11,'2025-05-01 09:40:00',11.60),(12,'2025-05-01 09:50:00',7.30),(13,'2025-05-01 10:00:00',6.90),(14,'2025-05-01 10:10:00',8.80),(15,'2025-05-01 10:20:00',14.00),(16,'2025-05-01 10:30:00',6.60),(17,'2025-05-01 10:40:00',7.70),(18,'2025-05-01 10:50:00',12.90),(19,'2025-05-01 11:00:00',5.10),(20,'2025-05-01 11:10:00',10.40),(21,'2025-05-01 11:20:00',11.10),(22,'2025-05-01 11:30:00',9.80),(23,'2025-05-01 11:40:00',8.30),(24,'2025-05-01 11:50:00',6.00),(25,'2025-05-01 12:00:00',12.20),(26,'2025-05-01 12:10:00',9.40),(27,'2025-05-01 12:20:00',7.60),(28,'2025-05-01 12:30:00',13.70),(29,'2025-05-01 12:40:00',5.80),(30,'2025-05-01 12:50:00',10.00),(31,'2025-05-02 08:00:12',18.60),(32,'2025-05-02 08:10:33',22.30),(33,'2025-05-02 08:20:08',19.40),(34,'2025-05-02 08:30:46',24.90),(35,'2025-05-02 08:40:21',21.75),(36,'2025-05-02 08:50:59',20.10),(37,'2025-05-02 09:00:07',23.30),(38,'2025-05-02 09:10:55',19.90),(39,'2025-05-02 09:20:38',26.40),(40,'2025-05-02 09:30:18',27.10),(41,'2025-05-02 09:40:49',25.30),(42,'2025-05-02 09:50:25',18.70),(43,'2025-05-02 10:00:11',22.40),(44,'2025-05-02 10:10:43',24.70),(45,'2025-05-02 10:20:02',23.80),(46,'2025-05-02 10:30:30',20.65),(47,'2025-05-02 10:40:17',19.75),(48,'2025-05-02 10:50:50',21.60),(49,'2025-05-02 11:00:04',22.20),(50,'2025-05-02 11:10:36',23.40),(51,'2025-05-02 11:20:59',19.95),(52,'2025-05-02 11:30:14',25.00),(53,'2025-05-02 11:40:44',26.10),(54,'2025-05-02 11:50:22',20.20),(55,'2025-05-02 12:00:39',22.85),(56,'2025-05-02 12:10:06',24.90),(57,'2025-05-02 12:20:48',21.50),(58,'2025-05-02 12:30:27',19.20),(59,'2025-05-02 12:40:15',23.10),(60,'2025-05-02 12:50:53',26.30);
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-05-16 10:14:24
