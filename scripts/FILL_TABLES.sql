CREATE SCHEMA DIM
GO

CREATE SCHEMA FACT
GO

CREATE SCHEMA STAGE
GO

CREATE SCHEMA META
GO

SET NOCOUNT ON

DROP TABLE IF EXISTS DIM.PLANES

-- Create PLANES table
CREATE TABLE DIM.PLANES (
    PLANE_ID INT IDENTITY(1,1),
    PLANE_NAME VARCHAR(100),
    PLANE_TYPE VARCHAR(50),
    PLANE_CAPACITY INT
)

-- Insert sample data into PLANES table
INSERT INTO DIM.PLANES (PLANE_NAME, PLANE_TYPE, PLANE_CAPACITY)
VALUES ('Airbus A320', 'Commercial', 180),
    ('Boeing 737', 'Commercial', 160),
    ('Boeing 787', 'Commercial', 296),
    ('Airbus A350', 'Commercial', 325),
    ('Boeing 777', 'Commercial', 314),
    ('Airbus A330', 'Commercial', 277),
    ('ATR 72', 'Regional', 70),
    ('Embraer E190', 'Regional', 100),
    ('Bombardier CRJ900', 'Regional', 90),
    ('Embraer E195', 'Regional', 124)

-- Create TICKET_TYPE table
DROP TABLE IF EXISTS DIM.TICKET_TYPE

CREATE TABLE DIM.TICKET_TYPE (
    TICKET_TYPE_ID INT IDENTITY(1,1),
    TICKET_TYPE VARCHAR(100)
)

-- Insert sample data into TICKET_TYPE table
INSERT INTO DIM.TICKET_TYPE (TICKET_TYPE)
VALUES ('First Class'),
	   ('Business Class'),
	   ('Economy Class')

-- Create LUGGAGE_TYPE table
DROP TABLE IF EXISTS DIM.LUGGAGE_TYPE

CREATE TABLE DIM.LUGGAGE_TYPE (
    LUGGAGE_TYPE_ID INT IDENTITY(1,1),
    LUGGAGE_TYPE VARCHAR(100),
    LUGGAGE_WEIGHT INT
)

-- Insert sample data into LUGGAGE_TYPE table
INSERT INTO DIM.LUGGAGE_TYPE (LUGGAGE_TYPE, LUGGAGE_WEIGHT)
VALUES ('Carry-on Bag', 5),
       ('Checked Bag', 10),
       ('Oversized Bag', 20),
	   ('Full Package', 35)

-- Create AIRLINES table
DROP TABLE IF EXISTS DIM.AIRLINES

CREATE TABLE DIM.AIRLINES (
    AIRLINE_ID INT IDENTITY(1,1),
    AIRLINE_NAME VARCHAR(100),
    AIRLINE_ACRONYM VARCHAR(10),
    AIRLINE_TYPE VARCHAR(30),
    COUNTRY_OF_ORIGIN VARCHAR(100)
)

-- Insert sample data into AIRLINES table
INSERT INTO DIM.AIRLINES (AIRLINE_NAME, AIRLINE_ACRONYM, AIRLINE_TYPE, COUNTRY_OF_ORIGIN)
VALUES
('Lufthansa', 'LH', 'Full-Service', 'Germany'),
('British Airways', 'BA', 'Full-Service', 'United Kingdom'),
('Air France', 'AF', 'Full-Service', 'France'),
('KLM Royal Dutch Airlines', 'KL', 'Full-Service', 'Netherlands'),
('Alitalia', 'AZ', 'Full-Service', 'Italy'),
('Iberia', 'IB', 'Full-Service', 'Spain'),
('Swiss International Air Lines', 'LX', 'Full-Service', 'Switzerland'),
('Scandinavian Airlines (SAS)', 'SK', 'Full-Service', 'Sweden'),
('Aer Lingus', 'EI', 'Full-Service', 'Ireland'),
('LOT Polish Airlines', 'LO', 'Full-Service', 'Poland'),
('Ryanair', 'FR', 'Low-Cost', 'Ireland'),
('Wizz Air', 'W6', 'Low-Cost', 'Hungary'),
('Smartwings', 'QS', 'Low-Cost', 'Czech Republic'),
('EasyJet', 'U2', 'Low-Cost', 'United Kingdom'),
('Eurowings', 'EW', 'Low-Cost', 'Germany'),
('Vueling', 'VY', 'Low-Cost', 'Spain');


-- Create DESTINATIONS table
DROP TABLE IF EXISTS DIM.DESTINATIONS

CREATE TABLE DIM.DESTINATIONS (
    DESTINATION_ID INT IDENTITY(1,1),
    DESTINATION_NAME VARCHAR(100),
    DESTINATION_ACRONYM VARCHAR(10),
    DESTINATION_CITY VARCHAR(100),
    DESTINATION_COUNTRY VARCHAR(100)
)

-- Insert sample data into DESTINATIONS table
INSERT INTO DIM.DESTINATIONS (DESTINATION_NAME, DESTINATION_ACRONYM, DESTINATION_CITY, DESTINATION_COUNTRY)
VALUES
    ('Frankfurt Airport', 'FRA', 'Frankfurt', 'Germany'),
    ('Heathrow Airport', 'LHR', 'London', 'United Kingdom'),
    ('Charles de Gaulle Airport', 'CDG', 'Paris', 'France'),
    ('Amsterdam Airport Schiphol', 'AMS', 'Amsterdam', 'Netherlands'),
    ('Milan Malpensa Airport', 'MXP', 'Milan', 'Italy'),
    ('Barcelona–El Prat Airport', 'BCN', 'Barcelona', 'Spain'),
    ('Leonardo da Vinci–Fiumicino Airport', 'FCO', 'Rome', 'Italy'),
    ('Madrid Barajas Airport', 'MAD', 'Madrid', 'Spain'),
    ('Munich Airport', 'MUC', 'Munich', 'Germany'),
    ('Vienna International Airport', 'VIE', 'Vienna', 'Austria'),
    ('Athens International Airport', 'ATH', 'Athens', 'Greece'),
    ('Lisbon Portela Airport', 'LIS', 'Lisbon', 'Portugal'),
    ('Zurich Airport', 'ZRH', 'Zurich', 'Switzerland'),
    ('Copenhagen Airport', 'CPH', 'Copenhagen', 'Denmark'),
    ('Stockholm Arlanda Airport', 'ARN', 'Stockholm', 'Sweden'),
    ('Dublin Airport', 'DUB', 'Dublin', 'Ireland'),
    ('Warsaw Chopin Airport', 'WAW', 'Warsaw', 'Poland'),
    ('Oslo Airport, Gardermoen', 'OSL', 'Oslo', 'Norway'),
    ('Helsinki Airport', 'HEL', 'Helsinki', 'Finland'),
    ('Brussels Airport', 'BRU', 'Brussels', 'Belgium'),
    ('Budapest Ferenc Liszt International Airport', 'BUD', 'Budapest', 'Hungary'),
    ('Geneva Airport', 'GVA', 'Geneva', 'Switzerland'),
    ('Berlin Brandenburg Airport', 'BER', 'Berlin', 'Germany'),
    ('Istanbul Atatürk Airport', 'IST', 'Istanbul', 'Turkey'),
    ('Nice Côte d Azur Airport', 'NCE', 'Nice', 'France'),
    ('Palma de Mallorca Airport', 'PMI', 'Palma de Mallorca', 'Spain'),
    ('Manchester Airport', 'MAN', 'Manchester', 'United Kingdom'),
    ('Lyon–Saint-Exupéry Airport', 'LYS', 'Lyon', 'France'),
    ('Edinburgh Airport', 'EDI', 'Edinburgh', 'United Kingdom'),
    ('Kraków John Paul II International Airport', 'KRK', 'Krakow', 'Poland')

-- Create DATES table
DROP TABLE IF EXISTS DIM.DATES

CREATE TABLE DIM.DATES (
    DATE DATE,
    DAY_OF_WEEK VARCHAR(20),
    DAY_OF_WEEK_NO INT,
    MONTH VARCHAR(20),
    YEAR INT,
    IS_CZECH_HOLIDAY INT,
    IS_US_HOLIDAY INT,
    IS_UK_HOLIDAY INT
)

-- Insert sample data into DATES table for year 2023
DROP TABLE IF EXISTS #temp2023
GO

WITH DateGenerator2023 AS (
    SELECT CAST('2023-01-01' AS DATE) AS DATE
    UNION ALL
    SELECT DATEADD(DAY, 1, DATE) AS DATE
    FROM DateGenerator2023
    WHERE DATE < '2023-12-31'
) 
SELECT * 
INTO #temp2023 
FROM DateGenerator2023
OPTION (maxrecursion 0)

INSERT INTO DIM.DATES (DATE, DAY_OF_WEEK, DAY_OF_WEEK_NO, MONTH, YEAR, IS_CZECH_HOLIDAY, IS_US_HOLIDAY, IS_UK_HOLIDAY)
SELECT
    DATE,
    DATENAME(WEEKDAY, DATE) AS DAY_OF_WEEK,
    DATEPART(WEEKDAY, DATE) AS DAY_OF_WEEK_NO,
    DATENAME(MONTH, DATE) AS MONTH,
    YEAR(DATE) AS YEAR,
    CASE WHEN DATE IN ('2023-01-01', '2023-04-07', '2023-04-10', '2023-05-01', '2023-05-08', '2023-07-05', '2023-07-06', '2023-09-28', '2023-10-28', '2023-11-17', '2023-12-24', '2023-12-25', '2023-12-26') THEN 1 ELSE 0 END AS IS_CZECH_HOLIDAY,
    CASE WHEN DATE IN ('2023-01-01', '2023-01-16', '2023-02-20', '2023-05-29', '2023-07-04', '2023-09-04', '2023-10-09', '2023-11-10', '2023-12-25', '2023-12-26') THEN 1 ELSE 0 END AS IS_US_HOLIDAY,
    CASE WHEN DATE IN ('2023-01-01', '2023-04-07', '2023-04-10', '2023-05-01', '2023-05-29', '2023-08-28', '2023-12-25', '2023-12-26', '2023-12-27', '2023-12-28') THEN 1 ELSE 0 END AS IS_UK_HOLIDAY
FROM #temp2023

-- Insert sample data into DATES table for year 2024
DROP TABLE IF EXISTS #temp2024
GO

WITH DateGenerator2024 AS (
    SELECT CAST('2024-01-01' AS DATE) AS DATE
    UNION ALL
    SELECT DATEADD(DAY, 1, DATE)
    FROM DateGenerator2024
    WHERE DATE < '2024-12-31'
)
SELECT * 
INTO #temp2024 
FROM DateGenerator2024
OPTION (maxrecursion 0)

INSERT INTO DIM.DATES (DATE, DAY_OF_WEEK, DAY_OF_WEEK_NO, MONTH, YEAR, IS_CZECH_HOLIDAY, IS_US_HOLIDAY, IS_UK_HOLIDAY)
SELECT
    DATE,
    DATENAME(WEEKDAY, DATE) AS DAY_OF_WEEK,
    DATEPART(WEEKDAY, DATE) AS DAY_OF_WEEK_NO,
    DATENAME(MONTH, DATE) AS MONTH,
    YEAR(DATE) AS YEAR,
    CASE WHEN DATE IN ('2024-01-01', '2024-03-29', '2024-04-01', '2024-05-01', '2024-05-08', '2024-07-05', '2024-07-06', '2024-09-28', '2024-10-28', '2024-11-17', '2024-12-24', '2024-12-25', '2024-12-26') THEN 1 ELSE 0 END AS IS_CZECH_HOLIDAY,
    CASE WHEN DATE IN ('2024-01-01', '2024-01-15', '2024-02-19', '2024-05-27', '2024-07-04', '2024-09-02', '2024-10-14', '2024-11-11', '2024-12-25', '2024-12-26') THEN 1 ELSE 0 END AS IS_US_HOLIDAY,
    CASE WHEN DATE IN ('2024-01-01', '2024-03-29', '2024-04-01', '2024-05-06', '2024-05-27', '2024-08-26', '2024-12-25', '2024-12-26', '2024-12-27', '2024-12-30') THEN 1 ELSE 0 END AS IS_UK_HOLIDAY
FROM #temp2024

-- Create GATES table
DROP TABLE IF EXISTS DIM.GATES

CREATE TABLE DIM.GATES (
    GATE_ID UNIQUEIDENTIFIER,
    GATE_NO INT,
    GATE_TYPE VARCHAR(50),
    DISTANCE_FROM_SECURITY_CHECK INT
)

-- Insert sample data into GATES table
INSERT INTO DIM.GATES (GATE_ID, GATE_NO, GATE_TYPE, DISTANCE_FROM_SECURITY_CHECK)
VALUES
    (NEWID(), 1, 'Jet Bridge Gate', 200),
    (NEWID(), 2, 'Jet Bridge Gate', 250),
    (NEWID(), 3, 'Jet Bridge Gate', 300),
    (NEWID(), 5, 'Jet Bridge Gate', 350),
    (NEWID(), 6, 'Jet Bridge Gate', 400),
    (NEWID(), 7, 'Jet Bridge Gate', 450),
    (NEWID(), 8, 'Jet Bridge Gate', 500),
    (NEWID(), 9, 'Jet Bridge Gate', 550),
    (NEWID(), 4, 'Bus Gate', 100),
    (NEWID(), 10, 'Bus Gate', 150),
    (NEWID(), 11, 'Bus Gate', 200),
    (NEWID(), 12, 'Bus Gate', 250)

DROP TABLE IF EXISTS DIM.WEATHER_CONDITIONS;

-- Create the WeatherConditions dimension table
CREATE TABLE DIM.WEATHER_CONDITIONS (
    WEATHER_CONDITION_ID INT PRIMARY KEY,
    WEATHER_CONDITION VARCHAR(50)
);

-- Insert data into the WeatherConditions dimension table
INSERT INTO DIM.WEATHER_CONDITIONS (WEATHER_CONDITION_ID, WEATHER_CONDITION)
VALUES
    (1, 'Clear'),
    (2, 'Cloudy'),
    (3, 'Rainy'),
    (4, 'Snowy'),
    (5, 'Stormy');

DROP TABLE IF EXISTS STAGE.PLANES

-- Create PLANES table
CREATE TABLE STAGE.PLANES (
    PLANE_ID INT IDENTITY(1,1),
    PLANE_NAME VARCHAR(100),
    PLANE_TYPE VARCHAR(50),
    PLANE_CAPACITY INT
)

-- Insert sample data into PLANES table
INSERT INTO STAGE.PLANES (PLANE_NAME, PLANE_TYPE, PLANE_CAPACITY)
VALUES ('Airbus A320', 'Commercial', 180),
    ('Boeing 737', 'Commercial', 160),
    ('Boeing 787', 'Commercial', 296),
    ('Airbus A350', 'Commercial', 325),
    ('Boeing 777', 'Commercial', 314),
    ('Airbus A330', 'Commercial', 277),
    ('ATR 72', 'Regional', 70),
    ('Embraer E190', 'Regional', 100),
    ('Bombardier CRJ900', 'Regional', 90),
    ('Embraer E195', 'Regional', 124)

-- Create TICKET_TYPE table
DROP TABLE IF EXISTS STAGE.TICKET_TYPE

CREATE TABLE STAGE.TICKET_TYPE (
    TICKET_TYPE_ID INT IDENTITY(1,1),
    TICKET_TYPE VARCHAR(100)
)

-- Insert sample data into TICKET_TYPE table
INSERT INTO STAGE.TICKET_TYPE (TICKET_TYPE)
VALUES ('First Class'),
	   ('Business Class'),
	   ('Economy Class')

-- Create LUGGAGE_TYPE table
DROP TABLE IF EXISTS STAGE.LUGGAGE_TYPE

CREATE TABLE STAGE.LUGGAGE_TYPE (
    LUGGAGE_TYPE_ID INT IDENTITY(1,1),
    LUGGAGE_TYPE VARCHAR(100),
    LUGGAGE_WEIGHT INT
)

-- Insert sample data into LUGGAGE_TYPE table
INSERT INTO STAGE.LUGGAGE_TYPE (LUGGAGE_TYPE, LUGGAGE_WEIGHT)
VALUES ('Carry-on Bag', 5),
       ('Checked Bag', 10),
       ('Oversized Bag', 20),
	   ('Full Package', 35)

-- Create AIRLINES table
DROP TABLE IF EXISTS STAGE.AIRLINES

CREATE TABLE STAGE.AIRLINES (
    AIRLINE_ID INT IDENTITY(1,1),
    AIRLINE_NAME VARCHAR(100),
    AIRLINE_ACRONYM VARCHAR(10),
    AIRLINE_SIZE VARCHAR(20),
    COUNTRY_OF_ORIGIN VARCHAR(100)
)

-- Insert sample data into AIRLINES table
INSERT INTO STAGE.AIRLINES (AIRLINE_NAME, AIRLINE_ACRONYM, AIRLINE_SIZE, COUNTRY_OF_ORIGIN)
VALUES ('Lufthansa', 'LH', 'Full-Service', 'Germany'),
('British Airways', 'BA', 'Full-Service', 'United Kingdom'),
('Air France', 'AF', 'Full-Service', 'France'),
('KLM Royal Dutch Airlines', 'KL', 'Full-Service', 'Netherlands'),
('Alitalia', 'AZ', 'Full-Service', 'Italy'),
('Iberia', 'IB', 'Full-Service', 'Spain'),
('Swiss International Air Lines', 'LX', 'Full-Service', 'Switzerland'),
('Scandinavian Airlines (SAS)', 'SK', 'Full-Service', 'Sweden'),
('Aer Lingus', 'EI', 'Full-Service', 'Ireland'),
('LOT Polish Airlines', 'LO', 'Full-Service', 'Poland'),
('Ryanair', 'FR', 'Low-Cost', 'Ireland'),
('Wizz Air', 'W6', 'Low-Cost', 'Hungary'),
('Smartwings', 'QS', 'Low-Cost', 'Czech Republic'),
('EasyJet', 'U2', 'Low-Cost', 'United Kingdom'),
('Eurowings', 'EW', 'Low-Cost', 'Germany'),
('Vueling', 'VY', 'Low-Cost', 'Spain');


-- Create DESTINATIONS table
DROP TABLE IF EXISTS STAGE.DESTINATIONS

CREATE TABLE STAGE.DESTINATIONS (
    DESTINATION_ID INT IDENTITY(1,1),
    DESTINATION_NAME VARCHAR(100),
    DESTINATION_ACRONYM VARCHAR(10),
    DESTINATION_CITY VARCHAR(100),
    DESTINATION_COUNTRY VARCHAR(100)
)

-- Insert sample data into DESTINATIONS table
INSERT INTO STAGE.DESTINATIONS (DESTINATION_NAME, DESTINATION_ACRONYM, DESTINATION_CITY, DESTINATION_COUNTRY)
VALUES
    ('Frankfurt Airport', 'FRA', 'Frankfurt', 'Germany'),
    ('Heathrow Airport', 'LHR', 'London', 'United Kingdom'),
    ('Charles de Gaulle Airport', 'CDG', 'Paris', 'France'),
    ('Amsterdam Airport Schiphol', 'AMS', 'Amsterdam', 'Netherlands'),
    ('Milan Malpensa Airport', 'MXP', 'Milan', 'Italy'),
    ('Barcelona–El Prat Airport', 'BCN', 'Barcelona', 'Spain'),
    ('Leonardo da Vinci–Fiumicino Airport', 'FCO', 'Rome', 'Italy'),
    ('Madrid Barajas Airport', 'MAD', 'Madrid', 'Spain'),
    ('Munich Airport', 'MUC', 'Munich', 'Germany'),
    ('Vienna International Airport', 'VIE', 'Vienna', 'Austria'),
    ('Athens International Airport', 'ATH', 'Athens', 'Greece'),
    ('Lisbon Portela Airport', 'LIS', 'Lisbon', 'Portugal'),
    ('Zurich Airport', 'ZRH', 'Zurich', 'Switzerland'),
    ('Copenhagen Airport', 'CPH', 'Copenhagen', 'Denmark'),
    ('Stockholm Arlanda Airport', 'ARN', 'Stockholm', 'Sweden'),
    ('Dublin Airport', 'DUB', 'Dublin', 'Ireland'),
    ('Warsaw Chopin Airport', 'WAW', 'Warsaw', 'Poland'),
    ('Oslo Airport, Gardermoen', 'OSL', 'Oslo', 'Norway'),
    ('Helsinki Airport', 'HEL', 'Helsinki', 'Finland'),
    ('Brussels Airport', 'BRU', 'Brussels', 'Belgium'),
    ('Budapest Ferenc Liszt International Airport', 'BUD', 'Budapest', 'Hungary'),
    ('Geneva Airport', 'GVA', 'Geneva', 'Switzerland'),
    ('Berlin Brandenburg Airport', 'BER', 'Berlin', 'Germany'),
    ('Istanbul Atatürk Airport', 'IST', 'Istanbul', 'Turkey'),
    ('Nice Côte d Azur Airport', 'NCE', 'Nice', 'France'),
    ('Palma de Mallorca Airport', 'PMI', 'Palma de Mallorca', 'Spain'),
    ('Manchester Airport', 'MAN', 'Manchester', 'United Kingdom'),
    ('Lyon–Saint-Exupéry Airport', 'LYS', 'Lyon', 'France'),
    ('Edinburgh Airport', 'EDI', 'Edinburgh', 'United Kingdom'),
    ('Kraków John Paul II International Airport', 'KRK', 'Krakow', 'Poland')


-- Create DATES table
DROP TABLE IF EXISTS STAGE.DATES

CREATE TABLE STAGE.DATES (
    DATE DATE,
    DAY_OF_WEEK VARCHAR(20),
    DAY_OF_WEEK_NO INT,
    MONTH VARCHAR(20),
    YEAR INT,
    IS_CZECH_HOLIDAY INT,
    IS_US_HOLIDAY INT,
    IS_UK_HOLIDAY INT
)

-- Insert sample data into DATES table for year 2023
DROP TABLE IF EXISTS #temp2023
GO

WITH DateGenerator2023 AS (
    SELECT CAST('2023-01-01' AS DATE) AS DATE
    UNION ALL
    SELECT DATEADD(DAY, 1, DATE) AS DATE
    FROM DateGenerator2023
    WHERE DATE < '2023-12-31'
) 
SELECT * 
INTO #temp2023 
FROM DateGenerator2023
OPTION (maxrecursion 0)

INSERT INTO STAGE.DATES (DATE, DAY_OF_WEEK, DAY_OF_WEEK_NO, MONTH, YEAR, IS_CZECH_HOLIDAY, IS_US_HOLIDAY, IS_UK_HOLIDAY)
SELECT
    DATE,
    DATENAME(WEEKDAY, DATE) AS DAY_OF_WEEK,
    DATEPART(WEEKDAY, DATE) AS DAY_OF_WEEK_NO,
    DATENAME(MONTH, DATE) AS MONTH,
    YEAR(DATE) AS YEAR,
    CASE WHEN DATE IN ('2023-01-01', '2023-04-07', '2023-04-10', '2023-05-01', '2023-05-08', '2023-07-05', '2023-07-06', '2023-09-28', '2023-10-28', '2023-11-17', '2023-12-24', '2023-12-25', '2023-12-26') THEN 1 ELSE 0 END AS IS_CZECH_HOLIDAY,
    CASE WHEN DATE IN ('2023-01-01', '2023-01-16', '2023-02-20', '2023-05-29', '2023-07-04', '2023-09-04', '2023-10-09', '2023-11-10', '2023-12-25', '2023-12-26') THEN 1 ELSE 0 END AS IS_US_HOLIDAY,
    CASE WHEN DATE IN ('2023-01-01', '2023-04-07', '2023-04-10', '2023-05-01', '2023-05-29', '2023-08-28', '2023-12-25', '2023-12-26', '2023-12-27', '2023-12-28') THEN 1 ELSE 0 END AS IS_UK_HOLIDAY
FROM #temp2023

-- Insert sample data into DATES table for year 2024
DROP TABLE IF EXISTS #temp2024
GO

WITH DateGenerator2024 AS (
    SELECT CAST('2024-01-01' AS DATE) AS DATE
    UNION ALL
    SELECT DATEADD(DAY, 1, DATE)
    FROM DateGenerator2024
    WHERE DATE < '2024-12-31'
)
SELECT * 
INTO #temp2024 
FROM DateGenerator2024
OPTION (maxrecursion 0)

INSERT INTO STAGE.DATES (DATE, DAY_OF_WEEK, DAY_OF_WEEK_NO, MONTH, YEAR, IS_CZECH_HOLIDAY, IS_US_HOLIDAY, IS_UK_HOLIDAY)
SELECT
    DATE,
    DATENAME(WEEKDAY, DATE) AS DAY_OF_WEEK,
    DATEPART(WEEKDAY, DATE) AS DAY_OF_WEEK_NO,
    DATENAME(MONTH, DATE) AS MONTH,
    YEAR(DATE) AS YEAR,
    CASE WHEN DATE IN ('2024-01-01', '2024-03-29', '2024-04-01', '2024-05-01', '2024-05-08', '2024-07-05', '2024-07-06', '2024-09-28', '2024-10-28', '2024-11-17', '2024-12-24', '2024-12-25', '2024-12-26') THEN 1 ELSE 0 END AS IS_CZECH_HOLIDAY,
    CASE WHEN DATE IN ('2024-01-01', '2024-01-15', '2024-02-19', '2024-05-27', '2024-07-04', '2024-09-02', '2024-10-14', '2024-11-11', '2024-12-25', '2024-12-26') THEN 1 ELSE 0 END AS IS_US_HOLIDAY,
    CASE WHEN DATE IN ('2024-01-01', '2024-03-29', '2024-04-01', '2024-05-06', '2024-05-27', '2024-08-26', '2024-12-25', '2024-12-26', '2024-12-27', '2024-12-30') THEN 1 ELSE 0 END AS IS_UK_HOLIDAY
FROM #temp2024

-- Create GATES table
DROP TABLE IF EXISTS STAGE.GATES

CREATE TABLE STAGE.GATES (
    GATE_ID UNIQUEIDENTIFIER,
    GATE_NO INT,
    GATE_TYPE VARCHAR(30),
    DISTANCE_FROM_SECURITY_CHECK VARCHAR(20)
)

-- Insert sample data into GATES table
INSERT INTO STAGE.GATES (GATE_ID, GATE_NO, GATE_TYPE, DISTANCE_FROM_SECURITY_CHECK)
VALUES
    (NEWID(), 1, 'Jet Bridge Gate', 200),
    (NEWID(), 2, 'Jet Bridge Gate', 250),
    (NEWID(), 3, 'Jet Bridge Gate', 300),
    (NEWID(), 5, 'Jet Bridge Gate', 350),
    (NEWID(), 6, 'Jet Bridge Gate', 400),
    (NEWID(), 7, 'Jet Bridge Gate', 450),
    (NEWID(), 8, 'Jet Bridge Gate', 500),
    (NEWID(), 9, 'Jet Bridge Gate', 550),
    (NEWID(), 4, 'Bus Gate', 100),
    (NEWID(), 10, 'Bus Gate', 150),
    (NEWID(), 11, 'Bus Gate', 200),
    (NEWID(), 12, 'Bus Gate', 250)

DROP TABLE IF EXISTS STAGE.WEATHER_CONDITIONS;

-- Create the WeatherConditions dimension table
CREATE TABLE STAGE.WEATHER_CONDITIONS (
    WEATHER_CONDITION_ID INT PRIMARY KEY,
    WEATHER_CONDITION VARCHAR(50)
);

-- Insert data into the WeatherConditions dimension table
INSERT INTO STAGE.WEATHER_CONDITIONS (WEATHER_CONDITION_ID, WEATHER_CONDITION)
VALUES
    (1, 'Clear'),
    (2, 'Cloudy'),
    (3, 'Rainy'),
    (4, 'Snowy'),
    (5, 'Stormy');
