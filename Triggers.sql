-- 1. Ensures arrival/departure location isn’t the same
DROP TRIGGER IF EXISTS InvalidFLight;
DELIMITER //
CREATE TRIGGER InvalidFLight
AFTER INSERT ON FlightSchedules
FOR EACH ROW
BEGIN
	DELETE FROM FlightSchedules
	WHERE new.departCode = new.arrivalCode;
END;

-- 2. Booking a flight that doesn’t exist
DROP TRIGGER IF EXISTS NoFlightToBook;
DELIMITER //
CREATE TRIGGER NoFlightToBook
AFTER INSERT ON Booking
FOR EACH ROW
BEGIN
	DELETE FROM Booking
	WHERE new.flightID not in (SELECT flightID from FlightSchedules);
END;
