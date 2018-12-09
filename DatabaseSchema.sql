DROP DATABASE IF EXISTS GreenAirlineReservation;
CREATE DATABASE GreenAirlineReservation;
USE GreenAirlineReservation;

-- Airline
DROP TABLE IF EXISTS Airline;
CREATE TABLE Airline (
  airlineName varchar(45) DEFAULT NULL,
  airlineID int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (airlineID)
);

-- Airports
DROP TABLE IF EXISTS Airports;
CREATE TABLE Airports (
  airportCode varchar(10) NOT NULL,
  airportCity varchar(45) DEFAULT NULL,
  airportCountry varchar(45) DEFAULT NULL,
  PRIMARY KEY (airportCode)
);

-- Passengers
DROP TABLE IF EXISTS Passengers;
CREATE TABLE Passengers (
  passengerName varchar(45) DEFAULT NULL,
  passengerAge int(11) DEFAULT NULL,
  accountID int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (accountID)
);

-- FlightSchedules
DROP TABLE IF EXISTS FlightSchedules;
CREATE TABLE FlightSchedules (
  flightID int(11) NOT NULL AUTO_INCREMENT,
  airlineID int(11) NOT NULL,
  departCode varchar(10) NOT NULL,
  departDate date DEFAULT NULL,
  departTime time DEFAULT NULL,
  arrivalCode varchar(10) NOT NULL,
  arrivalDate date DEFAULT NULL,
  arrivalTime time DEFAULT NULL,
  flightDistance int(11) DEFAULT NULL,
  PRIMARY KEY (flightID),
  FOREIGN KEY (airlineID) REFERENCES Airline(airlineID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (arrivalCode) REFERENCES Airports(airportCode) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (departCode) REFERENCES Airports(airportCode) ON DELETE CASCADE ON UPDATE CASCADE
);

-- FlightCosts
DROP TABLE IF EXISTS FlightCosts;
CREATE TABLE FlightCosts (
  flightID int(11) NOT NULL,
  flightPrice int(11) DEFAULT NULL,
  flightClass varchar(45) DEFAULT NULL,
  costID int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (costID),
  FOREIGN KEY(flightID) REFERENCES FlightSchedules(flightID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Booking
DROP TABLE IF EXISTS Booking;
CREATE TABLE Booking (
  accountID int(11) NOT NULL,
  flightID int(11) NOT NULL,
  ticketNum int(11) NOT NULL AUTO_INCREMENT,
  updatedAt date NOT NULL,
  PRIMARY KEY (ticketNum),
  FOREIGN KEY(accountID) REFERENCES Passengers(accountID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(flightID) REFERENCES FlightSchedules(flightID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- BookingArchive
DROP TABLE IF EXISTS BookingArchive;
CREATE TABLE BookingArchive (
  ticketNum int(11) NOT NULL,
  flightID int(11) NOT NULL,
  accountID int(11) NOT NULL,
  updatedAt date NOT NULL,
  PRIMARY KEY (ticketNum)
);

-- TRIGGER
-- 1. Add default flight costs after adding a flight schedule
DROP TRIGGER IF EXISTS AddFlightCost;
DELIMITER //
CREATE TRIGGER AddFlightCost
AFTER INSERT ON FlightSchedules
FOR EACH ROW
BEGIN
  INSERT INTO FlightCosts(flightID, flightPrice, flightClass)
  VALUES(NEW.flightID, 50, "Economy");
  INSERT INTO FlightCosts(flightID, flightPrice, flightClass)
  VALUES(NEW.flightID, 100, "First");
END;//
DELIMITER ;

-- TRIGGER
-- 2. Archives a deleted booking
DROP TRIGGER IF EXISTS ArchiveDeleted;
DELIMITER //
CREATE TRIGGER ArchiveDeleted
BEFORE DELETE ON Booking
FOR EACH ROW
BEGIN
  INSERT INTO BookingArchive
  SELECT ticketNum, flightID, accountID, updatedAt
  FROM Booking
  WHERE Booking.ticketNum = OLD.ticketNum;
END;//
DELIMITER ;


LOAD DATA LOCAL INFILE '/Users/samanthaignacio/School/SJSU/FALL 2018/CS 157A/PROJECT/FINAL SUBMISSION/SampleData/airline.txt' INTO TABLE Airline;
LOAD DATA LOCAL INFILE '/Users/samanthaignacio/School/SJSU/FALL 2018/CS 157A/PROJECT/FINAL SUBMISSION/SampleData/airport.txt' INTO TABLE Airports;
LOAD DATA LOCAL INFILE '/Users/samanthaignacio/School/SJSU/FALL 2018/CS 157A/PROJECT/FINAL SUBMISSION/SampleData/flightschedule.txt' INTO TABLE FlightSchedules;
LOAD DATA LOCAL INFILE '/Users/samanthaignacio/School/SJSU/FALL 2018/CS 157A/PROJECT/FINAL SUBMISSION/SampleData/passengers.txt' INTO TABLE Passengers;
