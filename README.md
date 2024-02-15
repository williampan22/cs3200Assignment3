## AUTHOR: WILLIAM PAN

## Query 1: 
## Create a new Table Music Video, that is a class of type Track (generalization) but adds the attribute Video director. 
## A music video is a track. There cannot be a video without a track, and each track can have either no video or just one. 

CREATE TABLE "music_video" (
    "trackId"	INTEGER NOT NULL,
	"videoDirector"	TEXT NOT NULL,
	PRIMARY KEY("trackID"),
	FOREIGN KEY("trackID") REFERENCES "tracks"("TrackId")
)

## Query 2: 
## Write the queries that insert at least 10 videos, respecting the problem rules.

INSERT INTO music_video (trackId, videoDirector) VALUES (1, 'William Pan');
INSERT INTO music_video (trackId, videoDirector) VALUES (2, 'Danny Does');
INSERT INTO music_video (trackId, videoDirector) VALUES (3, 'John Gomez');
INSERT INTO music_video (trackId, videoDirector) VALUES (4, 'Ellen Spertus');
INSERT INTO music_video (trackId, videoDirector) VALUES (5, 'Susan Wang');
INSERT INTO music_video (trackId, videoDirector) VALUES (6, 'Alex Gomez');
INSERT INTO music_video (trackId, videoDirector) VALUES (7, 'Aarsh Wang');
INSERT INTO music_video (trackId, videoDirector) VALUES (8, 'Samyutha Srinivasan');
INSERT INTO music_video (trackId, videoDirector) VALUES (9, 'Rhianna Star');
INSERT INTO music_video (trackId, videoDirector) VALUES (10, 'Rangoli Goyal');

## Query 3:  
## Insert another video for the track "Voodoo", assuming that you don't know the TrackId, 
## so your insert query should specify the TrackId directly.

INSERT INTO music_video (trackId, videoDirector)
SELECT TrackId, 'John Alexis Guerra Gomez'
FROM tracks
WHERE Name = 'Voodoo';

## Query 4:  
## Write a query that lists all the customers that listen to longer#than#average tracks, 
## excluding the tracks that are longer than 15 minutes. 

## there are 1000 milliseconds in a second

SELECT DISTINCT customers.CustomerId, customers.FirstName, customers.LastName
FROM customers
INNER JOIN invoices ON customers.CustomerId = invoices.CustomerId
INNER JOIN invoice_items ON invoices.InvoiceId = invoice_items.InvoiceId
INNER JOIN tracks ON invoice_items.TrackId = tracks.TrackId
WHERE tracks.Milliseconds < 60*15*1000 AND tracks.Milliseconds > (SELECT AVG(Milliseconds) FROM tracks);

## Query 5:  
## Write a query that lists all the tracks that are not in one of the top 5 genres with longer duration in the database. 

## THIS IS HOW I INTERPRETED THIS QUERY (John told me to write how I interpret the query because it was unclear)
## Select the tracks that are all in the genres except the 5 genres that have the longest average duration song lengths.

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

## Query 6:  
## Define an insightful query on your own that involves at least three tables

## MY INSIGHTFUL QUERY IS THIS: 
## LIST ALL THE TRACKS FROM ALL THE PLAYLISTS FROM THE CUSTOMER WHO HAS THE MOST INVOICES

SELECT DISTINCT tracks.TrackId, tracks.Name, playlists.PlaylistId, playlists.Name AS PlaylistName
FROM customers
JOIN invoices ON customers.CustomerId = invoices.CustomerId
JOIN invoice_items ON invoices.InvoiceId = invoice_items.InvoiceId
JOIN tracks ON invoice_items.TrackId = tracks.TrackId
JOIN playlist_track ON tracks.TrackId = playlist_track.TrackId
JOIN playlists ON playlist_track.PlaylistId = playlists.PlaylistId
WHERE customers.CustomerId = (
    SELECT CustomerId
    FROM invoices
    GROUP BY CustomerId
    ORDER BY COUNT(*) DESC
    LIMIT 1
);
