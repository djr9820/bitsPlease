--------------------------------------------------------
-- Script to run on database startup to initialize DB --
--------------------------------------------------------

CREATE TABLE Cities (
	Name VARCHAR(255) NOT NULL,
	State CHAR(2) NOT NULL,
	LocID INT NOT NULL PRIMARY KEY
);

CREATE TABLE Offices (
	OfficeID CHAR(6) NOT NULL PRIMARY KEY,
	Address VARCHAR(255) NOT NULL,
	LocID INT NOT NULL,
	FOREIGN KEY (LocID) REFERENCES Cities(LocID)
);

CREATE TABLE Terminals (
	TerminalID CHAR(5) NOT NULL PRIMARY KEY,
	TermType CHAR(7) NOT NULL,
	Name VARCHAR(255),
	Address VARCHAR(255) NOT NULL,
	LocID INT NOT NULL,
	FOREIGN KEY (LocID) REFERENCES Cities(LocID)
);

CREATE TABLE Agents (
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Phone VARCHAR(20),
	Email VARCHAR(255),
	AgentID INT NOT NULL PRIMARY KEY,
	OfficeID CHAR(6) NOT NULL,
	FOREIGN KEY (OfficeID) REFERENCES Offices(OfficeID)
);

CREATE TABLE Clients (
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Phone VARCHAR(20),
	Email VARCHAR(255),
	Address VARCHAR(255),
	AgentID INT,
	UserName CHAR(17) NOT NULL PRIMARY KEY,
	Password CHAR(50) NOT NULL,
	FOREIGN KEY (AgentID) REFERENCES Agents(AgentID)
);

CREATE TABLE Transportation (
	TransID CHAR(6) NOT NULL PRIMARY KEY,
	Cost DOUBLE NOT NULL,
	MaxCap INT NOT NULL,
	AvailableTickets INT NOT NULL,
	DepartureTime DATETIME NOT NULL,
	ArrivalTime DATETIME NOT NULL,
	TotalTravelTime DOUBLE,
	DepartureTerm CHAR(5) NOT NULL,
	ArrivalTerm CHAR(5) NOT NULL,
	FOREIGN KEY (DepartureTerm) REFERENCES Terminals(TerminalID),
	FOREIGN KEY (ArrivalTerm) REFERENCES Terminals(TerminalID)
);	

CREATE TABLE Hotels (
	HotelID CHAR(5) NOT NULL PRIMARY KEY,
	Name VARCHAR(255),
	Address VARCHAR(255),
	Phone VARCHAR(20),
	CostPerRoom DOUBLE NOT NULL,
	MaxRoomsCap INT NOT NULL,
	AvailableRooms INT NOT NULL,
	LocID INT NOT NULL,
	FOREIGN KEY (LocID) REFERENCES Cities(LocID)
);

CREATE TABLE BillingInfo (
	ClientUserName CHAR(17) NOT NULL,
	CardNum INT(12) NOT NULL,
	ExpirationDate DATE NOT NULL,
	CardType VARCHAR(255) NOT NULL,
	SecurityCode CHAR(3),
	FOREIGN KEY (ClientUserName) REFERENCES Clients(UserName)
);

CREATE TABLE Trips (
	TripID char(10) NOT NULL PRIMARY KEY,
	StartDate DATE NOT NULL,
	EndDate DATE NOT NULL,
	NumTickets INT NOT NULL,
	NumRooms INT,
	TotalCost DOUBLE,
	Duration INT,
	BookedDate DATETIME,
	ClientUserName CHAR(17) NOT NULL,
	TransID CHAR(6) NOT NULL,
	HotelID CHAR(6),
	FOREIGN KEY (ClientUserName) REFERENCES Clients(UserName),
	FOREIGN KEY (TransID) REFERENCES Transportation(TransID),
	FOREIGN KEY (HotelID) REFERENCES Hotels(HotelID)
);
	