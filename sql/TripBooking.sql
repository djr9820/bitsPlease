-- Display all modes of transportation from departing to destination on given date
-- params : Departure City, Arrival City, Departure DATE
SELECT DISTINCT Terminals.TermType 
FROM Terminals
JOIN Transportation on (Terminals.TerminalID = DepartureTerm)
WHERE (Terminals.LocID = /*Departure City ID*/
	AND /*Arrival City ID*/ IN ( SELECT LocID 
		FROM Terminals
		JOIN Transportation on (Terminals.TerminalID = ArrivalTerm)
		WHERE (Terminals.LocID = /*Arrival City ID*/)
	)
	AND /*Departure Date*/ = CAST(Transportation.DepartureTime AS DATE)
	AND Transportation.AvailableTickets != 0
);

-- Displays full info about trips with the specified params provided by the user
-- params: Departure City, Arrival City, Departure DATE, number of tickets, transportation mode
SELECT CASE WHEN TermType = 'Airport' THEN 'Flight'
	ELSE TermType END AS ModeOfTransportation,
	Cost,
	MaxCap - AvailableTickets AS UnavailableTickets,
	AvailableTickets,
	DepartureTime,
	ArrivalTime,
	TotalTravelTime,
	TransID -- This is for adding to the Trips table (if the user decides to book this mode of transportation)
FROM Transportation
JOIN Terminals on (Terminals.TerminalID = DepartureTerm)
WHERE (Terminals.LocID = /*Departure City ID*/
	AND /*Arrival City ID*/ IN ( SELECT LocID 
		FROM Terminals
		JOIN Transportation on (Terminals.TerminalID = ArrivalTerm)
		WHERE (Terminals.LocID = /*Arrival City ID*/)
	)
	AND /*Departure Date*/ = CAST(Transportation.DepartureTime AS DATE)
	AND Transportation.AvailableTickets >= /*number of tickets*/
	AND Terminals.TermType = /*transportation mode*/
);

-- Displays information about available hotels in the destination city
-- params: Arrival City, Number of nights to stay, Number of rooms
SELECT Name,
	Address,
	Phone,
	CostPerRoom * /*Number of nights*/ AS CostPerRoomPerNight,
	CostPerRoom * /*Number of nights*/ * /*Number of rooms*/ AS TotalHotelCost,
	HotelID -- This is for adding to the Trips table (if the user decides to book this hotel)
FROM Hotels
WHERE (LocID = /*Arrival City ID*/
	AND AvailableRooms >= /*Number of rooms*/);

-- Select all payment cards associated with the user doing the booking
-- params: Client username
SELECT RIGHT(CONVERT(CardNum, VARCHAR(12)), 8) AS EndingCardDigits
FROM BillingInfo
WHERE (/*Client username*/ = ClientUserName);

-- User chooses to add a new card
-- params: Client username, all other values entered by the user
INSERT INTO BillingInfo(ClientUserName, CardNum, ExpirationDate, CardType, SecurityCode)
VALUES(/*Client username*/,/*put values given by user here*/);

-- steps associated with confirmed booking of a trip

-- first, add trip to the trips table
-- params: Client username, all other values entered by the user, transId, hotelID
INSERT INTO Trips(TripID, StartDate, EndDate, NumTickets, NumRooms, TotalCost, Duration, BookedDate, ClientUserName, TransID, HotelID)
VALUES(/*Max(Trip ID) + 1*/, /*put values given by user here*/, /*Client username*/, /*Transportation ID retrieved from booked trip query*/,
/*Hotel ID retreived from previous query, if user booked hotel*/)

-- second, update the selected transportation row's ticket count
-- params: number of tickets bought, transID
UPDATE Transportation
SET AvailableTickets = AvailableTickets - /*number of tickets*/
WHERE (TransID = /*Transportation ID retrieved from booked trip query*/);

-- finally, update the selected hotel's room count (if the user booked a hotel)
-- params: number of rooms booked, hotelID
UPDATE Hotels
SET AvailableRooms = AvailableRooms - /*number of rooms*/
WHERE (HotelID = /*Hotel ID retreived from previous query, if user booked hotel*/);