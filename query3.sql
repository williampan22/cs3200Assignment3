-- Query 3:  
-- Insert another video for the track "Voodoo", assuming that you don't know the TrackId, 
-- so your insert query should specify the TrackId directly.

INSERT INTO music_video (TrackId, VideoDirector)
SELECT TrackId, 'John Alexis Guerra Gomez'
FROM tracks
WHERE Name = 'Voodoo';