-- 1. PUBLIC USER: Adds booking
DROP PROCEDURE IF EXISTS addBooking;
DELIMITER //
CREATE PROCEDURE addBooking(
IN accountID_in  int(11),
IN flightID_in int(11),
IN updated_in DATE)
BEGIN
	INSERT INTO Booking(accountID, flightID, updatedAt) VALUES(accountID_in, flightID_in, updated_in);
END//
DELIMITER;


-- 2. PUBLIC USER: Deletes booking
DROP PROCEDURE IF EXISTS deleteBooking;
DELIMITER //
CREATE PROCEDURE deleteBooking(
IN ticketNum_in INT(11))
BEGIN
	DELETE FROM Booking
    WHERE ticketNum = ticketNum_in;
END//
DELIMITER;

-- 3. PUBLIC USER: Retrieves existing reservation info
DROP PROCEDURE IF EXISTS getBooking;
DELIMITER //
CREATE PROCEDURE getBooking(
IN accountID_in INT(11))
BEGIN
	SELECT ticketNum, flightID
	FROM Booking
	WHERE accountID = accountID_in;
END//
DELIMITER;


-- 4. PUBLIC USER: See list of flights by airport
DROP PROCEDURE IF EXISTS getFlightByAirport;
DELIMITER //
CREATE PROCEDURE getFlightByAirport(
IN airportCode_in VARCHAR(45))
BEGIN 
	SELECT flightID, departCode
    FROM FlightSchedules
    WHERE departCode = airportCode_in;
END//
DELIMITER;


-- 5. PUBLIC USER: See list of flights by price
DROP PROCEDURE IF EXISTS getFlightByPrice;
DELIMITER //
CREATE PROCEDURE getFlightByPrice(
IN flightPrice_in INT) 
BEGIN  
	SELECT flightID, flightClass, flightPrice
	FROM FlightCosts
	WHERE flightPrice = flightPrice_in;
END
DELIMITER;

-- OUTER JOIN
-- 6. PUBLIC USER: See list of flights by airline
DROP PROCEDURE IF EXISTS getFlightAirline;
DELIMITER //
CREATE PROCEDURE getFlightAirline(
IN airlineName_in VARCHAR(45))
BEGIN
	SELECT Airline.airlineName, flightID, departDate
	FROM FlightSchedules right outer join Airline on FlightSchedules.airlineID = Airline.airlineID
	WHERE airlineName = airlineName_in;
END//
DELIMITER;

-- 7. PUBLIC USER: See list of flights by date
DROP PROCEDURE IF EXISTS getFlightDate;
DELIMITER //
CREATE PROCEDURE getFlightDate(
IN flightDepartDate_in DATE)
BEGIN  
	SELECT flightID, departDate, departCode
   	FROM FlightSchedules
    WHERE departDate = flightDepartDate_in;
END//
DELIMITER;

-- 8. PUBLIC USER: See list of flights by time
DROP PROCEDURE IF EXISTS getFlightTime;
DELIMITER //
CREATE PROCEDURE getFlightTime(
IN flightDepartTime_in TIME)
BEGIN  
	SELECT flightID, departTime, departCode
    FROM FlightSchedules
    WHERE departTime = flightDepartTime_in;
END//
DELIMITER;

-- AGGREGATION
-- 9. PUBLIC USER: See farthest distance for a specific airline
DROP PROCEDURE IF EXISTS getMaxDistance;
DELIMITER //
CREATE PROCEDURE getMaxDistance(
IN airlineName_in VARCHAR(45))
BEGIN  
	SELECT Airline.airlineName, max(flightDistance) AS flightDistance
    FROM Airline, FlightSchedules
    WHERE Airline.airlineID = FlightSchedules.airlineID AND Airline.airlineName = airlineName_in;
END//
DELIMITER;

-- SET OPERATION (UNION)
-- 10. PUBLIC USER: See number of flights for each airline
DROP PROCEDURE IF EXISTS getNumberOfFlights;
DELIMITER //
CREATE PROCEDURE getNumberOfFlights()
BEGIN  
	SELECT Airline.airlineName, count(flightID) as totalFlights
	FROM Airline, FlightSchedules
	WHERE Airline.airlineID = Flightschedules.airlineID
	GROUP BY FlightSchedules.airlineID
	UNION
	SELECT Airline.airlineName, 0
	FROM Airline
	WHERE airlineID NOT IN (SELECT Airline.airlineID FROM Airline, Flightschedules WHERE Flightschedules.airlineID = Airline.airlineID);
END//
DELIMITER;

-- 1. ADMIN: Adds flight schedule
DROP PROCEDURE IF EXISTS addFlightSchedule;
DELIMITER //
CREATE PROCEDURE addFlightSchedule(
IN airlineID_in INT(11),
IN departCode_in VARCHAR(10),
IN departDate_in DATE,
IN departTime_in TIME,
IN arrivalCode_in VARCHAR(10),
IN arrivalDate_in DATE,
IN arrivalTime_in TIME,
IN flightDistance_in INT(11))
BEGIN
	INSERT INTO FlightSchedules(airlineID, departCode, departDate, departTime,
		arrivalCode, arrivalDate, arrivalTime, flightDistance)
	VALUES (airlineID_in, departCode_in, departDate_in,
	departTime_in, arrivalCode_in, arrivalDate_in, arrivalTime_in, flightDistance_in);
END//
DELIMITER;


-- 2. ADMIN: Delete flight schedule
DROP PROCEDURE IF EXISTS deleteFlightSchedule;
DELIMITER //
CREATE PROCEDURE deleteFlightSchedule(
IN flightID_in INT(11))
BEGIN
	DELETE FROM FlightSchedules
	WHERE flightID = flightID_in;
END//
DELIMITER;

-- 3. ADMIN: Updates flight schedule
DROP PROCEDURE IF EXISTS updateFlightSchedule;
DELIMITER //
CREATE PROCEDURE updateFlightSchedule(
IN flightID_in INT(11),
IN airlineID_in INT(11),
IN departCode_in VARCHAR(10),
IN departDate_in DATE,
IN departTime_in TIME,
IN arrivalCode_in VARCHAR(10),
IN arrivalDate_in DATE,
IN arrivalTime_in TIME,
IN flightDistance_in INT(11))
BEGIN
	UPDATE FlightSchedules
	SET airlineID = airlineID_in,
		departCode = departCode_in,
		departDate = departDate_in,
		departTime = departTime_in,
		arrivalCode = arrivalCode_in,
		arrivalDate = arrivalDate_in,
		arrivalTime = arrivalTime_in,
		flightDistance = flightDistance_in
	WHERE flightID = flightID_in;
END//
DELIMITER;

-- 4. ADMIN: Sees list of passengers for specific flight
DROP PROCEDURE IF EXISTS getPassengersForFlight;
DELIMITER //
CREATE PROCEDURE getPassengersForFlight(
IN flightID_in INT(11))
BEGIN
	SELECT flightID, passengerName
	FROM Passengers, Booking
	WHERE flightID = flightID_in AND Passengers.accountID = Booking.accountID;
END//
DELIMITER;

-- CORRELATED SUBQUERY
-- 5. ADMIN: Sees list of flights for a specific passenger
DROP PROCEDURE IF EXISTS getFlightsForPassenger;
DELIMITER //
CREATE PROCEDURE getFlightsForPassenger(
IN passengerName_in VARCHAR(45))
BEGIN
	SELECT *
	FROM (SELECT passengerName, flightID FROM Passengers NATURAL JOIN Booking) B1
	WHERE B1.passengerName = passengerName_in;
END//
DELIMITER;

-- 6. ADMIN: Upgrades class price (adds $200 to price of flight)
DROP PROCEDURE IF EXISTS upgradeClassPrice;
DELIMITER //
CREATE PROCEDURE upgradeClassPrice(
IN flightID_in INT(11), 
IN flightClass_in VARCHAR(45))
BEGIN
	UPDATE FlightCosts
    SET flightPrice = flightPrice + 200
    WHERE flightClass = flightClass_in AND flightID = flightID_in;
END//
DELIMITER;

-- GROUP BY/HAVING
-- 7. ADMIN: Get number of passengers on each flight
DROP PROCEDURE IF EXISTS getPassengerCount;
DELIMITER //
CREATE PROCEDURE getPassengerCount()
BEGIN
	SELECT flightID, count(ticketNum) AS passengerNum
	FROM Booking
	GROUP BY flightID
	HAVING passengerNum >= 0;
END//
DELIMITER;

-- 8. ADMIN: Archive bookings
DROP PROCEDURE IF EXISTS archiveBookings;
DELIMITER //
CREATE PROCEDURE archiveBookings(
IN cutOffTime DATE)
BEGIN
	START TRANSACTION;
		INSERT INTO BookingArchive
        SELECT ticketNum, flightID, accountID, updatedAt
        FROM Booking
        WHERE updatedAt < cutOffTime;
        
        DELETE FROM Booking
        WHERE updatedAt < cutOffTime;
    COMMIT;
END//
DELIMITER;
