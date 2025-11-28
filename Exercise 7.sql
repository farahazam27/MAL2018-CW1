-- Exercise 7: Trigger

CREATE TRIGGER CW1.Trigger_TrailAdded
ON CW1.Trail
AFTER INSERT
AS
BEGIN
    INSERT INTO CW1.TrailLog (Trail_ID, User_ID)
    SELECT Trail_ID, User_ID
    FROM inserted;
END;
GO

EXEC CW1.AddTrail
    @User_ID = 2;
    @Difficulty_ID = 1,
    @RouteType_ID = 2,
    @Trail_Name = 'Trigger Test Trail',
    @Description = 'This is to test the trigger',
    @Length_km = 2.8,
    @Start_Location = 'Trigger Start',
@End_Location = 'Trigegr End';
GO