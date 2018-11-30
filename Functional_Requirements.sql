-- 1. PUBLIC USER: Adds booking
DROP PROCEDURE IF EXISTS addBooking;
DELIMITER //
CREATE PROCEDURE addBooking(
IN accountID_in  int(11),
IN flightID_in int(11),
IN paymentID_in int(11),
IN updated_in DATE)
BEGIN
	INSERT INTO Booking(accountID, flightID, paymentID, updatedAt) VALUES(accountID_in, flightID_in, paymentID_in, updated_in);
END
DELIMITER;


-- 2. PUBLIC USER: Deletes booking
DROP PROCEDURE IF EXISTS deleteBooking;
DELIMITER //
CREATE PROCEDURE deleteBooking(
IN ticketNum_in INT(11))
BEGIN
	DELETE FROM Booking
    WHERE ticketNum = ticketNum_in;
END
DELIMITER;

-- 3. PUBLIC USER: Retrieves existing reservation info
DROP PROCEDURE IF EXISTS getBooking;
DELIMITER //
CREATE PROCEDURE getBooking(
IN accountID_in INT(11))
BEGIN
	SELECT ticketNum, flightID, paymentID
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
IN flightPrice_in INT, 
BEGIN  
	SELECT flightID, flightPrice
	FROM FlightCosts
    WHERE flightPrice = flightPrice_in;
END
DELIMITER;

-- 6. PUBLIC USER: See list of flights by airline
DROP PROCEDURE IF EXISTS getFlightAirline;
DELIMITER //
CREATE PROCEDURE getFlightAirline(
IN airlineName_in VARCHAR(45))
BEGIN 
	SELECT flightID, airlineName
    FROM Airline, FlightSchedules
    WHERE airlineName = airlineName_in AND FlightSchedules.airlineID = Airline.airlineID;
END//
DELIMITER;

-- 7. PUBLIC USER: See list of flights by date
DROP PROCEDURE IF EXISTS getFlightDate;
DELIMITER //
CREATE PROCEDURE getFlightDate(
IN flightDepartDate_in DATE)
BEGIN  
	SELECT flightID, departDate
   	FROM FlightSchedules
    WHERE departDate = flightDepartDate_in;
END
DELIMITER;

-- 8. PUBLIC USER: See list of flights by time
DROP PROCEDURE IF EXISTS getFlightTime;
DELIMITER //
CREATE PROCEDURE getFlightTime(
IN flightDepartTime_in TIME)
BEGIN  
	SELECT flightID, departTime
    FROM FlightSchedules
    WHERE departTime = flightDepartTime_in;
END
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

-- 5. ADMIN: Sees list of flights for a specific passenger
DROP PROCEDURE IF EXISTS getFlightsForPassenger;
DELIMITER //
CREATE PROCEDURE getFlightsForPassenger(
IN passengerName_in VARCHAR(45))
BEGIN
	SELECT passengerName, flightID
	FROM Passengers, Booking
	WHERE passengerName = passengerName_in AND Passengers.accountID = Booking.accountID;
END//
DELIMITER;

-- 6. ADMIN: Sees list of passengers who are over 21
DROP PROCEDURE IF EXISTS getPassengerOver21;
DELIMITER //
CREATE PROCEDURE getPassengerOver21(
IN flightID_in INT(11))
BEGIN
	SELECT flightID, passengerName
	FROM Passengers, Booking
	WHERE flightID = flightID_in AND Passengers.accountID = Booking.accountID
	AND passengerAge > 20;
END//
DELIMETER;

-- 7. ADMIN: Upgrades class price (adds $200 to price of flight)
DROP PROCEDURE IF EXISTS upgradeClassPrice;
DELIMITER //
CREATE PROCEDURE upgradeClassPrice(
IN flightID_in INT(11), 
IN flightClass_in VARCHAR(45))
BEGIN
	UPDATE FlightCosts
    SET flightPrice = flightPrice + 200
    WHERE flightClass = flightClass_in AND flightID = flightID_in;
END
DELIMITER;

-- 8. ADMIN: Archive bookings
DROP PROCEDURE IF EXISTS archiveBookings;
DELIMITER //
CREATE PROCEDURE archiveBookings(
IN cutOffTime DATE)
BEGIN
	START TRANSACTION;
		INSERT INTO BookingArchive
        SELECT ticketNum, flightID, accountID, paymentID, updatedAt
        FROM Booking
        WHERE updatedAt < cutOffTime;
        
        DELETE FROM Booking
        WHERE updatedAt < cutOffTime;
    COMMIT;
END
DELIMITER;
