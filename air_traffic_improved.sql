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

