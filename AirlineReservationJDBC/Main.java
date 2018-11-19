import java.sql.*;
import java.util.*;
 
public class Main extends User
{
   // JDBC driver name and database URL
   static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
   static final String DB_URL = "jdbc:mysql://localhost/AirlineReservation";

   //  Database credentials
   static final String USER = "root";
   static final String PASS = "password";
   
   static Connection conn = null;
   static Statement stmt = null;
   static ResultSet rs = null;
   
  public static void main(String[] argv) throws SQLException {
 
	try {
	 //STEP 2: Register JDBC driver (automatically done since JDBC 4.0)
      Class.forName("com.mysql.cj.jdbc.Driver");

      //STEP 3: Open a connection
      System.out.println("Connecting to database...");
      System.out.println();
      conn = DriverManager.getConnection(DB_URL, USER, PASS);

	} catch (SQLException e) {
		System.out.println("Connection Failed! Check output console");
		e.printStackTrace();
		return;
	} catch (Exception e) {
		e.printStackTrace();
	}
	if (conn != null) {
		System.out.println("Welcome to the Airline Reservation System!");
		mainMenu();
	} else {
		System.out.println("Failed to make connection!");
	}	
  }
  
  public static void mainMenu() {
	  Scanner scan = new Scanner(System.in);
	  
	  System.out.println("Select one of the following options:");
	  System.out.println("[P]ublic User [A]dministrator");
	  String input = scan.next();
	  if (input.equals("P") || input.equals("p")) {
		  publicMenu();
	  }
	  else if (input.equals("A") || input.equals("a")) {
		  adminMenu();
	  }
	  else {
		  System.out.println("That is not a valid option. Please try again.");
		  System.out.println();
		  mainMenu();
	  }
	  
  }
}
