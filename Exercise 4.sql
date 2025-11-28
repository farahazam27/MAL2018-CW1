--EXERCISE 4: SQL

-- database and schema creation

CREATE DATABASE MAL2017;
GO
CREATE SCHEMA CW1;
GO

-- tables creation

CREATE TABLE CW1.[User] (
    User_ID INT IDENTITY(1,1) PRIMARY KEY,
    User_Name VARCHAR(100) NOT NULL,
    User_Email VARCHAR(150) NOT NULL UNIQUE,
    Role VARCHAR(50) NOT NULL,
);
GO

CREATE TABLE CW1.Difficulty (
    Difficulty_ID INT IDENTITY(1,1) PRIMARY KEY,
    Difficulty_Name VARCHAR(50) NOT NULL,
);
GO

CREATE TABLE CW1.RouteType (
    RouteType_ID INT IDENTITY(1,1) PRIMARY KEY,
    RouteType_Name VARCHAR(50) NOT NULL,
);
GO

CREATE TABLE CW1.Trail (
    Trail_ID INT IDENTITY(1,1) PRIMARY KEY, 
    User_ID INT NOT NULL,
    Difficulty_ID INT NOT NULL,
    RouteType_ID INT NOT NULL,
    Trail_Name VARCHAR(200) NOT NULL,
    Description VARCHAR(MAX),
    Length_km DECIMAL(4,2) NOT NULL,
    Start_Location VARCHAR(200) NOT NULL,
    End_Location VARCHAR(200) NOT NULL,
    Date_Created DATE DEFAULT GETDATE(),

    FOREIGN KEY (User_ID) REFERENCES CW1.[User](User_ID),
    FOREIGN KEY (Difficulty_ID) REFERENCES CW1.Difficulty(Difficulty_ID),
    FOREIGN KEY (RouteType_ID) REFERENCES CW1.RouteType(RouteType_ID)
);
GO

CREATE TABLE CW1.Coordinates (
    Coordinate_ID INT IDENTITY(1,1) PRIMARY KEY,
    Trail_ID INT NOT NULL,
    Latitude DECIMAL(9,6) NOT NULL,
    Longitude DECIMAL(9,6) NOT NULL,

    FOREIGN KEY (Trail_ID) REFERENCES CW1.Trail(Trail_ID)
);
GO

CREATE TABLE CW1.Review (
    Review_ID INT IDENTITY(1,1) PRIMARY KEY,
    Trail_ID INT NOT NULL,
    User_ID INT NOT NULL,
    Rating INT NOT NULL,
    Comment VARCHAR(MAX),

    FOREIGN KEY (Trail_ID) REFERENCES CW1.Trail(Trail_ID),
    FOREIGN KEY (User_ID) REFERENCES CW1.[User](User_ID)
);
GO

  CREATE TABLE CW1.TrailLog (
    Log_ID INT IDENTITY(1,1) PRIMARY KEY,
    Trail_ID INT NOT NULL,
    User_ID INT NOT NULL,
    Date_Logged DATE DEFAULT GETDATE(),

    	CONSTRAINT FK_TrailLog_Trail
FOREIGN KEY (Trail_ID) REFERENCES CW1.Trail(Trail_ID),
	CONSTRAINT FK_TrailLog_User
   		 FOREIGN KEY (User_ID) REFERENCES CW1.[User](User_ID)
);
GO

-- insertion demo

INSERT INTO CW1.[User] (User_Name, User_Email, Role)
VALUES
('Ada Lovelace', 'grace@plymouth.ac.uk', 'user'),
('Tim Berners-Lee', 'tim@plymouth.ac.uk', 'admin'),
('Ada Lovelace', 'grace@plymouth.ac.uk', 'user');
GO

INSERT INTO CW1.Difficulty (Difficulty_Name)
VALUES
('Easy'),
('Moderate'),
('Hard');
GO

INSERT INTO CW1.RouteType (RouteType_Name)
VALUES
('Loop'),
('Out & Back'),
('Point to Point');
GO

INSERT INTO CW1.Trail 
(Trail_Name, Description, Length_km, Start_Location, End_Location, Date_Created, Difficulty_ID, RouteType_ID, User_ID)
VALUES
('Plymbridge Circular', 'Scenic woodland trail with views of viaduct.', 3.2,
'Plymbridge Car Park', 'Plymbridge Viaduct', GETDATE(), 2, 1, 1);
GO

INSERT INTO CW1.Coordinates (Trail_ID, Latitude, Longitude)
VALUES
(1, 50.3971, -4.0691),
(1, 50.3862, -4.0704),
(1, 50.3990, -4.0710);
GO

INSERT INTO CW1.Review (Trail_ID, User_ID, Rating, Comment)
VALUES
(1, 1, 5, 'Beautiful scenery and easy route.');
GO