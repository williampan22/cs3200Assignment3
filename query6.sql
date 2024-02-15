-- Query 6:  
-- Define an insightful query on your own that involves at least three tables

-- MY INSIGHTFUL QUERY IS THIS: 
-- LIST ALL THE TRACKS FROM ALL THE PLAYLISTS FROM THE CUSTOMER WHO HAS THE MOST INVOICES

SELECT DISTINCT tracks.TrackId, tracks.Name, playlists.PlaylistId, playlists.Name AS PlaylistName
FROM customers
INNER JOIN invoices ON customers.CustomerId = invoices.CustomerId
INNER JOIN invoice_items ON invoices.InvoiceId = invoice_items.InvoiceId
INNER JOIN tracks ON invoice_items.TrackId = tracks.TrackId
INNER JOIN playlist_track ON tracks.TrackId = playlist_track.TrackId
INNER JOIN playlists ON playlist_track.PlaylistId = playlists.PlaylistId
WHERE customers.CustomerId = (
    SELECT CustomerId
    FROM invoices
    GROUP BY CustomerId
    ORDER BY COUNT(*) DESC
    LIMIT 1
);