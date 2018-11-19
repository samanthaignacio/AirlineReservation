import java.util.*;

public class User {

	public static void publicMenu() {
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
			addBooking();
		}
		else if (input.equals("D") || input.equals("d")) {
			deleteBooking();
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
			publicMenu();
		}
	}

	public static void addBooking() {
		
	}

	public static void deleteBooking() {

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

	public static void adminMenu() {
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
			adminMenu();
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