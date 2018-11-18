-- ADMIN: #2
DROP PROCEDURE IF EXISTS deleteFlightSchedule;
DELIMITER //
CREATE PROCEDURE deleteFlightSchedule(
IN flightID_in INT(11))
BEGIN
	DELETE FROM FlightSchedules
	WHERE flightID = flightID_in;
END//
DELIMETER;

-- ADMIN: #3
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
DELIMETER;

-- ADMIN: #4
DROP PROCEDURE IF EXISTS getPassengersForFlight;
DELIMITER //
CREATE PROCEDURE getPassengersForFlight(
IN flightID_in INT(11))
BEGIN
	SELECT flightID, passengerName
	FROM Passengers, Booking
	WHERE flightID = flightID_in AND Passengers.accountID = Booking.accountID;
END//
DELIMETER;

-- ADMIN: #5
DROP PROCEDURE IF EXISTS getFlightsForPassenger;
DELIMITER //
CREATE PROCEDURE getFlightsForPassenger(
IN passengerName_in VARCHAR(45))
BEGIN
	SELECT passengerName, flightID
	FROM Passengers, Booking
	WHERE passengerName = passengerName_in AND Passengers.accountID = Booking.accountID;
END//
DELIMETER;

-- ADMIN: #6
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