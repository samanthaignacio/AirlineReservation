-- MySQL dump 10.13  Distrib 8.0.12, for macos10.13 (x86_64)
--
-- Host: localhost    Database: AirlineReservation
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `FlightSchedules`
--

DROP TABLE IF EXISTS `FlightSchedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `FlightSchedules` (
  `flightID` int(11) NOT NULL AUTO_INCREMENT,
  `airlineID` int(11) NOT NULL,
  `departCode` varchar(10) NOT NULL,
  `departDate` date DEFAULT NULL,
  `departTime` time DEFAULT NULL,
  `arrivalCode` varchar(10) NOT NULL,
  `arrivalDate` date DEFAULT NULL,
  `arrivalTime` time DEFAULT NULL,
  `flightDistance` int(11) DEFAULT NULL,
  PRIMARY KEY (`flightID`),
  KEY `airlineID_idx` (`airlineID`),
  KEY `departCode_idx` (`departCode`),
  KEY `arrivalCode_idx` (`arrivalCode`),
  CONSTRAINT `airlineID` FOREIGN KEY (`airlineID`) REFERENCES `airline` (`airlineid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `arrivalCode` FOREIGN KEY (`arrivalCode`) REFERENCES `airports` (`airportcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `departCode` FOREIGN KEY (`departCode`) REFERENCES `airports` (`airportcode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FlightSchedules`
--

LOCK TABLES `FlightSchedules` WRITE;
/*!40000 ALTER TABLE `FlightSchedules` DISABLE KEYS */;
INSERT INTO `FlightSchedules` VALUES (1,1,'SJC','2018-11-14','09:00:00','SMF','2018-11-14','10:00:00',120);
/*!40000 ALTER TABLE `FlightSchedules` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-16 21:24:43
