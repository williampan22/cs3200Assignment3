-- Query 4:  
-- Write a query that lists all the customers that listen to longer-than-average tracks, 
-- excluding the tracks that are longer than 15 minutes. 

-- there are 1000 milliseconds in a second

SELECT DISTINCT customers.CustomerId, customers.FirstName, customers.LastName
FROM customers
INNER JOIN invoices ON customers.CustomerId = invoices.CustomerId
INNER JOIN invoice_items ON invoices.InvoiceId = invoice_items.InvoiceId
INNER JOIN tracks ON invoice_items.TrackId = tracks.TrackId
WHERE tracks.Milliseconds < 60*15*1000 AND tracks.Milliseconds > (SELECT AVG(Milliseconds) FROM tracks);