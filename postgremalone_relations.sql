-- Team Postgre Malone

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
    business_id CHAR(22) NOT NULL,
    cName VARCHAR(100) NOT NULL,
    PRIMARY KEY (business_id, cName),
    FOREIGN KEY (business_id) REFERENCES Business(business_id) ON DELETE CASCADE,
    FOREIGN KEY (cName) REFERENCES Category(cName) ON DELETE CASCADE
);

CREATE TABLE BusinessAttribute (
    attribute_name VARCHAR(100) PRIMARY KEY
);

CREATE TABLE BusinessAttributeValue (
    business_id CHAR(22) NOT NULL,
    attribute_name VARCHAR(100) NOT NULL,
    value VARCHAR(255),
    PRIMARY KEY (business_id, attribute_name),
    FOREIGN KEY (business_id) REFERENCES Business(business_id) ON DELETE CASCADE,
    FOREIGN KEY (attribute_name) REFERENCES BusinessAttribute(attribute_name) ON DELETE CASCADE
);

CREATE TABLE BusinessHours (
    business_id CHAR(22) NOT NULL,
    day VARCHAR(10) NOT NULL CHECK (day IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')),
    openTime TIME,
    closeTime TIME,
    PRIMARY KEY (business_id, day),
    FOREIGN KEY (business_id) REFERENCES Business(business_id) ON DELETE CASCADE
);

CREATE TABLE CheckIn (
    business_id CHAR(22) NOT NULL,
    checkin_time TIMESTAMP NOT NULL,
    PRIMARY KEY (business_id, checkin_time),
    FOREIGN KEY (business_id) REFERENCES Business(business_id) ON DELETE CASCADE
);


CREATE TABLE Users(
 user_id CHAR(22) NOT NULL,
 name VARCHAR NOT NULL,
 yelping_since TIMESTAMP NOT NULL,
 tip_count INTEGER NOT NULL DEFAULT 0,
 fans INTEGER NOT NULL DEFAULT 0,
 average_stars DECIMAL(3,2),
 funny INTEGER NOT NULL DEFAULT 0,
 useful INTEGER NOT NULL DEFAULT 0,
 cool INTEGER NOT NULL DEFAULT 0,
 PRIMARY KEY (user_id)
);

CREATE TABLE Friend (
 user_id CHAR(22) NOT NULL,
 friend_id CHAR(22) NOT NULL,
 PRIMARY KEY (user_id, friend_id),
 FOREIGN KEY (user_id) REFERENCES Users(user_id),
 FOREIGN KEY (friend_id) REFERENCES Users(user_id)
);

CREATE TABLE Tip (
 user_id CHAR(22) NOT NULL,
 "date" TIMESTAMP NOT NULL,
 likes INTEGER NOT NULL DEFAULT 0,
 "text" TEXT,
 business_id CHAR(22) NOT NULL,
 PRIMARY KEY (user_id, business_id, "date"),
 FOREIGN KEY (user_id) REFERENCES Users(user_id),
 FOREIGN KEY (business_id) REFERENCES Business(business_id)
);
