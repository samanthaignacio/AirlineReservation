import java.sql.*;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.*;
import java.util.*;

public class User {

	public static void publicMenu(Connection c) throws SQLException, ParseException {
		Scanner publicScan = new Scanner(System.in);

		System.out.println();
		System.out.println("Select one of the following options:");
		System.out.println("[A]dd a booking");
		System.out.println("[D]elete a booking");
		System.out.println("[R]etrieve existing booking information");
		System.out.println("[1] See list of flights by airport");
		System.out.println("[2] See list of flights by price");
		System.out.println("[3] See list of flights by airline");
		System.out.println("[4] See list of flights by date");
		System.out.println("[5] See list of flights by time");
		System.out.println("[6] See farthest distance for an airline");
		System.out.println("[7] See number of flights for each airline");
		System.out.println("[E]xit");

		String input = publicScan.next();
		if (input.equals("A") || input.equals("a")) {
			addBooking(c);
			publicMenu(c);
		} else if (input.equals("D") || input.equals("d")) {
			deleteBooking(c);
			publicMenu(c);
		} else if (input.equals("R") || input.equals("r")) {
			retrieveBooking(c);
			publicMenu(c);
		} else if (input.equals("1")) {
			flightsByAirport(c);
			publicMenu(c);
		} else if (input.equals("2")) {
			flightsByPrice(c);
			publicMenu(c);
		} else if (input.equals("3")) {
			flightsByAirline(c);
			publicMenu(c);
		} else if (input.equals("4")) {
			flightsByDate(c);
			publicMenu(c);
		} else if (input.equals("5")) {
			flightsByTime(c);
			publicMenu(c);
		} else if (input.equals("6")) {
			maxDistance(c);
			publicMenu(c);
		} else if (input.equals("7")) {
			numberFlights(c);
			publicMenu(c);
		} else if (input.equals("E") || input.equals("e")) {
			System.out.print("Have a nice day! Goodbye.");
			System.exit(0);
		} else {
			System.out.println("That is not a valid option. Please try again.");
			System.out.println();
			publicMenu(c);
		}
	}

	public static void addBooking(Connection c) throws SQLException {
		Scanner scan = new Scanner(System.in);

		LocalDate ld = java.time.LocalDate.now();
		Date d = java.sql.Date.valueOf(ld);

		System.out.println("Please enter the following:");
		System.out.print("Account ID: ");
		String result = scan.next();
		int acctID = Integer.parseInt(result);

		System.out.print("Flight ID: ");
		result = scan.next();
		int fltID = Integer.parseInt(result);

		CallableStatement cs = c.prepareCall("{CALL addBooking(?, ?, ?)}");
		cs.setInt(1, acctID);
		cs.setInt(2, fltID);
		cs.setDate(3, d);

		cs.executeUpdate();

		System.out.println("Booking has been added!");
	}

	public static void deleteBooking(Connection c) throws SQLException {
		Scanner scan = new Scanner(System.in);

		System.out.println("Please enter the following:");
		System.out.print("Ticket Number: ");
		String result = scan.next();
		int ticketNum = Integer.parseInt(result);

		CallableStatement cs = c.prepareCall("{CALL deleteBooking(?)}");
		cs.setInt(1, ticketNum);

		cs.executeUpdate();

		System.out.println("Booking has been deleted!");
	}

	public static void retrieveBooking(Connection c) throws SQLException {
		Scanner scan = new Scanner(System.in);

		System.out.println("Please enter the following:");
		System.out.print("Account ID: ");
		String result = scan.next();
		int acctID = Integer.parseInt(result);

		CallableStatement cs = c.prepareCall("{CALL getBooking(?)}");
		cs.setInt(1, acctID);

		Boolean hasResults = cs.execute();
		if (hasResults) {
			ResultSet rs = cs.getResultSet();
			while (rs.next()) {
				int ticket = rs.getInt("ticketNum");
				int flight = rs.getInt("flightID");
				System.out.println("Ticket Number: " + ticket + " Flight ID: " + flight);
			}
		}
	}

	public static void flightsByAirport(Connection c) throws SQLException {
		Scanner scan = new Scanner(System.in);

		System.out.println("Please enter the following:");
		System.out.print("Airport Code: ");
		String result = scan.next();

		CallableStatement cs = c.prepareCall("{CALL getFlightByAirport(?)}");
		cs.setString(1, result);

		Boolean hasResults = cs.execute();
		while (hasResults) {
			ResultSet rs = cs.getResultSet();
			while (rs.next()) {
				int flight = rs.getInt("flightID");
				String depart = rs.getString("departCode");
				System.out.println("Flight ID: " + flight + " Depart Code: " + depart);
			}
			rs.close();
			hasResults = cs.getMoreResults();
		}
	}

	public static void flightsByPrice(Connection c) throws SQLException {
		Scanner scan = new Scanner(System.in);

		System.out.println("Please enter the following:");
		System.out.print("Price: ");
		String result = scan.next();
		int price = Integer.parseInt(result);

		CallableStatement cs = c.prepareCall("{CALL getFlightByPrice(?)}");
		cs.setInt(1, price);

		Boolean hasResults = cs.execute();
		while (hasResults) {
			ResultSet rs = cs.getResultSet();
			while (rs.next()) {
				int flight = rs.getInt("flightID");
				String fClass = rs.getString("flightClass");
				int cost = rs.getInt("flightPrice");
				System.out.println("Flight ID: " + flight + " Class: " + fClass + " Price: " + cost);
			}
			rs.close();
			hasResults = cs.getMoreResults();
		}
	}

	public static void flightsByAirline(Connection c) throws SQLException {
		Scanner scan = new Scanner(System.in);

		System.out.println("Please enter the following:");
		System.out.print("Airline: ");
		String result = scan.next();
		String airline = result;

		CallableStatement cs = c.prepareCall("{CALL getFlightAirline(?)}");
		cs.setString(1, airline);

		Boolean hasResults = cs.execute();
		while (hasResults) {
			ResultSet rs = cs.getResultSet();
			while (rs.next()) {
				String airName = rs.getString("airlineName");
				int fltID = rs.getInt("flightID");
				Date d = rs.getDate("departDate");
				System.out.println("Airline: " + airName + " Flight ID: " + fltID + " Depart Date: " + d);
			}
			rs.close();
			hasResults = cs.getMoreResults();
		}
	}

	public static void flightsByDate(Connection c) throws SQLException, ParseException {
		Scanner scan = new Scanner(System.in);

		System.out.println("Please enter the following:");
		System.out.print("Depart Date (format: yyyy-mm-dd): ");
		String result = scan.next();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date date = format.parse(result);
		java.sql.Date d = new java.sql.Date(date.getTime());

		CallableStatement cs = c.prepareCall("{CALL getFlightDate(?)}");
		cs.setDate(1, d);

		Boolean hasResults = cs.execute();
		while (hasResults) {
			ResultSet rs = cs.getResultSet();
			while (rs.next()) {
				int flight = rs.getInt("flightID");
				Date depDate = rs.getDate("departDate");
				String depCode = rs.getString("departCode");
				System.out.println("Flight ID: " + flight + " Depart Date: " + depDate + " Depart Code: " + depCode);
			}
			rs.close();
			hasResults = cs.getMoreResults();
		}
	}

	public static void flightsByTime(Connection c) throws SQLException {
		Scanner scan = new Scanner(System.in);

		System.out.println("Please enter the following:");
		System.out.print("Time (format: hh:mm:ss): ");
		String result = scan.next();
		Time t = Time.valueOf(result);

		CallableStatement cs = c.prepareCall("{CALL getFlightTime(?)}");
		cs.setTime(1, t);

		Boolean hasResults = cs.execute();
		while (hasResults) {
			ResultSet rs = cs.getResultSet();
			while (rs.next()) {
				int flight = rs.getInt("flightID");
				Time time = rs.getTime("departTime");
				String depart = rs.getString("departCode");
				System.out.println("Flight ID: " + flight + " Depart Time: " + time + " Depart Code: " + depart);
			}
			rs.close();
			hasResults = cs.getMoreResults();
		}
	}

	public static void maxDistance(Connection c) throws SQLException {
		Scanner scan = new Scanner(System.in);

		System.out.println("Please enter the following:");
		System.out.print("Airline: ");
		String result = scan.next();
		String airline = result;

		CallableStatement cs = c.prepareCall("{CALL getMaxDistance(?)}");
		cs.setString(1, airline);

		Boolean hasResults = cs.execute();
		if (hasResults) {
			ResultSet rs = cs.getResultSet();
			while (rs.next()) {
				String airName = rs.getString("airlineName");
				int fltDis = rs.getInt("flightDistance");
				System.out.println("Airline: " + airName + " Flight Distance: " + fltDis);
			}
		}
	}

	public static void numberFlights(Connection c) throws SQLException {
		CallableStatement cs = c.prepareCall("{CALL getNumberOfFlights()}");

		Boolean hasResults = cs.execute();
		while (hasResults) {
			ResultSet rs = cs.getResultSet();
			while (rs.next()) {
				String airName = rs.getString("airlineName");
				int num = rs.getInt("totalFlights");
				System.out.println("Airline: " + airName + " | Number of Flights: " + num);
			}
			rs.close();
			hasResults = cs.getMoreResults();
		}
	}

	public static void adminMenu(Connection c) throws SQLException, ParseException {
		Scanner adminScan = new Scanner(System.in);

		System.out.println();
		System.out.println("Select one of the following options:");
		System.out.println("[A]dd a flight schedule");
		System.out.println("[D]elete a flight schedule");
		System.out.println("[U]pdate a flight schedule");
		System.out.println("[I]ncrease a class price");
		System.out.println("[1] See list of passengers for a flight");
		System.out.println("[2] See list of flights for a passenger");
		System.out.println("[3] See number of passengers on each flight");
		System.out.println("[*] Archive Flights");
		System.out.println("[E]xit");

		String input = adminScan.next();
		if (input.equals("A") || input.equals("a")) {
			addFlightSchedule(c);
			adminMenu(c);
		} else if (input.equals("D") || input.equals("d")) {
			deleteFlightSchedule(c);
			adminMenu(c);
		} else if (input.equals("U") || input.equals("u")) {
			updateFlightSchedule(c);
			adminMenu(c);
		} else if (input.equals("I") || input.equals("i")) {
			increaseClassPrice(c);
			adminMenu(c);
		} else if (input.equals("1")) {
			passengersPerFlight(c);
			adminMenu(c);
		} else if (input.equals("2")) {
			flightsPerPassenger(c);
			adminMenu(c);
		} else if (input.equals("3")) {
			passengerCount(c);
			adminMenu(c);
		} else if (input.equals("*")) {
			archiveFlights(c);
			adminMenu(c);
		} else if (input.equals("E") || input.equals("e")) {
			System.out.print("Have a nice day! Goodbye.");
			System.exit(0);
		} else {
			System.out.println("That is not a valid option. Please try again.");
			System.out.println();
			adminMenu(c);
		}
	}

	public static void addFlightSchedule(Connection c) throws SQLException, ParseException {
		Scanner scan = new Scanner(System.in);

		System.out.println("Please enter the following:");
		System.out.print("Airline ID: ");
		String result = scan.next();
		int airID = Integer.parseInt(result);

		System.out.print("Depart Code: ");
		result = scan.next();
		String depCode = result;

		System.out.print("Depart Date (format: yyyy-mm-dd): ");
		result = scan.next();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date date = format.parse(result);
		java.sql.Date d = new java.sql.Date(date.getTime());

		System.out.print("Depart Time (format: hh:mm:ss): ");
		result = scan.next();
		Time t = Time.valueOf(result);

		System.out.print("Arrival Code: ");
		result = scan.next();
		String arrCode = result;

		System.out.print("Arrival Date (format: yyyy-mm-dd): ");
		result = scan.next();
		java.util.Date arrDate = format.parse(result);
		java.sql.Date arrD = new java.sql.Date(arrDate.getTime());

		System.out.print("Arrival Time (format: hh:mm:ss): ");
		result = scan.next();
		Time arrT = Time.valueOf(result);

		System.out.print("Flight Distance: ");
		result = scan.next();
		int distance = Integer.parseInt(result);

		CallableStatement cs = c.prepareCall("{CALL addFlightSchedule(?, ?, ?, ?, ?, ?, ?, ?)}");
		cs.setInt(1, airID);
		cs.setString(2, depCode);
		cs.setDate(3, d);
		cs.setTime(4, t);
		cs.setString(5, arrCode);
		cs.setDate(6, arrD);
		cs.setTime(7, arrT);
		cs.setInt(8, distance);

		cs.executeUpdate();

		System.out.println("Flight Schedule has been added!");
		System.out.println("Please upgrade flight costs!");
	}

	public static void deleteFlightSchedule(Connection c) throws SQLException {
		Scanner scan = new Scanner(System.in);

		System.out.println("Please enter the following:");
		System.out.print("Flight ID: ");
		String result = scan.next();
		int fltID = Integer.parseInt(result);

		CallableStatement cs = c.prepareCall("{CALL deleteFLightSchedule(?)}");
		cs.setInt(1, fltID);

		cs.executeUpdate();

		System.out.println("Flight Schedule has been deleted!");
	}

	public static void updateFlightSchedule(Connection c) throws SQLException, ParseException {
		Scanner scan = new Scanner(System.in);

		System.out.println("Please enter the following:");

		System.out.print("Flight ID: ");
		String result = scan.next();
		int fltID = Integer.parseInt(result);

		System.out.print("Airline ID: ");
		result = scan.next();
		int airID = Integer.parseInt(result);

		System.out.print("Depart Code: ");
		result = scan.next();
		String depCode = result;

		System.out.print("Depart Date (format: yyyy-mm-dd): ");
		result = scan.next();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date date = format.parse(result);
		java.sql.Date d = new java.sql.Date(date.getTime());

		System.out.print("Depart Time (format: hh:mm:ss): ");
		result = scan.next();
		Time t = Time.valueOf(result);

		System.out.print("Arrival Code: ");
		result = scan.next();
		String arrCode = result;

		System.out.print("Arrival Date (format: yyyy-mm-dd): ");
		result = scan.next();
		java.util.Date arrDate = format.parse(result);
		java.sql.Date arrD = new java.sql.Date(arrDate.getTime());

		System.out.print("Arrival Time (format: hh:mm:ss): ");
		result = scan.next();
		Time arrT = Time.valueOf(result);

		System.out.print("Flight Distance: ");
		result = scan.next();
		int distance = Integer.parseInt(result);

		CallableStatement cs = c.prepareCall("{CALL updateFlightSchedule(?, ?, ?, ?, ?, ?, ?, ?, ?)}");
		cs.setInt(1, fltID);
		cs.setInt(2, airID);
		cs.setString(3, depCode);
		cs.setDate(4, d);
		cs.setTime(5, t);
		cs.setString(6, arrCode);
		cs.setDate(7, arrD);
		cs.setTime(8, arrT);
		cs.setInt(9, distance);

		cs.executeUpdate();

		System.out.println("Flight Schedule has been updated!");
	}

	public static void increaseClassPrice(Connection c) throws SQLException {
		Scanner scan = new Scanner(System.in);

		System.out.println("Please enter the following:");
		System.out.print("Flight ID: ");
		String result = scan.next();
		int fltID = Integer.parseInt(result);

		System.out.print("Class: ");
		result = scan.next();
		String fClass = result;

		CallableStatement cs = c.prepareCall("{CALL upgradeClassPrice(?, ?)}");
		cs.setInt(1, fltID);
		cs.setString(2, fClass);

		cs.executeUpdate();

		System.out.println("Class price has been increased!");
	}

	public static void passengersPerFlight(Connection c) throws SQLException {
		Scanner scan = new Scanner(System.in);

		System.out.println("Please enter the following:");
		System.out.print("Flight ID: ");
		String result = scan.next();
		int fltID = Integer.parseInt(result);

		CallableStatement cs = c.prepareCall("{CALL getPassengersForFlight(?)}");
		cs.setInt(1, fltID);

		Boolean hasResults = cs.execute();
		while (hasResults) {
			ResultSet rs = cs.getResultSet();
			while (rs.next()) {
				int flight = rs.getInt("flightID");
				String name = rs.getString("passengerName");
				System.out.println("Flight ID: " + flight + " " + name);
			}
			rs.close();
			hasResults = cs.getMoreResults();
		}
	}

	public static void flightsPerPassenger(Connection c) throws SQLException {
		Scanner scan = new Scanner(System.in);

		System.out.println("Please enter the following:");
		System.out.print("Passenger Name: ");
		String result = scan.next();
		String name = result;

		CallableStatement cs = c.prepareCall("{CALL getFlightsForPassenger(?)}");
		cs.setString(1, name);

		Boolean hasResults = cs.execute();
		while (hasResults) {
			ResultSet rs = cs.getResultSet();
			while (rs.next()) {
				String passengerName = rs.getString("passengerName");
				int fltID = rs.getInt("flightID");
				System.out.println("Passenger Name: " + passengerName + " Flight ID: " + fltID);
			}
			rs.close();
			hasResults = cs.getMoreResults();
		}
	}

	public static void passengerCount(Connection c) throws SQLException {
		CallableStatement cs = c.prepareCall("{CALL getPassengerCount()}");

		Boolean hasResults = cs.execute();
		while (hasResults) {
			ResultSet rs = cs.getResultSet();
			while (rs.next()) {
				int flight = rs.getInt("flightID");
				int num = rs.getInt("passengerNum");
				System.out.println("Flight ID: " + flight + " Number of Passengers: " + num);
			}
			rs.close();
			hasResults = cs.getMoreResults();
		}
	}

	public static void archiveFlights(Connection c) throws SQLException, ParseException {
		Scanner scan = new Scanner(System.in);

		System.out.println("Please enter the following:");
		System.out.print("Cut Off Date (format: yyyy-mm-dd): ");
		String result = scan.next();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date date = format.parse(result);
		java.sql.Date cutDate = new java.sql.Date(date.getTime());

		CallableStatement cs = c.prepareCall("{CALL archiveBookings(?)}");
		cs.setDate(1, cutDate);
		
		cs.executeUpdate();

		System.out.println("Booking(s) has been archived!");
	}
}
