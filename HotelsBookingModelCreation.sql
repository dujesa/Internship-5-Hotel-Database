-- 1. IZRADA BAZE PODATAKA
-- Prvi blok skripte
CREATE DATABASE HotelsBooking

-- Drugi blok skripte
USE HotelsBooking

CREATE TABLE Users(
	Id int IDENTITY(1, 1) PRIMARY KEY,
	FirstName nvarchar(100) NOT NULL,
	LastName nvarchar(100) NOT NULL,
	PersonalIdNumber nvarchar (20) NOT NULL,
	Email nvarchar(100) NOT NULL,
	DateOfBirth datetime2 NOT NULL
);

CREATE TABLE Employees(
	Id int PRIMARY KEY REFERENCES Users(Id),
	[Role] nvarchar(20)
);

CREATE TABLE Guests(
	Id int PRIMARY KEY REFERENCES Users(Id)
);

CREATE TABLE Buyers(
	Id int PRIMARY KEY REFERENCES Users(Id)
);

CREATE TABLE Cities(
	Id int IDENTITY(1, 1) PRIMARY KEY,
	[Name] nvarchar(100) NOT NULL,
	ZipCode nvarchar(10) CHECK(ZipCode LIKE REPLICATE('[0-9]', 5)),
	Country nvarchar(100) NOT NULL
);

-- Treæi blok skripte
CREATE TABLE Hotels(
	Id int IDENTITY(1, 1) PRIMARY KEY,
	[Name] nvarchar(100) NOT NULL,
	StreetAddress nvarchar(100) NOT NULL,
	CityId int FOREIGN KEY REFERENCES Cities(Id) NOT NULL
);

CREATE TABLE Appointments(
	Id int IDENTITY(1, 1) PRIMARY KEY,
	CreatedAt datetime2 NOT NULL DEFAULT CURRENT_TIMESTAMP,
	StartTime datetime2 NOT NULL,
	EndTime datetime2 NOT NULL,
	ServiceType nvarchar(15) CHECK(ServiceType in ('Obièan boravak', 'Polupansion', 'Pansion')),
	BuyerId int FOREIGN KEY REFERENCES Buyers(Id) NOT NULL
);

CREATE TABLE Discounts(
	Id int IDENTITY(1, 1) PRIMARY KEY,
	PricePercentage decimal(5, 2) NOT NULL CHECK (PricePercentage BETWEEN 0.01 and 99.99),
	Used bit NOT NULL DEFAULT 0,
	BuyerId int FOREIGN KEY REFERENCES Buyers(Id) NOT NULL
);

--Èetvrti blok skripte
CREATE TABLE Rooms(
	Id int IDENTITY(1, 1) PRIMARY KEY,
	Number int NOT NULL CHECK(Number > 0),
	Capacity int NOT NULL CHECK(Capacity > 0),
	Category nvarchar(20),
	TvAvailable bit NOT NULL DEFAULT 0,
	PricePerNight smallmoney NOT NULL CHECK (PricePerNight >= 0),
	HotelId int FOREIGN KEY REFERENCES Hotels(Id) NOT NULL
);

CREATE TABLE Transactions(
	Id int IDENTITY(1, 1) PRIMARY KEY,
	[Time] datetime2 NOT NULL,
	PaidPrice smallmoney NOT NULL CHECK (PaidPrice >= 0),
	AppointmentId int FOREIGN KEY REFERENCES Appointments(Id) NOT NULL
);

--Peti blok skripte
CREATE TABLE HotelEmployees(
	HotelId int FOREIGN KEY REFERENCES Hotels(Id) NOT NULL,
	EmployeeId int FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	CONSTRAINT HotelEmployeesPrimaryKey PRIMARY KEY (HotelId, EmployeeId)
);

CREATE TABLE RoomAppointments(
	RoomId int FOREIGN KEY REFERENCES Rooms(Id) NOT NULL,
	AppointmentId int FOREIGN KEY REFERENCES Appointments(Id) NOT NULL,
	CONSTRAINT RoomAppointmentsPrimaryKey PRIMARY KEY (RoomId, AppointmentId)
);

CREATE TABLE AppointmentGuests(
	AppointmentId int FOREIGN KEY REFERENCES Appointments(Id) NOT NULL,
	GuestId int FOREIGN KEY REFERENCES Guests(Id) NOT NULL,
	CONSTRAINT AppointmentGuestsPrimaryKey PRIMARY KEY (AppointmentId, GuestId)
);
