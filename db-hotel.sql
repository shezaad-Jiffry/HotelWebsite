CREATE DATABASE HotelDB;

CREATE TABLE IF NOT EXISTS Hotel_Chain(
	chainname TEXT PRIMARY KEY,
	country TEXT NOT NULL,
	region TEXT NOT NULL,
	street_name TEXT NOT NULL,
	street_number INT NOT NULL,
	postal_code VARCHAR(6) NOT NULL,
	phonenumber VARCHAR(15) NOT NULL,
	email TEXT UNIQUE NOT NULL,
	number_hotels INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Hotel(
	hotel_id INT PRIMARY KEY,
	country TEXT NOT NULL,
	region TEXT  NOT NULL,
	street_name TEXT  NOT NULL,
	street_number INT  NOT NULL,
	postal_code VARCHAR(6)  NOT NULL,
	email TEXT UNIQUE NOT NULL,
	phonenumber VARCHAR(15) NOT NULL,
	rating NUMERIC(2,1),
	number_rooms INT,
	chainname TEXT,
	FOREIGN KEY (chainname) REFERENCES hotel_chain(chainname)
);

DROP TYPE IF EXISTS sceneries;
CREATE TYPE sceneries AS ENUM ('sea','mountain');

CREATE TABLE IF NOT EXISTS Room(
	room_number INT NOT NULL,
	issues TEXT[],
	scenary sceneries NOT NULL,
	extendable BOOL NOT NULL,
	price FLOAT NOT NULL,
	amenities TEXT[] NOT NULL,
	capacity INT NOT NULL,
	--foreigns
	hotel_id INT NOT NULL,
	PRIMARY KEY (room_number, hotel_id),
	FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id)
);
CREATE TABLE IF NOT EXISTS customer(
	ssn NUMERIC (9,0) PRIMARY KEY,
	registration_date DATE NOT NULL,
	first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
	country TEXT NOT NULL,
	region TEXT NOT NULL,
	street_name TEXT NOT NULL,
	street_number INT NOT NULL,
	postal_code VARCHAR(6) NOT NULL
);

CREATE TYPE job AS ENUM ('concierge', 'room service', 'bus boy', 'waiter', 'manager', 'laundry aide');

CREATE TABLE IF NOT EXISTS Employee(
	ssn NUMERIC (9,0) PRIMARY KEY,
	first_name TEXT NOT NULL,
	last_name TEXT NOT NULL,
	is_employed BOOL NOT NULL,
	job_type job NOT NULL,
	--foreign for works at
	hotel_id INT UNIQUE NOT NULL
);

ALTER TABLE Employee
	DROP CONSTRAINT IF EXISTS fk_works_at;

ALTER TABLE Employee
	ADD CONSTRAINT fk_works_at
    FOREIGN KEY (hotel_id)
	REFERENCES hotel(hotel_id);

CREATE TABLE IF NOT EXISTS Archive(
    date_booked DATE,
    room_number INT ,
    date_rented_start DATE ,
    date_rented_end DATE ,
    hotel_chain TEXT,
    employee NUMERIC (9,0),
    hotel_id INT ,
    customer NUMERIC (9,0),
    constraint pk_archive PRIMARY KEY (room_number,hotel_id,customer)
);

CREATE TABLE IF NOT EXISTS Renting(
	date_rented_start DATE NOT NULL,
	date_rented_end DATE NOT NULL,
	employee_ssn NUMERIC (9,0) NOT NULL,
	customer_ssn NUMERIC (9,0) NOT NULL,
	room_number INT NOT NULL,
	hotel_id INT NOT NULL,
    PRIMARY KEY (room_number, hotel_id,customer_ssn)
);
ALTER TABLE Renting
	DROP CONSTRAINT IF EXISTS fk_employee_ssn;

ALTER TABLE Renting
	ADD CONSTRAINT fk_employee_ssn
    FOREIGN KEY (employee_ssn)
	REFERENCES Employee(ssn);

ALTER TABLE Renting
	DROP CONSTRAINT IF EXISTS fk_customer_ssn;

ALTER TABLE Renting
	ADD CONSTRAINT fk_customer_ssn
    FOREIGN KEY (customer_ssn)
	REFERENCES customer(ssn);

ALTER TABLE Renting
	DROP CONSTRAINT IF EXISTS fk_room_number;

ALTER TABLE Renting
	ADD CONSTRAINT fk_room_number
    FOREIGN KEY (room_number, hotel_id)
	REFERENCES room(room_number, hotel_id);

CREATE TABLE IF NOT EXISTS Booking(
	date_booked DATE NOT NULL,
	renting_start DATE NOT NULL,
	renting_end DATE NOT NULL,
	customer_ssn NUMERIC (9,0) NOT NULL,
	room_number INT NOT NULL,
	hotel_id INT NOT NULL,
    PRIMARY KEY (room_number, hotel_id,customer_ssn)
);

ALTER TABLE Booking
	DROP CONSTRAINT IF EXISTS fk_customer_ssn;

ALTER TABLE Booking
	ADD CONSTRAINT fk_customer_ssn
    FOREIGN KEY (customer_ssn)
	REFERENCES customer(ssn);

ALTER TABLE Booking
	DROP CONSTRAINT IF EXISTS fk_room_number;

ALTER TABLE Booking
	ADD CONSTRAINT fk_room_number
    FOREIGN KEY (room_number, hotel_id)
	REFERENCES room(room_number, hotel_id);

    --Hotel_Chain Inserts--------------------------------------------------------------

    INSERT INTO Hotel_Chain (chainname, country, region, street_name, street_number, postal_code, phonenumber, email, number_hotels)
    VALUES
    ('Hotel Chain A', 'Canada', 'Ontario', 'King Street', 123, 'M5V1G9', '1-416-123-4567', 'info@hotelchaina.com', 8),
    ('Hotel Chain B', 'USA', 'California', 'Sunset Boulevard', 456, '90210', '1-310-555-1234', 'info@hotelchainb.com', 8),
    ('Hotel Chain C', 'Mexico', 'Jalisco', 'Avenida de las Rosas', 789, '44110', '52-33-1235-4567', 'info@hotelchainc.com', 8),
    ('Hotel Chain D', 'Canada', 'Quebec', 'Sainte-Catherine Street', 101, 'H3B1A3', '1-514-555-6789', 'info@hotelchaind.com', 8),
    ('Hotel Chain E', 'USA', 'New York', 'Fifth Avenue', 789, '10019', '1-212-555-4321', 'info@hotelchaine.com', 8)
    on conflict do nothing;


    --Hotel Inserts---------------------------------------------------------------------


    INSERT INTO Hotel_Chain (chainname, country, region, street_name, street_number, postal_code, phonenumber, email, number_hotels)
    VALUES
    ('Hotel Chain A', 'Canada', 'Ontario', 'King Street', 123, 'M5V1G9', '1-416-123-4567', 'info@hotelchaina.com', 8)
    ON CONFLICT DO NOTHING;


    INSERT INTO Hotel (hotel_id, country, region, street_name, street_number, postal_code, email, phonenumber, rating, number_rooms, chainname)
    VALUES
    (1, 'Canada', 'Ontario', 'Yonge Street', 234, 'M5B1N4', 'hotel1@hotelchaina.com', '1-416-123-4567', 7.5, 5, 'Hotel Chain A'),
    (2, 'Canada', 'Ontario', 'Queen Street', 345, 'M5H2M5', 'hotel2@hotelchaina.com', '1-416-234-5678', 6.2, 5, 'Hotel Chain A'),
    (3, 'Canada', 'Ontario', 'Bloor Street', 456, 'M5S1X9', 'hotel3@hotelchaina.com', '1-416-345-6789', 8.3, 5, 'Hotel Chain A'),
    (4, 'Canada', 'Quebec', 'Rue Sainte-Catherine', 567, 'H2L2E5', 'hotel4@hotelchaina.com', '1-514-456-7890', 5, 160, 'Hotel Chain A'),
    (5, 'USA', 'California', 'Sunset Boulevard', 678, '90028', 'hotel5@hotelchaina.com', '1-323-567-8901', 8.1, 5, 'Hotel Chain A'),
    (6, 'USA', 'California', 'Beverly Hills', 789, '90210', 'hotel6@hotelchaina.com', '1-310-678-9012', 9.0, 5, 'Hotel Chain A'),
    (7, 'Mexico', 'Jalisco', 'Avenida de las Rosas', 890, '44110', 'hotel7@hotelchaina.com', '52-33-1234-5678', 7.2, 5, 'Hotel Chain A'),
    (8, 'Mexico', 'Jalisco', 'Avenida Vallarta', 901, '44140', 'hotel8@hotelchaina.com', '52-33-2345-6789', 5.8, 5, 'Hotel Chain A')
    ON CONFLICT DO NOTHING;


    INSERT INTO Hotel_Chain (chainname, country, region, street_name, street_number, postal_code, phonenumber, email, number_hotels)
    VALUES
    ('Hotel Chain B', 'USA', 'California', 'Sunset Boulevard', 456, '90210', '1-310-555-1234', 'info@hotelchainb.com', 8)
    ON CONFLICT DO NOTHING;



    INSERT INTO Hotel (hotel_id, country, region, street_name, street_number, postal_code, email, phonenumber, rating, number_rooms, chainname)
    VALUES
    (9, 'USA', 'New York', 'Park Avenue', 234, '10022', 'hotel9@hotelchainb.com', '1-212-555-1234', 8.7, 5, 'Hotel Chain B'),
    (10, 'USA', 'California', 'Rodeo Drive', 345, '90210', 'hotel10@hotelchainb.com', '1-310-555-5678', 6.9, 5, 'Hotel Chain B'),
    (11, 'Canada', 'Quebec', 'Rue Sainte-Catherine', 456, 'H2L2E5', 'hotel11@hotelchainb.com', '1-514-555-6789', 7.8, 5, 'Hotel Chain B'),
    (12, 'Mexico', 'Quintana Roo', 'Avenida Tulum', 567, '77500', 'hotel12@hotelchainb.com', '52-984-555-2345', 9.2, 5, 'Hotel Chain B'),
    (13, 'USA', 'Florida', 'Collins Avenue', 678, '33139', 'hotel13@hotelchainb.com', '1-305-555-3456', 7.2, 5, 'Hotel Chain B'),
    (14, 'USA', 'Hawaii', 'Waikiki Beach', 789, '96815', 'hotel14@hotelchainb.com', '1-808-555-7890', 8.1, 5, 'Hotel Chain B'),
    (15, 'Mexico', 'Quintana Roo', 'Avenida Kukulcan', 890, '77500', 'hotel15@hotelchainb.com', '52-998-555-4567', 6.5, 5, 'Hotel Chain B'),
    (16, 'Canada', 'Alberta', 'Banff Avenue', 901, 'T1L1C8', 'hotel16@hotelchainb.com', '1-403-555-8901', 7.4, 5, 'Hotel Chain B')
    ON CONFLICT DO NOTHING;


    INSERT INTO Hotel_Chain (chainname, country, region, street_name, street_number, postal_code, phonenumber, email, number_hotels)
    VALUES
    ('Hotel Chain C', 'Mexico', 'Jalisco', 'Avenida de las Rosas', 789, '44110', '52-33-1235-4567', 'info@hotelchainc.com', 8)
    ON CONFLICT DO NOTHING;


    INSERT INTO Hotel (hotel_id, country, region, street_name, street_number, postal_code, email, phonenumber, rating, number_rooms, chainname)
    VALUES
    (17, 'USA', 'California', 'Beverly Hills', 567, '90210', 'hotel17@hotelchainc.com', '1-555-123-4567', 8.5, 5, 'Hotel Chain C'),
    (18, 'Canada', 'Ontario', 'Yonge Street', 678, 'M5B1S6', 'hotel18@hotelchainc.com', '1-555-234-5678', 7.3, 5, 'Hotel Chain C'),
    (19, 'USA', 'Florida', 'Ocean Drive', 789, '33139', 'hotel19@hotelchainc.com', '1-555-345-6789', 8.9, 5, 'Hotel Chain C'),
    (20, 'USA', 'Nevada', 'Las Vegas Boulevard', 890, '89109', 'hotel20@hotelchainc.com', '1-555-456-7890', 9.1, 5, 'Hotel Chain C'),
    (21, 'Mexico', 'Quintana Roo', 'Avenida Tulum', 901, '77500', 'hotel21@hotelchainc.com', '52-555-678-1234', 6.8, 5, 'Hotel Chain C'),
    (22, 'USA', 'California', 'Rodeo Drive', 123, '90210', 'hotel22@hotelchainc.com', '1-555-567-8901', 7.7, 5, 'Hotel Chain C'),
    (23, 'Canada', 'British Columbia', 'Granville Street', 234, 'V6B2G7', 'hotel23@hotelchainc.com', '1-555-678-9012', 7.1, 5, 'Hotel Chain C'),
    (24, 'Mexico', 'Baja California Sur', 'Playa El Medano', 345, '23410', 'hotel24@hotelchainc.com', '52-555-789-0123', 8.3, 5, 'Hotel Chain C')
    ON CONFLICT DO NOTHING;



    INSERT INTO Hotel_Chain (chainname, country, region, street_name, street_number, postal_code, phonenumber, email, number_hotels)
    VALUES
    ('Hotel Chain D', 'Canada', 'Quebec', 'Sainte-Catherine Street', 101, 'H3B1A3', '1-514-555-6789', 'info@hotelchaind.com', 8)
    ON CONFLICT DO NOTHING;


    INSERT INTO Hotel (hotel_id, country, region, street_name, street_number, postal_code, email, phonenumber, rating, number_rooms, chainname)
    VALUES
    (25, 'USA', 'New York', '5th Avenue', 5678, '10022', 'hotel25@hotelchaind.com', '1-212-555-1234', 8.8, 5, 'Hotel Chain D'),
    (26, 'Canada', 'Quebec', 'Rue Sainte-Catherine', 6789, 'H2L2G8', 'hotel26@hotelchaind.com', '1-514-555-1234', 7.6, 5, 'Hotel Chain D'),
    (27, 'USA', 'California', 'Pacific Coast Highway', 7890, '90265', 'hotel27@hotelchaind.com', '1-310-555-1234', 9.2, 5, 'Hotel Chain D'),
    (28, 'USA', 'New York', '8th Avenue', 5690, '75201', 'hotel28@hotelchaind.com', '1-212-555-1234', 7.9, 5, 'Hotel Chain D'),
    (29, 'Mexico', 'Jalisco', 'Avenida Vallarta', 3456, '45040', 'hotel29@hotelchaind.com', '52-33-555-1234', 6.9, 5, 'Hotel Chain D'),
    (30, 'USA', 'Hawaii', 'Waikiki Beach Walk', 7891, '96815', 'hotel30@hotelchaind.com', '1-808-555-1234', 8.5, 5, 'Hotel Chain D'),
    (31, 'Canada', 'Alberta', 'Banff Avenue', 2345, 'T1L1C3', 'hotel31@hotelchaind.com', '1-403-555-1234', 7.2, 5, 'Hotel Chain D'),
    (32, 'Mexico', 'Quintana Roo', 'Cancun Hotel Zone', 4567, '77500', 'hotel32@hotelchaind.com', '52-998-555-1234', 8.0, 5, 'Hotel Chain D')
    ON CONFLICT DO NOTHING;




    INSERT INTO Hotel_Chain (chainname, country, region, street_name, street_number, postal_code, phonenumber, email, number_hotels)
    VALUES ('Hotel Chain E', 'USA', 'New York', 'Fifth Avenue', 789, '10019', '1-212-555-4321', 'info@hotelchaine.com', 8)
    ON CONFLICT DO NOTHING;


    INSERT INTO Hotel (hotel_id, country, region, street_name, street_number, postal_code, email, phonenumber, rating, number_rooms, chainname)
    VALUES
    (33, 'USA', 'Florida', 'Ocean Drive', 5678, '33139', 'hotel33@hotelchaine.com', '1-568-543-9980', 8.3, 5, 'Hotel Chain E'),
    (34, 'USA', 'California', 'Sunset Boulevard', 1234, '90069', 'hotel34@hotelchaine.com', '1-543-876-3456', 9.1, 5, 'Hotel Chain E'),
    (35, 'Canada', 'British Columbia', 'Robson Street', 6789, 'V6E1C5', 'hotel35@hotelchaine.com', '1-453-376-0009', 7.6, 5, 'Hotel Chain E'),
    (36, 'USA', 'Nevada', 'Las Vegas Boulevard', 9012, '89109', 'hotel36@hotelchaine.com', '1-547-345-6723', 8.9, 5, 'Hotel Chain E'),
    (37, 'Mexico', 'Baja California Sur', 'Medano Beach', 3456, '23410', 'hotel37@hotelchaine.com', '52-34-3324-7435', 7.4, 5, 'Hotel Chain E'),
    (38, 'USA', 'Illinois', 'North Michigan Avenue', 7890, '60611', 'hotel38@hotelchaine.com', '1-453-386-8465', 8.0, 5, 'Hotel Chain E'),
    (39, 'Canada', 'British Comumbia', 'Yonge Street', 2345, 'M5B2H1', 'hotel39@hotelchaine.com', '1-642-998-7638', 7.2, 5, 'Hotel Chain E'),
    (40, 'Mexico', 'Quintana Roo', 'Playa del Carmen', 4567, '77710', 'hotel40@hotelchaine.com', '52-74-6638-3397', 8.5, 5, 'Hotel Chain E')
    ON CONFLICT DO NOTHING;


    --ROOM INERSTS----------------------------------------------------

    INSERT INTO Room (room_number, issues, scenary, extendable, price, amenities, capacity, hotel_id) VALUES
    (101, ARRAY['TV not working', 'No hot water'], 'sea', true, 120.00, ARRAY['wifi', 'mini bar'], 2, 1),
    (102, ARRAY['Broken shower head'], 'mountain', false, 80.00, ARRAY['wifi'], 1, 1),
    (103, ARRAY['Dirty sheets'], 'sea', false, 90.00, ARRAY['wifi', 'mini bar'], 3, 1),
    (104, ARRAY['Broken AC'], 'mountain', true, 110.00, ARRAY['wifi', 'mini bar'], 4, 1),
    (105, ARRAY[]::varchar(100)[], 'sea', true, 100.00, ARRAY['wifi'], 2, 1)
    on conflict do nothing;

    INSERT INTO Room (room_number, issues, scenary, extendable, price, amenities, capacity, hotel_id)
    VALUES
    (101, ARRAY['TV not working', 'AC malfunctioning'], 'sea', TRUE, 120.50, ARRAY['WiFi', 'mini-bar'], 2, 2),
    (102, ARRAY['Dirty bathroom', 'broken mirror'], 'mountain', FALSE, 85.00, ARRAY['WiFi', 'hair dryer'], 5, 2),
    (103, ARRAY['Smelly carpet', 'stained curtains'], 'sea', TRUE, 150.00, ARRAY['WiFi', 'room service'], 3, 2),
    (104, ARRAY['Noisy neighbors', 'old furniture'], 'mountain', FALSE, 95.50, ARRAY['WiFi', 'coffee machine'], 1, 2),
    (105, ARRAY['Leaking faucet', 'clogged sink'], 'sea', TRUE, 180.00, ARRAY['WiFi', 'balcony'], 4, 2)
    ON CONFLICT DO NOTHING;

    INSERT INTO Room(room_number, issues, scenary, extendable, price, amenities, capacity, hotel_id)
    VALUES
    (101, ARRAY['Broken light bulb', 'Leaking faucet'], 'sea', TRUE, 180.50, ARRAY['WiFi', 'TV', 'Air conditioning'], 1, 3),
    (102, ARRAY['Cracked mirror', 'Noisy air conditioning'], 'mountain', TRUE, 190.00, ARRAY['WiFi', 'TV', 'Mini-fridge'], 2, 3),
    (103, ARRAY['Stained carpet'], 'sea', FALSE, 120.00, ARRAY['WiFi', 'TV', 'Iron'], 3, 3),
    (104, ARRAY['Clogged toilet'], 'mountain', TRUE, 200.00, ARRAY['WiFi', 'TV', 'Coffee machine'], 4, 3),
    (105, ARRAY['Broken shower head'], 'sea', FALSE, 100.50, ARRAY['WiFi', 'TV', 'Hair dryer'], 5, 3)
    on conflict do nothing;

    INSERT INTO Room (room_number, issues, scenary, extendable, price, amenities, capacity, hotel_id)
    VALUES
    (101, ARRAY['Broken Lamp', 'Clogged Sink'], 'mountain', TRUE, 150.0, ARRAY['TV', 'Wi-Fi', 'AC', 'Mini Bar'], 1, 4),
    (102, ARRAY['Noisy AC'], 'sea', TRUE, 200.0, ARRAY['TV', 'Wi-Fi', 'AC', 'Mini Bar'], 2, 4),
    (103, ARRAY['Leaky Faucet'], 'mountain', TRUE, 175.0, ARRAY['TV', 'Wi-Fi', 'AC', 'Mini Bar'], 3, 4),
    (104, ARRAY['Dirty Sheets'], 'sea', FALSE, 120.0, ARRAY['TV', 'Wi-Fi', 'AC'], 4, 4),
    (105, ARRAY[]::varchar(100)[], 'mountain', TRUE, 100.0, ARRAY['TV', 'Wi-Fi'], 5, 4)
    on conflict do nothing;


    INSERT INTO Room (room_number, issues, scenary, extendable, price, amenities, capacity, hotel_id)
    VALUES
    (101, ARRAY[]::varchar(100)[], 'sea', false, 150.50, ARRAY['wifi', 'tv', 'mini bar'], 2, 5),
    (102, ARRAY['Mold on walls'], 'mountain', true, 200.25, ARRAY['wifi', 'tv', 'mini bar'], 4, 5),
    (103, ARRAY[]::varchar(100)[], 'sea', false, 175.00, ARRAY['wifi', 'tv', 'mini bar'], 3, 5),
    (104, ARRAY['Dead lightbulb'], 'mountain', true, 225.75, ARRAY['wifi', 'tv', 'mini bar'], 5, 5),
    (105, ARRAY['Chair Leg Broken'], 'sea', false, 200.00, ARRAY['wifi', 'tv', 'mini bar'], 1, 5)
    on conflict do nothing;

    INSERT INTO Room (room_number, issues, scenary, extendable, price, amenities, capacity, hotel_id)
    VALUES
    (101, ARRAY['TV not working', 'Broken lamp'], 'sea', true, 200.0, ARRAY['WiFi', 'Mini-bar'], 2, 6),
    (102, ARRAY['Noisy AC', 'Clogged drain'], 'mountain', true, 250.0, ARRAY['WiFi', 'Safe'], 4, 6),
    (103, ARRAY['Stained sheets', 'Leaky faucet'], 'sea', false, 150.0, ARRAY['Mini-bar', 'Coffee maker'], 1, 6),
    (104, ARRAY['Broken toilet seat', 'Scratched furniture'], 'mountain', true, 300.0, ARRAY['WiFi', 'Safe'], 5, 6),
    (105, ARRAY['No hot water', 'Dusty room'], 'sea', false, 180.0, ARRAY['Mini-bar', 'Coffee maker'], 3, 6)
    on conflict do nothing;

    INSERT INTO Room (room_number, issues, scenary, extendable, price, amenities, capacity, hotel_id)
    VALUES
    (101, ARRAY['Broken lamp', 'TV not working'], 'sea', true, 125.99, ARRAY['Wi-Fi', 'Air conditioning', 'Private bathroom'], 2, 7),
    (102, ARRAY['Clogged sink'], 'mountain', true, 130.50, ARRAY['Wi-Fi', 'Air conditioning', 'Private bathroom'], 3, 7),
    (103, ARRAY[]::varchar(100)[], 'sea', true, 200.00, ARRAY['Wi-Fi', 'Air conditioning', 'Private bathroom', 'Mini bar'], 4, 7),
    (104, ARRAY['Leaky faucet'], 'mountain', false, 70.00, ARRAY['Wi-Fi', 'Private bathroom'], 1, 7),
    (105, ARRAY[]::varchar(100)[], 'sea', true, 150.25, ARRAY['Wi-Fi', 'Air conditioning', 'Private bathroom', 'Mini fridge'], 5, 7)
    on conflict do nothing;

    INSERT INTO Room(room_number, issues, scenary, extendable, price, amenities, capacity, hotel_id)
    VALUES
    (101, ARRAY['TV not working'], 'sea', TRUE, 200.0, ARRAY['WiFi', 'air conditioning'], 2, 8),
    (102, ARRAY['stained sheets'], 'mountain', FALSE, 150.0, ARRAY['WiFi', 'parking'], 3, 8),
    (103, ARRAY['broken lamp'], 'sea', TRUE, 250.0, ARRAY['pool', 'gym', 'restaurant'], 4, 8),
    (104, ARRAY['clogged toilet'], 'mountain', FALSE, 180.0, ARRAY['WiFi', 'air conditioning'], 1, 8),
    (105, ARRAY['cracked mirror'], 'sea', TRUE, 300.0, ARRAY['breakfast included', 'room service'], 5, 8)
    on conflict do nothing;


    INSERT INTO Room (room_number, issues, scenary, extendable, price, amenities, capacity, hotel_id) VALUES
    (101, ARRAY['TV not working', 'No hot water'], 'sea', true, 120.00, ARRAY['wifi', 'mini bar'], 2, 1),
    (102, ARRAY['Broken shower head'], 'mountain', false, 80.00, ARRAY['wifi'], 1, 1),
    (103, ARRAY['Dirty sheets'], 'sea', false, 90.00, ARRAY['wifi', 'mini bar'], 3, 1),
    (104, ARRAY['Broken AC'], 'mountain', true, 110.00, ARRAY['wifi', 'mini bar'], 4, 1),
    (105, ARRAY[]::varchar(100)[], 'sea', true, 100.00, ARRAY['wifi'], 2, 1),
    (101, ARRAY['TV not working', 'AC malfunctioning'], 'sea', TRUE, 120.50, ARRAY['WiFi', 'mini-bar'], 2, 2),
    (102, ARRAY['Dirty bathroom', 'broken mirror'], 'mountain', FALSE, 85.00, ARRAY['WiFi', 'hair dryer'], 5, 2),
    (103, ARRAY['Smelly carpet', 'stained curtains'], 'sea', TRUE, 150.00, ARRAY['WiFi', 'room service'], 3, 2),
    (104, ARRAY['Noisy neighbors', 'old furniture'], 'mountain', FALSE, 95.50, ARRAY['WiFi', 'coffee machine'], 1, 2),
    (105, ARRAY['Leaking faucet', 'clogged sink'], 'sea', TRUE, 180.00, ARRAY['WiFi', 'balcony'], 4, 2),
    (101, ARRAY['Broken light bulb', 'Leaking faucet'], 'sea', TRUE, 180.50, ARRAY['WiFi', 'TV', 'Air conditioning'], 1, 3),
    (102, ARRAY['Cracked mirror', 'Noisy air conditioning'], 'mountain', TRUE, 190.00, ARRAY['WiFi', 'TV', 'Mini-fridge'], 2, 3),
    (103, ARRAY['Stained carpet'], 'sea', FALSE, 120.00, ARRAY['WiFi', 'TV', 'Iron'], 3, 3),
    (104, ARRAY['Clogged toilet'], 'mountain', TRUE, 200.00, ARRAY['WiFi', 'TV', 'Coffee machine'], 4, 3),
    (105, ARRAY['Broken shower head'], 'sea', FALSE, 100.50, ARRAY['WiFi', 'TV', 'Hair dryer'], 5, 3),
    (101, ARRAY['Broken Lamp', 'Clogged Sink'], 'mountain', TRUE, 150.0, ARRAY['TV', 'Wi-Fi', 'AC', 'Mini Bar'], 1, 4),
    (102, ARRAY['Noisy AC'], 'sea', TRUE, 200.0, ARRAY['TV', 'Wi-Fi', 'AC', 'Mini Bar'], 2, 4),
    (103, ARRAY['Leaky Faucet'], 'mountain', TRUE, 175.0, ARRAY['TV', 'Wi-Fi', 'AC', 'Mini Bar'], 3, 4),
    (104, ARRAY['Dirty Sheets'], 'sea', FALSE, 120.0, ARRAY['TV', 'Wi-Fi', 'AC'], 4, 4),
    (105, ARRAY[]::varchar(100)[], 'mountain', TRUE, 100.0, ARRAY['TV', 'Wi-Fi'], 5, 4),
    (101, ARRAY[]::varchar(100)[], 'sea', false, 150.50, ARRAY['wifi', 'tv', 'mini bar'], 2, 5),
    (102, ARRAY['Mold on walls'], 'mountain', true, 200.25, ARRAY['wifi', 'tv', 'mini bar'], 4, 5),
    (103, ARRAY[]::varchar(100)[], 'sea', false, 175.00, ARRAY['wifi', 'tv', 'mini bar'], 3, 5),
    (104, ARRAY['Dead lightbulb'], 'mountain', true, 225.75, ARRAY['wifi', 'tv', 'mini bar'], 5, 5),
    (105, ARRAY['Chair Leg Broken'], 'sea', false, 200.00, ARRAY['wifi', 'tv', 'mini bar'], 1, 5),
    (101, ARRAY['TV not working', 'Broken lamp'], 'sea', true, 200.0, ARRAY['WiFi', 'Mini-bar'], 2, 6),
    (102, ARRAY['Noisy AC', 'Clogged drain'], 'mountain', true, 250.0, ARRAY['WiFi', 'Safe'], 4, 6),
    (103, ARRAY['Stained sheets', 'Leaky faucet'], 'sea', false, 150.0, ARRAY['Mini-bar', 'Coffee maker'], 1, 6),
    (104, ARRAY['Broken toilet seat', 'Scratched furniture'], 'mountain', true, 300.0, ARRAY['WiFi', 'Safe'], 5, 6),
    (105, ARRAY['No hot water', 'Dusty room'], 'sea', false, 180.0, ARRAY['Mini-bar', 'Coffee maker'], 3, 6),
    (101, ARRAY['Broken lamp', 'TV not working'], 'sea', true, 125.99, ARRAY['Wi-Fi', 'Air conditioning', 'Private bathroom'], 2, 7),
    (102, ARRAY['Clogged sink'], 'mountain', true, 130.50, ARRAY['Wi-Fi', 'Air conditioning', 'Private bathroom'], 3, 7),
    (103, ARRAY[]::varchar(100)[], 'sea', true, 200.00, ARRAY['Wi-Fi', 'Air conditioning', 'Private bathroom', 'Mini bar'], 4, 7),
    (104, ARRAY['Leaky faucet'], 'mountain', false, 70.00, ARRAY['Wi-Fi', 'Private bathroom'], 1, 7),
    (105, ARRAY[]::varchar(100)[], 'sea', true, 150.25, ARRAY['Wi-Fi', 'Air conditioning', 'Private bathroom', 'Mini fridge'], 5, 7),
    (101, ARRAY['TV not working'], 'sea', TRUE, 200.0, ARRAY['WiFi', 'air conditioning'], 2, 8),
    (102, ARRAY['stained sheets'], 'mountain', FALSE, 150.0, ARRAY['WiFi', 'parking'], 3, 8),
    (103, ARRAY['broken lamp'], 'sea', TRUE, 250.0, ARRAY['pool', 'gym', 'restaurant'], 4, 8),
    (104, ARRAY['clogged toilet'], 'mountain', FALSE, 180.0, ARRAY['WiFi', 'air conditioning'], 1, 8),
    (105, ARRAY['cracked mirror'], 'sea', TRUE, 300.0, ARRAY['breakfast included', 'room service'], 5, 8),
    (100,ARRAY['Air conditioning not working'], 'sea', 'False', 165.00,ARRAY['wifi','Parking'], 1, 9),
    (101,ARRAY['TV not working'], 'mountain', 'False', 175.00,ARRAY['wifi',''], 2, 9),
    (102,ARRAY['Clogged sink'], 'sea', 'False', 150.00,ARRAY['wifi',''], 3, 9),
    (103,ARRAY['Air conditioning not working'], 'sea', 'False', 150.00,ARRAY['wifi',''], 4, 9),
    (104,ARRAY['Moldy Walls'], 'mountain', 'True', 165.00,ARRAY['wifi','Parking'], 5, 9),
    (105,ARRAY['Moldy Walls'], 'mountain', 'True', 175.00,ARRAY['wifi',''], 6, 9),
    (100,ARRAY['Air conditioning not working'], 'mountain', 'True', 100.00,ARRAY['wifi','AC'], 1, 10),
    (101,ARRAY['Broken lamp'], 'mountain', 'False', 100.00,ARRAY['wifi','Safe'], 2, 10),
    (102,ARRAY['TV not working'], 'mountain', 'True', 150.00,ARRAY['wifi','tv'], 3, 10),
    (103,ARRAY['Air conditioning not working'], 'mountain', 'False', 200.00,ARRAY['wifi',''], 4, 10),
    (104,ARRAY['Broken lamp'], 'mountain', 'True', 200.00,ARRAY['wifi','tv'], 5, 10),
    (105,ARRAY['Moldy Walls'], 'mountain', 'True', 175.00,ARRAY['wifi','Safe'], 6, 10),
    (100,ARRAY['Moldy Walls'], 'sea', 'False', 165.00,ARRAY['wifi','Parking'], 1, 11),
    (101,ARRAY['TV not working'], 'sea', 'False', 165.00,ARRAY['wifi','Parking'], 2, 11),
    (102,ARRAY['Broken lamp'], 'mountain', 'False', 150.00,ARRAY['wifi','AC'], 3, 11),
    (103,ARRAY['Broken lamp'], 'mountain', 'True', 175.00,ARRAY['wifi','tv'], 4, 11),
    (104,ARRAY['Moldy Walls'], 'sea', 'True', 165.00,ARRAY['wifi',''], 5, 11),
    (105,ARRAY['Broken lamp'], 'sea', 'True', 175.00,ARRAY['wifi','Parking'], 6, 11),
    (100,ARRAY['Air conditioning not working'], 'mountain', 'False', 150.00,ARRAY['wifi',''], 1, 12),
    (101,ARRAY['Air conditioning not working'], 'mountain', 'True', 100.00,ARRAY['wifi','mini bar'], 2, 12),
    (102,ARRAY['Air conditioning not working'], 'sea', 'False', 100.00,ARRAY['wifi','Safe'], 3, 12),
    (103,ARRAY['Clogged sink'], 'sea', 'False', 200.00,ARRAY['wifi','mini bar'], 4, 12),
    (104,ARRAY['Air conditioning not working'], 'sea', 'False', 200.00,ARRAY['wifi','tv'], 5, 12),
    (105,ARRAY['TV not working'], 'sea', 'False', 175.00,ARRAY['wifi','Parking'], 6, 12),
    (100,ARRAY['Clogged sink'], 'mountain', 'False', 150.00,ARRAY['wifi','Parking'], 1, 13),
    (101,ARRAY['Clogged sink'], 'sea', 'True', 200.00,ARRAY['wifi','tv'], 2, 13),
    (102,ARRAY['TV not working'], 'sea', 'False', 100.00,ARRAY['wifi','tv'], 3, 13),
    (103,ARRAY['Moldy Walls'], 'mountain', 'False', 150.00,ARRAY['wifi','tv'], 4, 13),
    (104,ARRAY['Broken lamp'], 'mountain', 'False', 165.00,ARRAY['wifi',''], 5, 13),
    (105,ARRAY['Moldy Walls'], 'mountain', 'True', 200.00,ARRAY['wifi','Parking'], 6, 13),
    (100,ARRAY['Moldy Walls'], 'mountain', 'False', 100.00,ARRAY['wifi','AC'], 1, 14),
    (101,ARRAY['Air conditioning not working'], 'sea', 'False', 100.00,ARRAY['wifi','tv'], 2, 14),
    (102,ARRAY['Air conditioning not working'], 'mountain', 'True', 200.00,ARRAY['wifi',''], 3, 14),
    (103,ARRAY['Clogged sink'], 'mountain', 'True', 150.00,ARRAY['wifi','AC'], 4, 14),
    (104,ARRAY['Clogged sink'], 'sea', 'True', 100.00,ARRAY['wifi','mini bar'], 5, 14),
    (105,ARRAY['Air conditioning not working'], 'mountain', 'False', 175.00,ARRAY['wifi','Parking'], 6, 14),
    (100,ARRAY['Clogged sink'], 'mountain', 'True', 100.00,ARRAY['wifi','AC'], 1, 15),
    (101,ARRAY['Air conditioning not working'], 'sea', 'True', 100.00,ARRAY['wifi',''], 2, 15),
    (102,ARRAY['Clogged sink'], 'sea', 'False', 100.00,ARRAY['wifi','Safe'], 3, 15),
    (103,ARRAY['Broken lamp'], 'mountain', 'False', 165.00,ARRAY['wifi','mini bar'], 4, 15),
    (104,ARRAY['TV not working'], 'sea', 'False', 100.00,ARRAY['wifi',''], 5, 15),
    (105,ARRAY['Moldy Walls'], 'mountain', 'True', 150.00,ARRAY['wifi','Parking'], 6, 15),
    (100,ARRAY['Broken lamp'], 'mountain', 'True', 200.00,ARRAY['wifi','AC'], 1, 16),
    (101,ARRAY['TV not working'], 'sea', 'False', 200.00,ARRAY['wifi','Parking'], 2, 16),
    (102,ARRAY['Air conditioning not working'], 'sea', 'False', 175.00,ARRAY['wifi','Safe'], 3, 16),
    (103,ARRAY['Clogged sink'], 'mountain', 'True', 100.00,ARRAY['wifi','Safe'], 4, 16),
    (104,ARRAY['Broken lamp'], 'sea', 'False', 200.00,ARRAY['wifi','mini bar'], 5, 16),
    (105,ARRAY['Air conditioning not working'], 'sea', 'True', 175.00,ARRAY['wifi','Parking'], 6, 16),
    (100,ARRAY['Broken lamp'], 'sea', 'False', 175.00,ARRAY['wifi',''], 1, 17),
    (101,ARRAY['Moldy Walls'], 'sea', 'False', 150.00,ARRAY['wifi','tv'], 2, 17),
    (102,ARRAY['Moldy Walls'], 'sea', 'False', 100.00,ARRAY['wifi','tv'], 3, 17),
    (103,ARRAY['Moldy Walls'], 'sea', 'False', 150.00,ARRAY['wifi',''], 4, 17),
    (104,ARRAY['TV not working'], 'mountain', 'False', 175.00,ARRAY['wifi','tv'], 5, 17),
    (105,ARRAY['Air conditioning not working'], 'mountain', 'False', 150.00,ARRAY['wifi',''], 6, 17),
    (100,ARRAY['Air conditioning not working'], 'sea', 'False', 175.00,ARRAY['wifi','tv'], 1, 18),
    (101,ARRAY['Air conditioning not working'], 'sea', 'True', 175.00,ARRAY['wifi','Safe'], 2, 18),
    (102,ARRAY['Broken lamp'], 'sea', 'False', 150.00,ARRAY['wifi','AC'], 3, 18),
    (103,ARRAY['TV not working'], 'mountain', 'False', 150.00,ARRAY['wifi',''], 4, 18),
    (104,ARRAY['Air conditioning not working'], 'mountain', 'False', 165.00,ARRAY['wifi','AC'], 5, 18),
    (105,ARRAY['Air conditioning not working'], 'mountain', 'False', 175.00,ARRAY['wifi','tv'], 6, 18),
    (100,ARRAY['Moldy Walls'], 'sea', 'False', 200.00,ARRAY['wifi','AC'], 1, 19),
    (101,ARRAY['Moldy Walls'], 'mountain', 'True', 165.00,ARRAY['wifi','tv'], 2, 19),
    (102,ARRAY['Moldy Walls'], 'sea', 'False', 165.00,ARRAY['wifi','mini bar'], 3, 19),
    (103,ARRAY['Air conditioning not working'], 'sea', 'True', 200.00,ARRAY['wifi','tv'], 4, 19),
    (104,ARRAY['TV not working'], 'sea', 'True', 100.00,ARRAY['wifi','AC'], 5, 19),
    (105,ARRAY['TV not working'], 'sea', 'False', 165.00,ARRAY['wifi','mini bar'], 6, 19),
    (100,ARRAY['Clogged sink'], 'sea', 'True', 100.00,ARRAY['wifi',''], 1, 20),
    (101,ARRAY['TV not working'], 'sea', 'False', 165.00,ARRAY['wifi','tv'], 2, 20),
    (102,ARRAY['Clogged sink'], 'sea', 'True', 165.00,ARRAY['wifi','AC'], 3, 20),
    (103,ARRAY['Air conditioning not working'], 'sea', 'False', 100.00,ARRAY['wifi','Safe'], 4, 20),
    (104,ARRAY['Broken lamp'], 'sea', 'False', 150.00,ARRAY['wifi','Parking'], 5, 20),
    (105,ARRAY['Clogged sink'], 'mountain', 'True', 100.00,ARRAY['wifi',''], 6, 20),
    (100,ARRAY['Moldy Walls'], 'mountain', 'False', 165.00,ARRAY['wifi','AC'], 1, 21),
    (101,ARRAY['Clogged sink'], 'sea', 'False', 200.00,ARRAY['wifi','Parking'], 2, 21),
    (102,ARRAY['Moldy Walls'], 'sea', 'True', 165.00,ARRAY['wifi','Parking'], 3, 21),
    (103,ARRAY['Broken lamp'], 'sea', 'False', 100.00,ARRAY['wifi','Safe'], 4, 21),
    (104,ARRAY['Clogged sink'], 'mountain', 'False', 100.00,ARRAY['wifi','AC'], 5, 21),
    (105,ARRAY['Broken lamp'], 'sea', 'False', 100.00,ARRAY['wifi','AC'], 6, 21),
    (100,ARRAY['Clogged sink'], 'mountain', 'False', 165.00,ARRAY['wifi','Safe'], 1, 22),
    (101,ARRAY['Moldy Walls'], 'mountain', 'False', 165.00,ARRAY['wifi','Safe'], 2, 22),
    (102,ARRAY['Broken lamp'], 'mountain', 'False', 100.00,ARRAY['wifi','Parking'], 3, 22),
    (103,ARRAY['Moldy Walls'], 'sea', 'True', 100.00,ARRAY['wifi','mini bar'], 4, 22),
    (104,ARRAY['Air conditioning not working'], 'sea', 'True', 175.00,ARRAY['wifi','Parking'], 5, 22),
    (105,ARRAY['Broken lamp'], 'sea', 'False', 100.00,ARRAY['wifi','Parking'], 6, 22),
    (100,ARRAY['Broken lamp'], 'mountain', 'False', 200.00,ARRAY['wifi','tv'], 1, 23),
    (101,ARRAY['Air conditioning not working'], 'sea', 'True', 200.00,ARRAY['wifi',''], 2, 23),
    (102,ARRAY['Clogged sink'], 'mountain', 'True', 200.00,ARRAY['wifi','Safe'], 3, 23),
    (103,ARRAY['Broken lamp'], 'sea', 'True', 100.00,ARRAY['wifi','AC'], 4, 23),
    (104,ARRAY['Broken lamp'], 'mountain', 'False', 200.00,ARRAY['wifi','AC'], 5, 23),
    (105,ARRAY['Moldy Walls'], 'mountain', 'True', 100.00,ARRAY['wifi','tv'], 6, 23),
    (100,ARRAY['Moldy Walls'], 'mountain', 'False', 150.00,ARRAY['wifi','Safe'], 1, 24),
    (101,ARRAY['Broken lamp'], 'mountain', 'False', 200.00,ARRAY['wifi','AC'], 2, 24),
    (102,ARRAY['Air conditioning not working'], 'sea', 'False', 175.00,ARRAY['wifi','Safe'], 3, 24),
    (103,ARRAY['Air conditioning not working'], 'sea', 'True', 200.00,ARRAY['wifi','Safe'], 4, 24),
    (104,ARRAY['TV not working'], 'sea', 'False', 200.00,ARRAY['wifi','Safe'], 5, 24),
    (105,ARRAY['Clogged sink'], 'mountain', 'False', 150.00,ARRAY['wifi',''], 6, 24),
    (100,ARRAY['TV not working'], 'mountain', 'False', 200.00,ARRAY['wifi','mini bar'], 1, 25),
    (101,ARRAY['Air conditioning not working'], 'mountain', 'True', 100.00,ARRAY['wifi','Safe'], 2, 25),
    (102,ARRAY['Clogged sink'], 'sea', 'False', 200.00,ARRAY['wifi','mini bar'], 3, 25),
    (103,ARRAY['Air conditioning not working'], 'mountain', 'True', 100.00,ARRAY['wifi','AC'], 4, 25),
    (104,ARRAY['Broken lamp'], 'sea', 'True', 175.00,ARRAY['wifi','Safe'], 5, 25),
    (105,ARRAY['Moldy Walls'], 'mountain', 'False', 150.00,ARRAY['wifi','mini bar'], 6, 25),
    (100,ARRAY['Broken lamp'], 'sea', 'False', 200.00,ARRAY['wifi',''], 1, 26),
    (101,ARRAY['TV not working'], 'sea', 'False', 165.00,ARRAY['wifi',''], 2, 26),
    (102,ARRAY['Moldy Walls'], 'mountain', 'True', 150.00,ARRAY['wifi','mini bar'], 3, 26),
    (103,ARRAY['Air conditioning not working'], 'sea', 'True', 165.00,ARRAY['wifi','mini bar'], 4, 26),
    (104,ARRAY['Air conditioning not working'], 'mountain', 'True', 100.00,ARRAY['wifi','tv'], 5, 26),
    (105,ARRAY['Clogged sink'], 'sea', 'True', 100.00,ARRAY['wifi','mini bar'], 6, 26),
    (100,ARRAY['Broken lamp'], 'sea', 'True', 165.00,ARRAY['wifi','mini bar'], 1, 27),
    (101,ARRAY['TV not working'], 'mountain', 'True', 165.00,ARRAY['wifi','tv'], 2, 27),
    (102,ARRAY['Moldy Walls'], 'mountain', 'True', 175.00,ARRAY['wifi','AC'], 3, 27),
    (103,ARRAY['Clogged sink'], 'sea', 'False', 200.00,ARRAY['wifi',''], 4, 27),
    (104,ARRAY['TV not working'], 'sea', 'False', 175.00,ARRAY['wifi','AC'], 5, 27),
    (105,ARRAY['Moldy Walls'], 'mountain', 'True', 150.00,ARRAY['wifi',''], 6, 27),
    (100,ARRAY['TV not working'], 'mountain', 'False', 200.00,ARRAY['wifi',''], 1, 28),
    (101,ARRAY['Clogged sink'], 'mountain', 'True', 175.00,ARRAY['wifi','Parking'], 2, 28),
    (102,ARRAY['Moldy Walls'], 'mountain', 'False', 175.00,ARRAY['wifi','mini bar'], 3, 28),
    (103,ARRAY['Clogged sink'], 'sea', 'True', 100.00,ARRAY['wifi','Parking'], 4, 28),
    (104,ARRAY['Broken lamp'], 'sea', 'False', 150.00,ARRAY['wifi','tv'], 5, 28),
    (105,ARRAY['Moldy Walls'], 'sea', 'True', 100.00,ARRAY['wifi','AC'], 6, 28),
    (100,ARRAY['Moldy Walls'], 'sea', 'False', 165.00,ARRAY['wifi','mini bar'], 1, 29),
    (101,ARRAY['Moldy Walls'], 'sea', 'False', 200.00,ARRAY['wifi',''], 2, 29),
    (102,ARRAY['TV not working'], 'mountain', 'True', 165.00,ARRAY['wifi','mini bar'], 3, 29),
    (103,ARRAY['Moldy Walls'], 'sea', 'True', 100.00,ARRAY['wifi','mini bar'], 4, 29),
    (104,ARRAY['Air conditioning not working'], 'mountain', 'False', 200.00,ARRAY['wifi','Parking'], 5, 29),
    (105,ARRAY['TV not working'], 'sea', 'True', 100.00,ARRAY['wifi',''], 6, 29),
    (100,ARRAY['TV not working'], 'mountain', 'False', 100.00,ARRAY['wifi','mini bar'], 1, 30),
    (101,ARRAY['Broken lamp'], 'sea', 'False', 165.00,ARRAY['wifi',''], 2, 30),
    (102,ARRAY['TV not working'], 'sea', 'True', 100.00,ARRAY['wifi',''], 3, 30),
    (103,ARRAY['Broken lamp'], 'sea', 'False', 100.00,ARRAY['wifi','Safe'], 4, 30),
    (104,ARRAY['Moldy Walls'], 'sea', 'True', 165.00,ARRAY['wifi','tv'], 5, 30),
    (105,ARRAY['Air conditioning not working'], 'sea', 'False', 175.00,ARRAY['wifi','Parking'], 6, 30),
    (100,ARRAY['Moldy Walls'], 'mountain', 'False', 150.00,ARRAY['wifi','Parking'], 1, 31),
    (101,ARRAY['Air conditioning not working'], 'sea', 'False', 100.00,ARRAY['wifi','mini bar'], 2, 31),
    (102,ARRAY['Moldy Walls'], 'mountain', 'False', 100.00,ARRAY['wifi','AC'], 3, 31),
    (103,ARRAY['Air conditioning not working'], 'sea', 'False', 200.00,ARRAY['wifi','Parking'], 4, 31),
    (104,ARRAY['Air conditioning not working'], 'mountain', 'True', 200.00,ARRAY['wifi','Parking'], 5, 31),
    (105,ARRAY['Clogged sink'], 'mountain', 'False', 200.00,ARRAY['wifi','tv'], 6, 31),
    (100,ARRAY['Air conditioning not working'], 'sea', 'False', 150.00,ARRAY['wifi',''], 1, 32),
    (101,ARRAY['Clogged sink'], 'mountain', 'False', 100.00,ARRAY['wifi','Safe'], 2, 32),
    (102,ARRAY['TV not working'], 'mountain', 'False', 175.00,ARRAY['wifi',''], 3, 32),
    (103,ARRAY['TV not working'], 'sea', 'False', 100.00,ARRAY['wifi','tv'], 4, 32),
    (104,ARRAY['TV not working'], 'sea', 'False', 100.00,ARRAY['wifi','tv'], 5, 32),
    (105,ARRAY['TV not working'], 'mountain', 'False', 100.00,ARRAY['wifi',''], 6, 32),
    (100,ARRAY['TV not working'], 'sea', 'True', 165.00,ARRAY['wifi','mini bar'], 1, 33),
    (101,ARRAY['Air conditioning not working'], 'mountain', 'False', 165.00,ARRAY['wifi','Safe'], 2, 33),
    (102,ARRAY['Air conditioning not working'], 'sea', 'False', 200.00,ARRAY['wifi','mini bar'], 3, 33),
    (103,ARRAY['Air conditioning not working'], 'mountain', 'True', 175.00,ARRAY['wifi','mini bar'], 4, 33),
    (104,ARRAY['Broken lamp'], 'mountain', 'True', 100.00,ARRAY['wifi','Parking'], 5, 33),
    (105,ARRAY['Broken lamp'], 'mountain', 'False', 165.00,ARRAY['wifi','Parking'], 6, 33),
    (100,ARRAY['Broken lamp'], 'sea', 'True', 175.00,ARRAY['wifi','AC'], 1, 34),
    (101,ARRAY['Air conditioning not working'], 'sea', 'False', 200.00,ARRAY['wifi','Parking'], 2, 34),
    (102,ARRAY['Moldy Walls'], 'sea', 'False', 200.00,ARRAY['wifi','tv'], 3, 34),
    (103,ARRAY['Clogged sink'], 'mountain', 'True', 200.00,ARRAY['wifi','tv'], 4, 34),
    (104,ARRAY['Air conditioning not working'], 'mountain', 'False', 150.00,ARRAY['wifi','tv'], 5, 34),
    (105,ARRAY['Clogged sink'], 'sea', 'False', 150.00,ARRAY['wifi','mini bar'], 6, 34),
    (100,ARRAY['TV not working'], 'sea', 'False', 100.00,ARRAY['wifi','AC'], 1, 35),
    (101,ARRAY['Moldy Walls'], 'sea', 'False', 175.00,ARRAY['wifi','tv'], 2, 35),
    (102,ARRAY['Air conditioning not working'], 'sea', 'False', 100.00,ARRAY['wifi','AC'], 3, 35),
    (103,ARRAY['Moldy Walls'], 'mountain', 'False', 150.00,ARRAY['wifi','mini bar'], 4, 35),
    (104,ARRAY['TV not working'], 'sea', 'True', 200.00,ARRAY['wifi','Safe'], 5, 35),
    (105,ARRAY['TV not working'], 'sea', 'True', 100.00,ARRAY['wifi',''], 6, 35),
    (100,ARRAY['Moldy Walls'], 'mountain', 'True', 100.00,ARRAY['wifi','tv'], 1, 36),
    (101,ARRAY['Moldy Walls'], 'mountain', 'True', 175.00,ARRAY['wifi','Safe'], 2, 36),
    (102,ARRAY['Moldy Walls'], 'mountain', 'True', 150.00,ARRAY['wifi',''], 3, 36),
    (103,ARRAY['Clogged sink'], 'mountain', 'True', 100.00,ARRAY['wifi',''], 4, 36),
    (104,ARRAY['Moldy Walls'], 'sea', 'False', 200.00,ARRAY['wifi','Parking'], 5, 36),
    (105,ARRAY['Clogged sink'], 'sea', 'False', 165.00,ARRAY['wifi','tv'], 6, 36),
    (100,ARRAY['Moldy Walls'], 'sea', 'False', 175.00,ARRAY['wifi','Safe'], 1, 37),
    (101,ARRAY['Broken lamp'], 'sea', 'True', 175.00,ARRAY['wifi','mini bar'], 2, 37),
    (102,ARRAY['Clogged sink'], 'mountain', 'False', 200.00,ARRAY['wifi',''], 3, 37),
    (103,ARRAY['Broken lamp'], 'sea', 'False', 175.00,ARRAY['wifi','Safe'], 4, 37),
    (104,ARRAY['Air conditioning not working'], 'mountain', 'True', 165.00,ARRAY['wifi',''], 5, 37),
    (105,ARRAY['TV not working'], 'sea', 'False', 100.00,ARRAY['wifi','Parking'], 6, 37),
    (100,ARRAY['TV not working'], 'sea', 'True', 200.00,ARRAY['wifi','tv'], 1, 38),
    (101,ARRAY['Broken lamp'], 'mountain', 'True', 165.00,ARRAY['wifi','tv'], 2, 38),
    (102,ARRAY['Moldy Walls'], 'sea', 'True', 175.00,ARRAY['wifi',''], 3, 38),
    (103,ARRAY['Moldy Walls'], 'sea', 'True', 165.00,ARRAY['wifi','AC'], 4, 38),
    (104,ARRAY['Broken lamp'], 'sea', 'True', 100.00,ARRAY['wifi','Parking'], 5, 38),
    (105,ARRAY['Air conditioning not working'], 'sea', 'True', 175.00,ARRAY['wifi','Parking'], 6, 38),
    (100,ARRAY['Clogged sink'], 'sea', 'True', 100.00,ARRAY['wifi','AC'], 1, 39),
    (101,ARRAY['Moldy Walls'], 'mountain', 'False', 175.00,ARRAY['wifi','Safe'], 2, 39),
    (102,ARRAY['Broken lamp'], 'sea', 'True', 175.00,ARRAY['wifi','Parking'], 3, 39),
    (103,ARRAY['Air conditioning not working'], 'mountain', 'True', 200.00,ARRAY['wifi','mini bar'], 4, 39),
    (104,ARRAY['Clogged sink'], 'mountain', 'False', 165.00,ARRAY['wifi','AC'], 5, 39),
    (105,ARRAY['Moldy Walls'], 'sea', 'False', 175.00,ARRAY['wifi',''], 6, 39),
    (100,ARRAY['TV not working'], 'sea', 'False', 175.00,ARRAY['wifi','AC'], 1, 40),
    (101,ARRAY['TV not working'], 'sea', 'True', 175.00,ARRAY['wifi','mini bar'], 2, 40),
    (102,ARRAY['Air conditioning not working'], 'sea', 'True', 150.00,ARRAY['wifi','Parking'], 3, 40),
    (103,ARRAY['Moldy Walls'], 'mountain', 'False', 150.00,ARRAY['wifi',''], 4, 40),
    (104,ARRAY['Air conditioning not working'], 'sea', 'True', 100.00,ARRAY['wifi','Parking'], 5, 40),
    (105,ARRAY['Moldy Walls'], 'mountain', 'False', 100.00,ARRAY['wifi','Safe'], 6, 40)
    ON CONFLICT DO NOTHING;


--VIEWS
CREATE VIEW room_area as (
                             SELECT hotel.country,hotel.region,
                             COUNT (*)
                             FROM (room JOIN hotel on room.hotel_id = hotel.hotel_id)
                             GROUP BY (hotel.country,hotel.region));


CREATE VIEW available_rooms AS (SELECT  x.hotel_id, COUNT (x.hotel_id)
                               FROM room AS x
                               WHERE NOT EXISTS(
                                       SELECT *
                                       FROM (booking right join renting USING (hotel_id,room_number,customer_ssn)) AS y
                                       WHERE (x.hotel_id = y.hotel_id and x.room_number = y.room_number))
                               GROUP BY(x.hotel_id));


--same view without the count
CREATE VIEW available_rooms_no_count AS (SELECT  * FROM room AS x WHERE NOT EXISTS
        (SELECT * FROM (booking right join renting USING (hotel_id,room_number,customer_ssn))AS y
         WHERE (x.hotel_id = y.hotel_id and x.room_number = y.room_number)));
--triggers
CREATE OR REPLACE FUNCTION Booking_Created() RETURNS TRIGGER AS
$BODY$
BEGIN
    INSERT INTO archive(date_booked,room_number,date_rented_start,date_rented_end,hotel_id,customer)
    VALUES(new.date_booked,new.room_number,new.renting_start,new.renting_end,new.hotel_id,new.customer_ssn);
    RETURN new;
END;
$BODY$
    language plpgsql;

CREATE TRIGGER booking_create
    AFTER INSERT ON booking
    FOR EACH ROW
EXECUTE PROCEDURE Booking_created();

CREATE OR REPLACE FUNCTION Renting_Created() RETURNS TRIGGER AS
$BODY$
BEGIN
    UPDATE archive
    SET employee = new.employee_ssn
    WHERE hotel_id = new.hotel_id and room_number = new.room_number and customer = new.customer_ssn;
    DELETE FROM booking
    WHERE new.hotel_id = booking.hotel_id and new.room_number = booking.room_number and new.customer_ssn = booking.customer_ssn;
    RETURN new;
END;
$BODY$
    language plpgsql;

CREATE TRIGGER renting_create
    AFTER INSERT ON renting
    FOR EACH ROW
EXECUTE PROCEDURE Renting_created();