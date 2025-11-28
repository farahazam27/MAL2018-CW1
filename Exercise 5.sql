-- Exercise 5: View Creation

CREATE VIEW CW1.TrailDetailsView AS
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
FROM CW1.Trail T
INNER JOIN
 CW1.[User] U ON T.User_ID = U.User_ID
INNER JOIN
 CW1.Difficulty D ON T.Difficulty_ID = D.Difficulty_ID
INNER JOIN 
CW1.RouteType R ON T.RouteType_ID = R.RouteType_ID;
GO