DROP TABLE IF EXISTS `Airline`;
CREATE TABLE `Airline` (
  `airlineName` varchar(45) DEFAULT NULL,
  `airlineID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`airlineID`)
);

DROP TABLE IF EXISTS `Airports`;
CREATE TABLE `Airports` (
  `airportCode` varchar(10) NOT NULL,
  `airportCity` varchar(45) DEFAULT NULL,
  `airportCountry` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`airportCode`)
);

DROP TABLE IF EXISTS `Booking`;
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
);

DROP TABLE IF EXISTS `FlightCosts`;
CREATE TABLE `FlightCosts` (
  `flightID` int(11) NOT NULL,
  `flightPrice` int(11) DEFAULT NULL,
  `flightClass` varchar(45) DEFAULT NULL,
  `costID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`costID`),
  KEY `flightID_idx` (`flightID`),
  CONSTRAINT `flightID` FOREIGN KEY (`flightID`) REFERENCES `flightschedules` (`flightid`) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `FlightSchedules`;
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
);

DROP TABLE IF EXISTS `Passengers`;
CREATE TABLE `Passengers` (
  `passengerName` varchar(45) DEFAULT NULL,
  `passengerAge` int(11) DEFAULT NULL,
  `accountID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`accountID`)
);

DROP TABLE IF EXISTS `Payments`;
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
);
