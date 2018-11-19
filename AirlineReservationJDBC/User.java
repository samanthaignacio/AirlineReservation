import java.sql.*;
import java.util.*;

public class User {

	public static void publicMenu(Connection c) throws SQLException {
		Scanner publicScan = new Scanner(System.in);

		System.out.println("Welcome Public User!");
		System.out.println("Select one of the following options:");
		System.out.println("[A]dd a booking");
		System.out.println("[D]elete a booking");
		System.out.println("[R]etrieve existing booking information");
		System.out.println("[1] See list of flights by airport");
		System.out.println("[2] See list of flights by price");
		System.out.println("[3] See list of flights by airline");
		System.out.println("[4] See list of flights by date");
		System.out.println("[5] See list of flights by time");

		String input = publicScan.next();
		if (input.equals("A") || input.equals("a")) {
			addBooking(c);
		}
		else if (input.equals("D") || input.equals("d")) {
			deleteBooking(c);
		}
		else if (input.equals("R") || input.equals("r")) {
			retrieveBooking();
		}
		else if (input.equals("1")) {
			flightsByAirport();
		}
		else if (input.equals("2")) {
			flightsByPrice();
		}
		else if (input.equals("3")) {
			flightsByAirline();
		}
		else if (input.equals("4")) {
			flightsByDate();
		}
		else if (input.equals("5")) {
			flightsByTime();
		}
		else {
			System.out.println("That is not a valid option. Please try again.");
			System.out.println();
			publicMenu(c);
		}
	}

	public static void addBooking(Connection c) throws SQLException {
		Scanner scan = new Scanner(System.in);
		
		System.out.println("Please enter the following:");
		System.out.print("Account ID: ");
		String result = scan.next();
		int acctID = Integer.parseInt(result);
		
		System.out.print("Flight ID: ");
		result = scan.next();
		int fltID = Integer.parseInt(result);
		
		System.out.print("Payment ID: ");
		result = scan.next();
		int payID = Integer.parseInt(result);
		
		CallableStatement cs = c.prepareCall("{CALL addBooking(?, ?, ?)}");
		cs.setInt(1, acctID);
		cs.setInt(2,  fltID);
		cs.setInt(3,  payID);
		
		cs.executeUpdate();
		
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
	}

	public static void retrieveBooking() {

	}

	public static void flightsByAirport() {

	}
	
	public static void flightsByPrice() {
		
	}
	
	public static void flightsByAirline() {
		
	}
	
	public static void flightsByDate() {
		
	}
	
	public static void flightsByTime() {
		
	}

	public static void adminMenu(Connection c) {
		Scanner adminScan = new Scanner(System.in);

		System.out.println("Welcome Administrator!");
		System.out.println("Select one of the following options:");
		System.out.println("[A]dd a flight schedule");
		System.out.println("[D]elete a flight schedule");
		System.out.println("[U]pdate a flight schedule");
		System.out.println("[I]ncrease a class price");
		System.out.println("[1] See list of passengers for a flight");
		System.out.println("[2] See list of flights for a passenger");
		System.out.println("[3] See list of passengers age 21+");

		String input = adminScan.next();
		if (input.equals("A") || input.equals("a")) {
			addFlightSchedule();
		}
		else if (input.equals("D") || input.equals("d")) {
			deleteFlightSchedule();
		}
		else if (input.equals("U") || input.equals("u")) {
			updateFlightSchedule();
		}
		else if (input.equals("I") || input.equals("i")) {
			increaseClassPrice();
		}
		else if (input.equals("1")) {
			passengersPerFlight();
		}
		else if (input.equals("2")) {
			flightsPerPassenger();
		}
		else if (input.equals("3")) {
			passengersOverAge();
		}
		else {
			System.out.println("That is not a valid option. Please try again.");
			System.out.println();
			adminMenu(c);
		}
	}
	
	public static void addFlightSchedule() {
		
	}
	
	public static void deleteFlightSchedule() {
		
	}
	
	public static void updateFlightSchedule() {
		
	}
	
	public static void increaseClassPrice() {
		
	}
	
	public static void passengersPerFlight() {
		
	}
	
	public static void flightsPerPassenger() {
		
	}
	
	public static void passengersOverAge() {
		
	}
}
