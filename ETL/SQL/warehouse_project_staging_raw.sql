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
-- Table structure for table `staging_raw`
--

DROP TABLE IF EXISTS `staging_raw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staging_raw` (
  `flight_id` int NOT NULL,
  `flight_date` varchar(20) DEFAULT NULL,
  `flight_status` varchar(20) DEFAULT NULL,
  `departure_airport` varchar(200) DEFAULT NULL,
  `departure_iata` varchar(10) DEFAULT NULL,
  `departure_delay_minutes` int DEFAULT NULL,
  `departure_scheduled` varchar(50) DEFAULT NULL,
  `departure_estimated` varchar(50) DEFAULT NULL,
  `departure_actual` varchar(50) DEFAULT NULL,
  `arrival_airport` varchar(200) DEFAULT NULL,
  `arrival_iata` varchar(10) DEFAULT NULL,
  `arrival_scheduled` varchar(50) DEFAULT NULL,
  `arrival_delay_minutes` int DEFAULT NULL,
  `arrival_estimated` varchar(50) DEFAULT NULL,
  `arrival_actual` varchar(50) DEFAULT NULL,
  `airline_name` varchar(200) DEFAULT NULL,
  `airline_iata` varchar(10) DEFAULT NULL,
  `airline_icao` varchar(10) DEFAULT NULL,
  `flight_number` varchar(20) DEFAULT NULL,
  `flight_iata` varchar(20) DEFAULT NULL,
  `flight_icao` varchar(20) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `month` int DEFAULT NULL,
  `day` int DEFAULT NULL,
  `day_of_week` varchar(20) DEFAULT NULL,
  `total_delay_minutes` int DEFAULT NULL,
  `route` varchar(100) DEFAULT NULL,
  `is_delayed` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`flight_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

