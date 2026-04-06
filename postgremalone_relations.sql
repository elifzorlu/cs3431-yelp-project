-- Team Postgre Malone

-- DROP TABLES (reverse order)
DROP TABLE IF EXISTS Tip CASCADE;
DROP TABLE IF EXISTS Friend CASCADE;
DROP TABLE IF EXISTS Users CASCADE;

-- user, friend, tip

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
 business_id CHAR(22) NOT NULL,
 date TIMESTAMP NOT NULL,
 likes INTEGER NOT NULL DEFAULT 0,
 text TEXT,
 PRIMARY KEY (user_id, business_id, date),
 FOREIGN KEY (user_id) REFERENCES Users(user_id),
 FOREIGN KEY (business_id) REFERENCES Business(business_id)
);

