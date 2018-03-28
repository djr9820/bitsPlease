---------------------------------------------
-- SQL to populate our DB with sample data --
---------------------------------------------

INSERT INTO Cities (Name, State, LocID)
VALUES ('New York City', 'NY', 1),
('San Antonio', 'TX', 2),
('San Diego', 'CA', 3),
('Los Angeles', 'CA', 4),
('Chicago', 'IL', 5),
('Houston', 'TX', 6),
('Phoenix', 'AZ', 7),
('Philadelphia', 'PA', 8),
('Dallas', 'TX', 9),
('San Jose', 'CA', 10),
('Austin', 'TX', 11),
('Rochester', 'NY', 12);

INSERT INTO Offices (OfficeID, Address, LocID)
VALUES ('OFF001', '7 Main Street', 1),
('OFF002', '2 Scottsville Road', 12);

INSERT INTO Terminals (TerminalID, TermType, Name, Address, LocID)
VALUES ('T0123', 'Terminal A', '1 Sample Street', 'Bus', 1),
('T0101', 'Train', 'Terminal B', '1 Sample Street', 1),
('T3421', 'Airport', 'Terminal A', '1 Sample Street', 2),
('T1520', 'Bus', 'Terminal A', '1 Sample Street', 3),
('T2208', 'Train', 'Terminal A', '1 Sample Street', 4),
('T0312', 'Airport', 'Terminal A', '1 Sample Street', 5),
('T0678', 'Bus', 'Terminal B', '1 Sample Street', 5),
('T0467', 'Train', 'Terminal C', '1 Sample Street', 5),
('T0902', 'Airport', 'Terminal A', '1 Sample Street', 6),
('T0350', 'Bus', 'Terminal B', '1 Sample Street', 6),
('T1234', 'Train', 'Terminal C', '1 Sample Street', 6),
('T2718', 'Airport', 'Terminal A', '1 Sample Street', 12),
('T1309', 'Bus', 'Terminal B', '1 Sample Street', 12);     

INSERT INTO Agents (FirstName, LastName, Phone, Email, AgentID, OfficeID)
VALUES('John','Smith','(999)-999-9999','JohnSmith@example.com',100,'OFF001'),
('Jane','Doe','(888)-888-8888','JaneDoe@example.com',101,'OFF002');

INSERT INTO Clients (FirstName, LastName, Phone, Email, Address, AgentID, UserName, Password)
VALUES ('Foo', 'Bar', '(777)-777-7777', 'FooBar@example.com', '123 Sample Road', 100, 'foobar', 'password');

INSERT INTO Transportation (TransID, Cost, MaxCap, AvailableTickets, DepartureTime, ArrivalTime, TotalTravelTime, DepartureTerm, ArrivalTerm)
VALUES ('TR0000', 50, 60, 55, '2018-03-29 11:00:00', '2018-03-30 12:00:00', DATEDIFF(HOUR,'2018-03-29 11:00:00', '2018-03-30 12:00:00'), 'T0123', 'T1520'),
('TR0001', 50, 100, 100, '2018-03-29 11:00:00', '2018-03-30 12:00:00', DATEDIFF(HOUR,'2018-03-29 11:00:00', '2018-03-30 12:00:00'), 'T0123', 'T1520'),
('TR0002', 100, 75, 2, '2018-04-01 11:00:00', '2018-04-01 12:00:00', DATEDIFF(HOUR,'2018-04-01 11:00:00', '2018-04-01 12:00:00'), 'T3421', 'T0312'),
('TR0003', 150, 50, 45, '2018-04-02 11:00:00', '2018-04-02 12:00:00', DATEDIFF(HOUR,'2018-04-02 11:00:00', '2018-04-02 12:00:00'), 'T1520', 'T0678'),
('TR0004', 25, 80, 26, '2018-04-03 11:00:00', '2018-04-03 12:00:00', DATEDIFF(HOUR,'2018-04-03 11:00:00', '2018-04-03 12:00:00'), 'T0350', 'T0678'),
('TR0005', 250, 63, 50, '2018-04-03 11:00:00', '2018-04-04 12:00:00', DATEDIFF(HOUR,'2018-04-03 11:00:00', '2018-04-04 12:00:00'), 'T0467', 'T0101'),
('TR0006', 45.5, 62, 1, '2018-04-03 11:00:00', '2018-04-03 12:00:00', DATEDIFF(HOUR,'2018-04-03 11:00:00', '2018-04-03 12:00:00'), 'T0312', 'T0902'),
('TR0007', 89, 20, 0, '2018-04-03 11:00:00', '2018-04-03 12:00:00', DATEDIFF(HOUR,'2018-04-03 11:00:00', '2018-04-03 12:00:00'), 'T1309', 'T0123'),
('TR0008', 95.75, 10, 0, '2018-04-05 11:00:00', '2018-04-05 12:00:00', DATEDIFF(HOUR,'2018-04-05 11:00:00', '2018-04-05 12:00:00'), 'T2718', 'T0312'),
('TR0009', 99.99, 35, 16, '2018-04-10 11:00:00', '2018-04-10 12:00:00', DATEDIFF(HOUR,'2018-04-10 11:00:00', '2018-04-10 12:00:00'), 'T2208', 'T1234'),
('TR0010', 19.99, 86, 55, '2018-04-10 11:00:00', '2018-04-10 12:00:00', DATEDIFF(HOUR,'2018-04-10 11:00:00', '2018-04-10 12:00:00'), 'T1234', 'T2208'),
('TR0011', 35, 126, 120, '2018-04-11 11:00:00', '2018-04-11 12:00:00', DATEDIFF(HOUR,'2018-04-11 11:00:00', '2018-04-11 12:00:00'), 'T0902', 'T2718');

INSERT INTO Hotels (HotelID, Name, Address, Phone, CostPerRoom, MaxRoomsCap, AvailableRooms, LocID)
VALUES ('H001', 'Hampton Inn', '22 Jump Street', '(654)-345-7344', 100.00, 60, 24, 5),
('H002', 'Mariot', '18 Main Street', '(475)-359-9293', 150.00, 120, 49, 5),
('H003', 'Day\'s Inn', '45 Robin Road', '(123)-456-7890', 75.00, 40, 11, 4),
('H004', 'Holiday Inn', '600 W Lake Road', '(987)-654-3210', 110.00, 60, 12, 3),
('H005', 'Econo Lodge', '20 Chestnut Lane', '(555)-222-1312', 80.0, 20, 5, 7),
('H006', 'Mariot', '16 Oak Road', '(252)-636-1474', 145.00, 100, 50, 8),
('H007', 'RIT Inn & Conference Center', '5257 W Henrietta Road', '(585)-359-1800', 82.00, 60, 41, 10);

INSERT INTO BillingInfo (ClientUserName, CardNum, ExpirationDate, CardType, SecurityCode)
VALUES ('foobar', 123456789002, '2020-03-11', 'Visa', '123'),
('foobar', 987654321220, '2020-02-08', 'Master Card', '987'),
('foobar', 456789123456, '2020-12-01', 'American Express', '456');