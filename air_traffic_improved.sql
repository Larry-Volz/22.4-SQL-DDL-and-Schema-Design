-- from the terminal run:
-- psql < air_traffic_improved.sql

DROP DATABASE IF EXISTS air_traffic;

CREATE DATABASE air_traffic;

\c air_traffic

SET client_encoding = 'UTF8';


CREATE TABLE countries
(
 id SERIAL PRIMARY KEY,
 name TEXT NOT NULL
);


CREATE TABLE cities
(
 id SERIAL PRIMARY KEY,
 name TEXT NOT NULL,
 country_id INTEGER NOT NULL REFERENCES countries
);


CREATE TABLE airlines
(
 id SERIAL PRIMARY KEY,
 name TEXT NOT NULL
);


CREATE TABLE airplanes
(
 id SERIAL PRIMARY KEY , -- '  plane registration number',
 capacity INTEGER NULL , -- 'NN for IRL',
 location INTEGER NULL , -- 'NN for IRL' CURRENT location - in flight, airport, etc.,
 status INTEGER NULL , -- 'NN for IRL', flight-ready, etc.
 airline_id INTEGER NOT NULL REFERENCES airlines
);


CREATE TABLE flights
(
 id SERIAL PRIMARY KEY, --  
 airplane_id INTEGER NOT NULL REFERENCES airplanes,
 from_city INTEGER NOT NULL REFERENCES cities,
 to_city INTEGER NOT NULL REFERENCES cities,
 depart_time  TIME NOT NULL,
 depart_date DATE NOT NULL,
 arrive_time TIME NOT NULL,
 arrive_date DATE NOT NULL
);


CREATE TABLE passengers
(
 id SERIAL PRIMARY KEY, --  
 first_name VARCHAR NOT NULL,
 last_name VARCHAR NOT NULL,
 phone VARCHAR NULL,
 email VARCHAR NULL
);


CREATE TABLE seats
(
 id SERIAL PRIMARY KEY, --  
 plane_id INTEGER NOT NULL REFERENCES airplanes,
 seat_number TEXT NOT NULL
);


CREATE TABLE tickets
(
 id SERIAL PRIMARY KEY, --  
 passenger_id INTEGER NOT NULL REFERENCES passengers,
 seat_id INTEGER NOT NULL REFERENCES seats
);


CREATE TABLE itinerary
(
 id SERIAL PRIMARY KEY, --  
 ticket_id INTEGER NOT NULL REFERENCES tickets,
 flight_id INTEGER NOT NULL REFERENCES flights
);

-- --------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO countries
  (name)
VALUES
  ('United Kingdom'),
  ('United States'),
  ('Mexico'),
  ('Morocco'),
  ('China'),
  ('Japan'),
  ('France'),
  ('Chile'),
  ('UAE'),
  ('Brazil'),
  ('Chili');


  INSERT INTO cities
  (name, country_id)
VALUES
  ('Washington DC', 2),
  ('Seattle', 2),
  ('Tokyo', 6),
  ('London', 1),
  ('Los Angeles', 2),
  ('Las Vegas', 2),
  ('Mexico City', 3),
  ('Paris', 7), 
  ('Casablanca', 4),
  ('Dubai', 9), 
  ('Beijing', 5),
  ('New York', 2), 
  ('Charlotte', 2),
  ('Cedar Rapids', 2), 
  ('Chicago', 2),
  ('New Orleans', 2),
  ('Sao Paolo', 10), 
  ('Santiago', 11);



INSERT INTO airlines
  (name)
VALUES
  ('United'),
  ('British Airways'),
  ('Delta'),
  ('TUI Fly Belgium'),
  ('Air China'),
  ('American Airlines'),
  ('Avianca Brasil');

INSERT INTO airplanes
    (airline_id)
VALUES
    (1),
    (2),
    (3),
    (3),
    (4),
    (5),
    (1),
    (6),
    (6),
    (7);


INSERT INTO flights
    (airplane_id, depart_date,  depart_time, arrive_date, arrive_time, from_city, to_city)    
VALUES
  (1,'2018-04-08', '09:00:00', '2018-04-08', '12:00:00', 1, 2),
  (2, '2018-12-19', '12:45:00', '2018-12-19', '16:15:00', 3, 4),
  (3, '2018-01-02', '07:00:00', '2018-01-02', '08:03:00', 5, 6),
  (4, '2018-04-15', '16:50:00', '2018-04-15', '21:00:00', 2, 7),
  (5,'2018-08-01', '18:30:00', '2018-08-01', '21:50:00', 8, 9),
  (6, '2018-10-31', '01:15:00', '2018-10-31', '12:55:00', 10, 11),
  (7, '2019-02-06', '06:00:00', '2019-02-06', '07:47:00', 12, 13),
  (8, '2018-12-22', '14:42:00', '2018-12-22', '15:56:00', 14, 15),
  (9, '2019-02-06', '16:28:00', '2019-02-06', '19:18:00', 13, 16),
  (10, '2019-01-20', '19:30:00', '2019-01-20', '22:45:00', 17, 18);

INSERT INTO passengers 
    (first_name, last_name)
VALUES
  ('Jennifer', 'Finch'),
  ('Thadeus', 'Gathercoal'),
  ('Sonja', 'Pauley'),
  ('Jennifer', 'Finch'),
  ('Waneta', 'Skeleton'),
  ('Thadeus', 'Gathercoal'),
  ('Berkie', 'Wycliff'),
  ('Alvin', 'Leathes'),
  ('Berkie', 'Wycliff'),
  ('Cory', 'Squibbes');

INSERT INTO seats
    (plane_id, seat_number)
VALUES
  (1, '33B'),
  (2, '8A'),
  (3, '12F'),
  (4, '20A'),
  (5, '23D'),
  (6, '18C'),
  (7, '9E'),
  (8, '1A'),
  (9, '32B'),
  (10, '10D');


INSERT INTO tickets
  (passenger_id, seat_id)
VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5),
  (6, 6),
  (7, 7),
  (8, 8),
  (9, 9),
  (10, 10);


INSERT INTO itinerary
  (ticket_id, flight_id)
VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5),
  (6, 6),
  (7, 7),
  (8, 8),
  (9, 9),
  (10, 10);


-- to display names and seat numbers
-- SELECT p.first_name, p.last_name, s.seat_number FROM passengers p JOIN tickets t ON p.id = t.passenger_id JOIN seats s ON s.id = t.seat_id;


--ORIGINAL CODE:
-- -   INSERT INTO tickets, 
--   (first_name, last_name, seat, departure, arrival, airline, from_city, from_country, to_city, to_country)
-- VALUES
--  ('Jennifer', 'Finch', '33B', '2018-04-08 09:00:00', '2018-04-08 12:00:00', 'United', 'Washington DC', 'United States', 'Seattle', 'United States'),
--   ('Thadeus', 'Gathercoal', '8A', '2018-12-19 12:45:00', '2018-12-19 16:15:00', 'British Airways', 'Tokyo', 'Japan', 'London', 'United Kingdom'),
--   ('Sonja', 'Pauley', '12F', '2018-01-02 07:00:00', '2018-01-02 08:03:00', 'Delta', 'Los Angeles', 'United States', 'Las Vegas', 'United States'),
--   ('Jennifer', 'Finch', '20A', '2018-04-15 16:50:00', '2018-04-15 21:00:00', 'Delta', 'Seattle', 'United States', 'Mexico City', 'Mexico'),
--  ('Waneta', 'Skeleton', '23D', '2018-08-01 18:30:00', '2018-08-01 21:50:00', 'TUI Fly Belgium', 'Paris', 'France', 'Casablanca', 'Morocco'),
--  ('Thadeus', 'Gathercoal', '18C', '2018-10-31 01:15:00', '2018-10-31 12:55:00', 'Air China', 'Dubai', 'UAE', 'Beijing', 'China'),
--   ('Berkie', 'Wycliff', '9E', '2019-02-06 06:00:00', '2019-02-06 07:47:00', 'United', 'New York', 'United States', 'Charlotte', 'United States'),
--  ('Alvin', 'Leathes', '1A', '2018-12-22 14:42:00', '2018-12-22 15:56:00', 'American Airlines', 'Cedar Rapids', 'United States', 'Chicago', 'United States'),
--   ('Berkie', 'Wycliff', '32B', '2019-02-06 16:28:00', '2019-02-06 19:18:00', 'American Airlines', 'Charlotte', 'United States', 'New Orleans', 'United States'),
--   ('Cory', 'Squibbes', '10D', '2019-01-20 19:30:00', '2019-01-20 22:45:00', 'Avianca Brasil', 'Sao Paolo', 'Brazil', 'Santiago', 'Chile');