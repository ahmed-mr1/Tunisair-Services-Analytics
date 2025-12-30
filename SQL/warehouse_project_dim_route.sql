CREATE DATABASE  IF NOT EXISTS `warehouse_project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `warehouse_project`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: warehouse_project
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `dim_route`
--

DROP TABLE IF EXISTS `dim_route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dim_route` (
  `route_id` int NOT NULL AUTO_INCREMENT,
  `from_airport_id` int DEFAULT NULL,
  `to_airport_id` int DEFAULT NULL,
  `route_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`route_id`),
  UNIQUE KEY `from_airport_id` (`from_airport_id`,`to_airport_id`),
  KEY `route_name` (`route_name`),
  KEY `to_airport_id` (`to_airport_id`),
  CONSTRAINT `dim_route_ibfk_1` FOREIGN KEY (`from_airport_id`) REFERENCES `dim_airport` (`airport_id`),
  CONSTRAINT `dim_route_ibfk_2` FOREIGN KEY (`to_airport_id`) REFERENCES `dim_airport` (`airport_id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


