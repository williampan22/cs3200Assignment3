-- Query 5:  
-- Write a query that lists all the tracks that are not in one of the top 5 genres with longer duration in the database. 

-- THIS IS HOW I INTERPRETED THIS QUERY (John told me to write how I interpret the query because it was unclear)
-- Select the tracks that are all in the genres except the 5 genres that have the longest average duration song lengths.

SELECT DISTINCT tracks.TrackId, tracks.Name 
FROM tracks
WHERE tracks.GenreId NOT IN (
    SELECT GenreId
    FROM (
        SELECT DISTINCT genres.GenreId, AVG(tracks.Milliseconds) AS AverageDuration
        FROM genres
        INNER JOIN tracks ON genres.GenreId = tracks.GenreId
        GROUP BY genres.GenreId
        ORDER BY AverageDuration DESC
        LIMIT 5
    )
);