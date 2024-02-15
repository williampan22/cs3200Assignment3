-- Query 1: 
-- Create a new Table Music Video, that is a class of type Track (generalization) but adds the attribute Video director. 
-- A music video is a track. There cannot be a video without a track, and each track can have either no video or just one. 

CREATE TABLE IF NOT EXISTS "music_video" (
    "TrackId"	INTEGER NOT NULL,
	"VideoDirector"	TEXT NOT NULL,
	PRIMARY KEY("TrackID"),
	FOREIGN KEY("TrackID") REFERENCES "tracks"("TrackId")
)
