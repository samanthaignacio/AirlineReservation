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
-- Table structure for table `Airline`
--

DROP TABLE IF EXISTS `Airline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Airline` (
  `airlineName` varchar(45) DEFAULT NULL,
  `airlineID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`airlineID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Airports`
--

DROP TABLE IF EXISTS `Airports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Airports` (
  `airportCode` varchar(10) NOT NULL,
  `airportCity` varchar(45) DEFAULT NULL,
  `airportCountry` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`airportCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Booking`
--

DROP TABLE IF EXISTS `Booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Booking` (
  `accountID` int(11) NOT NULL,
  `flightID` int(11) NOT NULL,
  `ticketNum` int(11) NOT NULL AUTO_INCREMENT,
  `paymentID` int(11) NOT NULL,
  PRIMARY KEY (`ticketNum`),
  KEY `bookingAccountID_idx` (`accountID`),
  KEY `bookingFlightID_idx` (`flightID`),
  KEY `paymentID_idx` (`paymentID`),
  CONSTRAINT `bookingAccountID` FOREIGN KEY (`accountID`) REFERENCES `passengers` (`accountid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bookingFlightID` FOREIGN KEY (`flightID`) REFERENCES `flightschedules` (`flightid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `paymentID` FOREIGN KEY (`paymentID`) REFERENCES `payments` (`paymentid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FlightCosts`
--

DROP TABLE IF EXISTS `FlightCosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `FlightCosts` (
  `flightID` int(11) NOT NULL,
  `flightPrice` int(11) DEFAULT NULL,
  `flightClass` varchar(45) DEFAULT NULL,
  `costID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`costID`),
  KEY `flightID_idx` (`flightID`),
  CONSTRAINT `flightID` FOREIGN KEY (`flightID`) REFERENCES `flightschedules` (`flightid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `Passengers`
--

DROP TABLE IF EXISTS `Passengers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Passengers` (
  `passengerName` varchar(45) DEFAULT NULL,
  `passengerAge` int(11) DEFAULT NULL,
  `accountID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`accountID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Payments`
--

DROP TABLE IF EXISTS `Payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Payments` (
  `accountID` int(11) NOT NULL,
  `flightID` int(11) NOT NULL,
  `creditCardNum` int(11) DEFAULT NULL,
  `paymentID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`paymentID`),
  KEY `accountID_idx` (`accountID`),
  KEY `paymentFlightID_idx` (`flightID`),
  CONSTRAINT `accountID` FOREIGN KEY (`accountID`) REFERENCES `passengers` (`accountid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `paymentFlightID` FOREIGN KEY (`flightID`) REFERENCES `flightschedules` (`flightid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-11-17 10:11:45
