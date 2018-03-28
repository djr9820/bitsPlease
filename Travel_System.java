// shell for Travel_System


import java.sql.*;



public class Travel_System {

    static Connection conn;
    static Statement stmt;

    public static boolean connect() throws Exception {
        try{
//            System.out.println("in connect()");
            Class.forName("org.h2.Driver");
//            Server embeddedServer = new Server();
//            embeddedServer.run(new String[]{ "-tcp", "-web" }, System.out);
            conn = DriverManager.getConnection( "jdbc:h2:~/test1","sa","" );
//            System.out.println(conn);
            stmt = conn.createStatement();
        }
        catch( java.sql.SQLException e ){
            System.out.println( e.getMessage() );
        }

        return true; //TODO
    }

    public static boolean d_connect() throws Exception {
        try {
            conn.close();
        }
        catch( java.sql.SQLException e ) {
            System.out.println( e.getMessage() );
        }

        return true; //TODO
    }

    public static boolean query( String query_Str ){
        try {
            System.out.println(stmt);
            stmt.executeUpdate( query_Str );
        }
        catch( java.sql.SQLException e ) {
            System.out.println( e.getMessage() );
        }

        return true; //TODO
    }

    public static void setupDB() {
        query("CREATE TABLE Cities (Name VARCHAR(255) NOT NULL,"
                + "State CHAR(2) NOT NULL,LocID INT NOT NULL PRIMARY KEY)");
        query("CREATE TABLE Offices (OfficeID CHAR(6) NOT NULL PRIMARY KEY,"
                + "Address VARCHAR(255) NOT NULL,LocID INT NOT NULL,FOREIGN KEY (LocID) REFERENCES Cities(LocID))");
        query("CREATE TABLE Terminals (TerminalID CHAR(5) NOT NULL PRIMARY KEY,"
                + "TermType CHAR(7) NOT NULL,LocID INT NOT NULL,FOREIGN KEY (LocID) REFERENCES Cities(LocID))");
        query("CREATE TABLE Agents (FirstName VARCHAR(50) NOT NULL,LastName VARCHAR(50) NOT NULL,"
                + "Phone VARCHAR(20),Email VARCHAR(255),AgentID INT NOT NULL PRIMARY KEY,OfficeID CHAR(6) NOT NULL,"
                + "FOREIGN KEY (OfficeID) REFERENCES Offices(OfficeID))");
        query("CREATE TABLE Clients (FirstName VARCHAR(50) NOT NULL,LastName VARCHAR(50) NOT NULL,"
                + "Phone VARCHAR(20),Email VARCHAR(255),Address VARCHAR(255),AgentID INT,"
                + "UserName CHAR(30) NOT NULL PRIMARY KEY,Password CHAR(50) NOT NULL,FOREIGN KEY (AgentID) REFERENCES Agents(AgentID))");
        query("CREATE TABLE Transportation (TransID CHAR(6) NOT NULL PRIMARY KEY,Cost DOUBLE NOT NULL,"
                + "MaxCap INT NOT NULL,AvailableTickets INT NOT NULL,DepartureTime DATETIME NOT NULL,ArrivalTime DATETIME NOT NULL,"
                + "TotalTravelTime INT,DepartureTerm CHAR(5) NOT NULL,ArrivalTerm CHAR(5) NOT NULL,"
                + "FOREIGN KEY (DepartureTerm) REFERENCES Terminals(TerminalID),FOREIGN KEY (ArrivalTerm) REFERENCES Terminals(TerminalID)");
        query("CREATE TABLE Hotels (HotelID CHAR(5) NOT NULL PRIMARY KEY,Name VARCHAR(255),Address VARCHAR(255),"
                + "Phone VARCHAR(20),CostPerRoom DOUBLE NOT NULL,MaxRoomsCap INT NOT NULL,AvailableRooms INT NOT NULL,"
                + "LocID INT NOT NULL,FOREIGN KEY (LocID) REFERENCES Cities(LocID))");
        query("CREATE TABLE BillingInfo (ClientUserName INT NOT NULL,CardNum INT(12) NOT NULL,ExpirationDate DATE NOT NULL,"
                + "CardType VARCHAR(255) NOT NULL,SecurityCode CHAR(3),FOREIGN KEY (ClientUserName) REFERENCES Clients(ClientUserName))");
        query("CREATE TABLE Trips (TripID char(10) NOT NULL PRIMARY KEY,StartDate DATE NOT NULL,EndDate DATE NOT NULL,"
                + "NumTickets INT NOT NULL,NumRooms INT,TotalCost DOUBLE,Duration INT,BookedDate DATETIME,ClientUserName INT NOT NULL,"
                + "TransID CHAR(6) NOT NULL,HotelID CHAR(6),FOREIGN KEY (ClientUserName) REFERENCES Clients(ClientUserName),"
                + "FOREIGN KEY (TransID) REFERENCES Transportation(TransID),FOREIGN KEY (HotelID) REFERENCES Hotels(HotelID))");
        query("COMMIT");
    }

    public static void main( String [] args ) throws Exception {
        System.out.println("HELLO");
        connect();
        setupDB();
        d_connect();


    }
}
