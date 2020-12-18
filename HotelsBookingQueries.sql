-- 3. UPITI NA BAZU PODATAKA
USE HotelsBooking


-- 1) Dohvatiti sve sobe hotela odreðenog imena, i to poredane uzlazno po svom broju
SELECT * 
FROM Rooms 
INNER JOIN Hotels ON (Rooms.HotelId = Hotels.Id)
WHERE Hotels.Name LIKE 'Lero'
ORDER BY Rooms.Number ASC;


-- 2) Dohvatiti sve sobe u svim hotelima kojima broj pocinje sa brojem 1
SELECT 
	Rooms.Number,
	Rooms.Capacity,
	Rooms.PricePerNight,
	CASE WHEN Rooms.TvAvailable = 1 THEN 'Yes' ELSE 'No' END AS 'TV Available',
	Hotels.[Name] AS 'Hotel name'
FROM Rooms 
LEFT JOIN Hotels ON Rooms.HotelId = Hotels.Id
WHERE Rooms.Number LIKE '1%';


-- 3) Dohvatiti samo ime i prezime svih cistacica u odreðenom hotelu
SELECT FirstName, LastName, Hotels.[Name] AS 'Hotel name', Employees.[Role] AS 'Employee role'
FROM Users
INNER JOIN Employees ON (Users.Id = Employees.Id)
INNER JOIN HotelEmployees ON (Employees.Id = HotelEmployees.EmployeeId)
INNER JOIN Hotels ON (HotelEmployees.HotelId = Hotels.Id)
WHERE 
	(Hotels.Name LIKE 'Oboa' OR Hotels.Name LIKE 'Lero' OR Hotels.Name LIKE 'Ganz gross hotel')
	AND Employees.Role IN ('Cistac', 'Cistacica');


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

	
-- Proof of concept for task 6. => pre-delete command execution
SELECT * FROM Appointments
WHERE Appointments.CreatedAt <= '2020-01-01';

-- 6) Izbrisati sve boravke koji su napravljeni prije 1.1.2020.
DELETE FROM Appointments
WHERE Appointments.CreatedAt <= '2020-01-01';

-- Proof of concept for task 6. => pre-delete command execution
SELECT * FROM Appointments
WHERE Appointments.CreatedAt <= '2020-01-01';


-- Proof of concept for task 7. => pre-update command execution, all rooms with 3 and 4 capacity
SELECT * FROM Rooms
WHERE Capacity IN (3, 4)

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

-- Proof of concept for task 7. => post-update command execution, all rooms with 3 and 4 capacity
SELECT * FROM Rooms
WHERE Capacity IN (3, 4)


-- 8) Dohvatiti povijesni pregled boravaka odreðene sobe, poredano po vremenu boravka
SELECT 
	Appointments.StartTime AS 'Appointment start time',
	Appointments.EndTime AS 'Appointment end time',
	Appointments.CreatedAt AS 'Appointment creation time',
	Appointments.ServiceType AS 'Service type',
	Users.FirstName AS 'Buyers name',
	Users.LastName AS 'Buyers last name',
	Users.Email AS 'Buyers mail'
FROM Appointments
LEFT JOIN RoomAppointments ON Appointments.Id = RoomAppointments.AppointmentId
LEFT JOIN Rooms ON RoomAppointments.RoomId = Rooms.Id
LEFT JOIN Buyers ON Appointments.BuyerId = Buyers.Id
LEFT JOIN Users ON Buyers.Id = Users.Id
WHERE Rooms.Id = 2
ORDER BY Appointments.StartTime, Appointments.EndTime;


-- 9) Dohvatiti sve boravke koji su bili ili pansion ili polupansion, i to samo u odreðenom hotelu
SELECT 
	StartTime AS 'Poèetak rezervacije',
	EndTime AS 'Kraj rezervacije',
	ServiceType,
	Number AS 'Broj sobe',
	Category, PricePerNight AS 'Cijena noæenja',
	[Name] AS 'Ime hotela'
FROM Appointments
LEFT JOIN RoomAppointments ON Appointments.Id = RoomAppointments.AppointmentId
LEFT JOIN Rooms ON RoomAppointments.RoomId = Rooms.Id
LEFT JOIN Hotels ON Rooms.HotelId = Hotels.Id
WHERE (Appointments.ServiceType LIKE 'Pansion' OR Appointments.ServiceType LIKE 'Polupansion')
	AND Hotels.Name LIKE 'Lero';


-- Proof of concept for task 10. => pre-update command execution
SELECT * FROM Users
INNER JOIN Employees On Users.Id = Employees.Id
WHERE Employees.[Role] LIKE 'Cistac%';

-- 10) Promovirati 2 zaposlenika sobne posluge u recepcioniste
WITH Cleaners AS
(
	SELECT Users.Id, FirstName, LastName, PersonalIdNumber, Email, DateOfBirth, [Role] 
	FROM Users
	INNER JOIN Employees On Users.Id = Employees.Id
	WHERE Employees.[Role] IN ('Cistac', 'Cistacica')
)
UPDATE Cleaners
SET [Role] = 'Recepcionist';

-- Proof of concept for task 10. => post-update command execution
SELECT * FROM Users
INNER JOIN Employees On Users.Id = Employees.Id
WHERE Employees.[Role] LIKE 'Recepcionist';