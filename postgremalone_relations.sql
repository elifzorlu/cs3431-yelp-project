-- Team Postgre Malone 
-- Anand Pagnis Elif Zorlu and Liz Higday 

-- DROP TABLES (reverse order)
DROP TABLE IF EXISTS Tip CASCADE;
DROP TABLE IF EXISTS Friend CASCADE;
DROP TABLE IF EXISTS Users CASCADE;
DROP TABLE IF EXISTS CheckIn CASCADE;
DROP TABLE IF EXISTS BusinessHours CASCADE;
DROP TABLE IF EXISTS BusinessAttributeValue CASCADE;
DROP TABLE IF EXISTS BusinessAttribute CASCADE;
DROP TABLE IF EXISTS BusinessCategory CASCADE;
DROP TABLE IF EXISTS Category CASCADE;
DROP TABLE IF EXISTS Business CASCADE;

-- user, friend, tip

CREATE TABLE Business (
    business_id CHAR(22) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(10),
    postal_code VARCHAR(10),
    latitude FLOAT,
    longitude FLOAT,
    stars FLOAT,
    is_open INT CHECK (is_open IN (0,1)),
    tip_count INT DEFAULT 0
);

CREATE TABLE Category (
    cName VARCHAR(100) PRIMARY KEY
);

CREATE TABLE BusinessCategory (
    business_id CHAR(22),
    cName VARCHAR(100),
    PRIMARY KEY (business_id, cName),
    FOREIGN KEY (business_id) REFERENCES Business(business_id) ON DELETE CASCADE,
    FOREIGN KEY (cName) REFERENCES Category(cName) ON DELETE CASCADE
);

CREATE TABLE BusinessAttributeValue (
    business_id CHAR(22),
    attribute_name VARCHAR(100),
    value VARCHAR(255),
    PRIMARY KEY (business_id, attribute_name),
    FOREIGN KEY (business_id) REFERENCES Business(business_id) ON DELETE CASCADE
);

CREATE TABLE BusinessHours (
    business_id CHAR(22),
    day VARCHAR(10) CHECK (day IN ('monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday')),
    openTime TIME,
    closeTime TIME,
    PRIMARY KEY (business_id, day),
    FOREIGN KEY (business_id) REFERENCES Business(business_id) ON DELETE CASCADE
);

CREATE TABLE CheckIn (
    business_id CHAR(22),
    checkin_time TIMESTAMP,
    PRIMARY KEY (business_id, checkin_time),
    FOREIGN KEY (business_id) REFERENCES Business(business_id) ON DELETE CASCADE
);


CREATE TABLE Users(
 user_id CHAR(22),
 name VARCHAR NOT NULL,
 yelping_since TIMESTAMP NOT NULL,
 tip_count INTEGER DEFAULT 0,
 fans INTEGER DEFAULT 0,
 average_stars DECIMAL(3,2),
 funny INTEGER DEFAULT 0,
 useful INTEGER DEFAULT 0,
 cool INTEGER DEFAULT 0,
 PRIMARY KEY (user_id)
);

CREATE TABLE Friend (
 user_id CHAR(22),
 friend_id CHAR(22),
 PRIMARY KEY (user_id, friend_id),
 FOREIGN KEY (user_id) REFERENCES Users(user_id),
 FOREIGN KEY (friend_id) REFERENCES Users(user_id)
);

CREATE TABLE Tip (
 user_id CHAR(22),
 tipDate TIMESTAMP,
 likes INTEGER DEFAULT 0,
 tipText TEXT,
 business_id CHAR(22),
 PRIMARY KEY (user_id, business_id, tipDate),
 FOREIGN KEY (user_id) REFERENCES Users(user_id),
 FOREIGN KEY (business_id) REFERENCES Business(business_id)
);
