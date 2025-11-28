-- Exercise 6: Stored Procedure (CRUD)

CREATE PROCEDURE CW1.AddTrail
    @User_ID INT,
    @Difficulty_ID INT,
    @RouteType_ID INT,
    @Trail_Name VARCHAR(200),
    @Description VARCHAR(MAX),
    @Length_km DECIMAL(4,1),
    @Start_Location VARCHAR(255),
    @End_Location VARCHAR(255)
AS
BEGIN
    INSERT INTO CW1.Trail 
        (User_ID, Difficulty_ID, RouteType_ID, Trail_Name, Description, Length_km, Start_Location, End_Location, Date_Created)
    VALUES 
        (@User_ID, @Difficulty_ID, @RouteType_ID, @Trail_Name, @Description, @Length_km, @Start_Location, @End_Location, GETDATE());
END;
GO

EXEC CW1.AddTrail 
    @User_ID = 1,
    @Difficulty_ID = 2,
    @RouteType_ID = 1,
    @Trail_Name = 'Test Trail',
    @Description = 'Testing and procedure',
    @Length_km = 4.5,
    @Start_Location = 'Start Point',
    @End_Location = 'End Point';
GO

CREATE PROCEDURE CW1.GetTrail
    @Trail_ID INT 
AS
BEGIN
    SELECT 
        T.Trail_ID,
        T.Trail_Name,
        T.Description,
        T.Length_km,
        T.Start_Location,
        T.End_Location,
        T.Date_Created,
        U.User_Name,
        U.User_Email,
        D.Difficulty_Name,
        R.RouteType_Name

    FROM 
        CW1.Trail T
    INNER JOIN CW1.[User] U ON T.User_ID = U.User_ID
    INNER JOIN CW1.Difficulty D ON T.Difficulty_ID = D.Difficulty_ID
    INNER JOIN CW1.RouteType R ON T.RouteType_ID = R.RouteType_ID
    WHERE T.Trail_ID = @Trail_ID;
END;
GO

CREATE PROCEDURE CW1.UpdateTrail
    @Trail_ID INT ,
    @Trail_Name NVARCHAR(200),
    @Description NVARCHAR(MAX),
    @Length_km DECIMAL(4,1)
AS
BEGIN
    UPDATE CW1.Trail
    SET
        Trail_Name = @Trail_Name,
        Description = @Description,
        Length_km = @Length_km
    WHERE 
        T.Trail_ID = @Trail_ID;
END;
GO

EXEC CW1.UpdateTrail
    @Trail_ID = 1,
    @Trail_Name = 'Updated Trail',
    @Description = 'Updated description',
    @Length_km = 6.2;
GO

CREATE PROCEDURE CW1.DeleteTrail
    @Trail_ID INT
AS
BEGIN
    DELETE FROM CW1.Trail
    WHERE Trail_ID = @Trail_ID;
END;
GO

EXEC CW1.DeleteTrail @Trail_ID = 2;
GO
