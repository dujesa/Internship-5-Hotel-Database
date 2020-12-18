-- 3. UPITI NA BAZU PODATAKA
USE HotelsBooking

-- 1) Dohvatiti sve sobe hotela odreðenog imena, i to poredane uzlazno po svom broju
SELECT * 
FROM Rooms 
INNER JOIN Hotels ON (Rooms.HotelId = Hotels.Id)
WHERE Hotels.Name LIKE 'Lero'
ORDER BY Rooms.Number ASC;

-- 2) Dohvatiti sve sobe u svim hotelima kojima broj poèinje sa brojem 1
SELECT * FROM Rooms 
WHERE Rooms.Number LIKE '1%';

-- 3) Dohvatiti samo ime i prezime svih èistaèica u odreðenom hotelu
SELECT FirstName, LastName, Hotels.Name, Employees.Role
FROM Users
INNER JOIN Employees ON (Users.Id = Employees.Id)
INNER JOIN HotelEmployees ON (Employees.Id = HotelEmployees.EmployeeId)
INNER JOIN Hotels ON (HotelEmployees.HotelId = Hotels.Id)
WHERE 
	(Hotels.Name LIKE 'Oboa' OR Hotels.Name LIKE 'Lero' OR Hotels.Name LIKE 'Ganz gross hotel')
	AND Employees.Role IN ('Èistaæ', 'Èistaæica');

-- 4) Dohvatiti kupnje od 1.12.2020. koje prelaze cijenu od 1000
SELECT * FROM Transactions
WHERE 
	[Time] > '2020-12-01'
	AND PaidPrice > 1000; 

-- 5) Dohvatiti sve boravke u svim hotelima koji su trenutno u tijeku
SELECT * FROM Appointments
INNER JOIN RoomAppointments ON (Appointments.Id = RoomAppointments.AppointmentId)
INNER JOIN Rooms ON (RoomAppointments.RoomId = Rooms.Id)
INNER JOIN Hotels ON (Rooms.HotelId = Hotels.Id)
WHERE 
	Appointments.StartTime <= GETDATE()
	AND Appointments.EndTime >= GETDATE();
	
-- 6) Izbrisati sve boravke koji su napravljeni prije 1.1.2020.
DELETE FROM Appointments
WHERE Appointments.CreatedAt <= '2020-01-01'

-- 7) Sve sobe drugog hotela po redu koje imaju kapacitet 3 poveæati kapacitet na 4
WITH OrderedRooms AS
(
	SELECT ROW_NUMBER() OVER(ORDER BY Id) AS RowNumber, Number AS RoomNumber, Capacity
	FROM Rooms
	WHERE Rooms.Capacity = 3
)
UPDATE OrderedRooms
SET Capacity = 4
WHERE RowNumber = 2;

-- 8) Dohvatiti povijesni pregled boravaka odreðene sobe, poredano po vremenu boravka
SELECT * FROM Appointments
LEFT JOIN RoomAppointments ON Appointments.Id = RoomAppointments.AppointmentId
LEFT JOIN Rooms ON RoomAppointments.RoomId = Rooms.Id
WHERE Rooms.Id = 2
ORDER BY Appointments.StartTime ASC;

-- 9) Dohvatiti sve boravke koji su bili ili pansion ili polupansion, i to samo u odreðenom hotelu
SELECT StartTime AS 'Appointment start', EndTime AS 'Appointment ends', ServiceType, Number AS 'Room number', Category, PricePerNight AS 'Price per night', [Name] AS 'Hotel name'
FROM Appointments
LEFT JOIN RoomAppointments ON Appointments.Id = RoomAppointments.AppointmentId
LEFT JOIN Rooms ON RoomAppointments.RoomId = Rooms.Id
LEFT JOIN Hotels ON Rooms.HotelId = Hotels.Id
WHERE (Appointments.ServiceType LIKE 'Pansion' OR Appointments.ServiceType LIKE 'Polupansion')
	AND Hotels.Name LIKE 'Lero';

-- 10) Promovirati 2 zaposlenika sobne posluge u recepcioniste
WITH Cleaners AS
(
	SELECT Users.Id, FirstName, LastName, PersonalIdNumber, Email, DateOfBirth, [Role] 
	FROM Users
	INNER JOIN Employees On Users.Id = Employees.Id
	WHERE Employees.Role IN ('Èistaæ', 'Èistaæica')
)
UPDATE Cleaners
SET [Role] = 'Recepcionist';

-- PROVJERA ZA 10.
SELECT * FROM Users
INNER JOIN Employees On Users.Id = Employees.Id
WHERE Users.Id IN (1, 6, 7)