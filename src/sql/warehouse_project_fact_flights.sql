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
-- Table structure for table `fact_flights`
--

DROP TABLE IF EXISTS `fact_flights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fact_flights` (
  `flight_id` int NOT NULL,
  `airline_id` int NOT NULL,
  `route_id` int NOT NULL,
  `from_airport_id` int NOT NULL,
  `to_airport_id` int NOT NULL,
  `flight_date` date NOT NULL,
  `day_of_week` varchar(20) DEFAULT NULL,
  `flight_number` varchar(20) DEFAULT NULL,
  `flight_status` varchar(20) DEFAULT NULL,
  `departure_scheduled` varchar(50) DEFAULT NULL,
  `departure_actual` varchar(50) DEFAULT NULL,
  `arrival_scheduled` varchar(50) DEFAULT NULL,
  `arrival_actual` varchar(50) DEFAULT NULL,
  `departure_delay_minutes` int DEFAULT '0',
  `arrival_delay_minutes` int DEFAULT '0',
  `total_delay_minutes` int DEFAULT '0',
  `is_delayed` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`flight_id`),
  KEY `flight_date` (`flight_date`),
  KEY `airline_id` (`airline_id`),
  KEY `route_id` (`route_id`),
  KEY `flight_status` (`flight_status`),
  KEY `is_delayed` (`is_delayed`),
  KEY `from_airport_id` (`from_airport_id`),
  KEY `to_airport_id` (`to_airport_id`),
  CONSTRAINT `fact_flights_ibfk_1` FOREIGN KEY (`airline_id`) REFERENCES `dim_airline` (`airline_id`),
  CONSTRAINT `fact_flights_ibfk_2` FOREIGN KEY (`route_id`) REFERENCES `dim_route` (`route_id`),
  CONSTRAINT `fact_flights_ibfk_3` FOREIGN KEY (`from_airport_id`) REFERENCES `dim_airport` (`airport_id`),
  CONSTRAINT `fact_flights_ibfk_4` FOREIGN KEY (`to_airport_id`) REFERENCES `dim_airport` (`airport_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

