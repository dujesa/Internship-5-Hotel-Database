-- 2.POPUNJAVANJE BAZE PODATAKA
-- Predkorak
USE HotelsBooking

-- Prvi blok popunjavanja
INSERT INTO Users(FirstName, LastName, PersonalIdNumber, Email, DateOfBirth) VALUES
('Marin', 'Mariniæ', '01234567', 'mmarinic@gmail.com', '1990-01-30'),
('Luka', 'Lukiæ', '12345678', 'llukic@gmail.com', '1980-03-01'),
('Petar', 'Petroviæ', '23456789', 'ppetrovic@gmail.com', '1995-12-28'),
('Ana', 'Aniæ', '34567890', 'aanic@gmail.com', '1985-02-12'),
('Lucija', 'Luèiæ', '45678901', 'llucic@gmail.com', '1992-09-10'),
('Marina', 'Maroviæ', '56789012', 'mmarovic@gmail.com', '2000-01-04'),
('Stipe', 'Stipaè', '67890123', 'sstipac@gmail.com', '1976-03-01'),
('Antun', 'Tuniæ', '78901234', 'atunic@gmail.com', '1995-12-28'),
('Petra', 'Trapetiæ', '89012345', 'ptrapetic@gmail.com', '1985-02-02'),
('Mira', 'Miriæ', '90123456', 'mmiric@gmail.com', '1999-09-12'),
('Sara', 'Sariæ', '00001111', 'ssaric@gmail.com', '1994-03-20'),
('Vicko', 'Vickovic', '11110000', 'vvicko@gmail.com', '1966-06-03'),
('Ivo', 'Iviæ', '00002222', 'ivo@gmail.com', '2001-12-08'),
('Lu', 'Luèiæ', '22220000', 'lulucic@gmail.com', '1984-02-11'),
('Antonia', 'Tonkoviæ', '00112233', 'atonko@gmail.com', '2005-02-12'),
('Mirna', 'Mirniæ', '01012020', 'mirna@gmail.com', '1972-05-12'),
('Marijana', 'Marijanic', '1122112211', 'marijana@gmail.com', '1973-12-12'),
('Ljiljana', 'Ljiljaniæ', '99999999', 'ljiljan@gmail.com', '2000-01-01'),
('Davor', 'Davorèeviæ', '55555555', 'ddavor@gmail.com', '1966-06-02'),
('Dante', 'Alighieri', '767676767', 'dante@gmail.com', '1996-05-20')

INSERT INTO Employees(Id, [Role]) VALUES
(1, 'Èistaæ'),
(2, 'Domar'),
(3, 'Portir'),
(4, 'Kuhar'),
(5, 'Sobarica'),
(6, 'Èistaæica'),
(7, 'Èistaæ'),
(8, 'Vozaè')

INSERT INTO Guests(Id) VALUES
(9),
(10),
(11),
(12),
(13),
(15),
(16),
(17),
(18)

INSERT INTO Buyers(Id) VALUES
(1),
(9),
(14),
(16)

INSERT INTO Cities ([Name], ZipCode, Country) VALUES
('Split', '21000', 'Hrvatska'),
('Zagreb', '10000', 'Hrvatska'),
('Dubrovnik', '20000', 'Hrvatska'),
('Munchen', '80331', 'Njemaèka'),
('Lisabon', '10004', 'Portugal')

-- Drugi blok popunjavanja
INSERT INTO Hotels([Name], StreetAddress, CityId) VALUES
('FESB Hotel', 'Ruðera Boškoviæa 21', 1),
('Lero', 'Vlahe Bukovca 3', 3),
('Ganz gross hotel', 'Kurt Landauer Strasse', 4),
('Atrium', 'Mike Tripala 2', 1),
('Oboa', 'Lisboa sim 2', 5)

INSERT INTO Appointments(StartTime, EndTime, ServiceType, BuyerId) VALUES
('2020-12-21 13:00', '2020-12-28 09:00', 'Pansion', 9),
('2021-01-01 15:00', '2021-01-05 09:00', 'Pansion', 9),
('2020-12-15 12:00', '2020-12-29 07:45', 'Polupansion', 14),
('2021-01-21 13:00', '2021-01-22 09:00', 'Obièan boravak', 14),
('2019-10-11 14:00', '2020-03-12 08:00', 'Pansion', 14),
('2019-10-13 15:30', '2012-10-15 09:00', 'Obièan boravak', 16),
('2021-12-21 14:30', '2022-12-28 05:30', 'Pansion', 14),
('2022-01-01 12:30', '2022-01-05 12:30', 'Pansion', 14),
('2020-11-11 01:30', '2021-12-29 14:45', 'Polupansion', 9),
('2021-12-20 12:30', '2022-01-22 10:30', 'Obièan boravak', 14),
('2019-08-07 12:00', '2019-08-12 17:30', 'Pansion', 14)

INSERT INTO Appointments(CreatedAt, StartTime, EndTime, ServiceType, BuyerId) VALUES
('2019-01-01', '2020-12-21 13:00', '2020-12-28 09:00', 'Polupansion', 9),
('2009-01-20', '2021-01-01 15:00', '2021-01-05 09:00', 'Polupansion', 9)

INSERT INTO Discounts(PricePercentage, Used, BuyerId) VALUES
(50, 1, 9),
(25, 1, 9),
(10, 0, 9),
(99.99, 0, 14),
(50, 0, 14)

-- Treæi blok popunjavanja
INSERT INTO Rooms(Number, Capacity, Category, TvAvailable, PricePerNight, HotelId) VALUES
(1, 5, 'Trokrevetna', 1, 799.99, 2),
(2, 1, 'Jednokrevetna', 0, 100, 2),
(3, 20, 'Desetokrevetna', 1, 1000, 2),
(1, 5, 'Dvokrevetna', 1, 100, 3),
(1, 100, 'Sala', 0, 1999, 4),
(2, 3, 'Dvokrevetna', 0, 99.99, 4),
(3, 6, 'Trokrevetna', 1, 250, 4),
(101, 3, 'Dvokrevetna', 1, 1500, 5),
(111, 3, 'Dvokrevetna', 0, 500, 5)

INSERT INTO Transactions ([Time], PaidPrice, AppointmentId) VALUES
('2020-12-21 12:59', 100, 1),
('2021-01-01 15:00', 999.99, 2),
('2020-01-20 12:59', 10, 3),
('2019-10-11 11:00', 99.99, 4),
('2019-10-11 11:00', 250, 5),
('2019-10-11 01:00', 900, 8),
('2022-09-01 10:00', 1999, 9),
('2020-12-12 13:00', 5000, 10)

-- Èetvrti blok popunjavanja
INSERT INTO HotelEmployees (HotelId, EmployeeId) VALUES
(1, 1),
(2, 1),
(2, 2),
(2, 5),
(3, 6),
(3, 2),
(3, 3),
(3, 5),
(4, 5),
(5, 5),
(5, 7)

INSERT INTO RoomAppointments(RoomId, AppointmentId) VALUES
(1, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(3, 6),
(1, 7),
(4, 7),
(5, 8),
(6, 9),
(7, 10),
(3, 11),
(4, 11),
(5, 11)

INSERT INTO AppointmentGuests(AppointmentId, GuestId) VALUES
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(2, 13),
(3, 15),
(3, 16),
(3, 17),
(3, 9),
(4, 10),
(5, 11),
(6, 12),
(7, 13),
(8, 15),
(9, 16),
(10, 17),
(11, 18),
(11, 9),
(11, 10),
(11, 11),
(11, 12),
(11, 13),
(11, 15)