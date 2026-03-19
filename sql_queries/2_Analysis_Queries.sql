/*******************************************************************************
   SQL Project: Digital Music Store Analysis
   Author: İrem AKYOL
   Date: 19.03.2026
   Description: This script contains a series of business-driven SQL queries
                developed to analyze a digital music store's database.
                It covers employee hierarchy, sales performance, customer
                segmentation, and artist analysis.
*******************************************************************************/

-- ==============================================================================
-- PART 1: General Business Overview & Sales Analysis
-- ==============================================================================
--Q1: Who is the most senior employee based on job title level?
-- This helps in understanding the leadership hierarchy for administrative requests.
SELECT *
FROM employee
ORDER BY levels DESC
LIMIT 1;

--Q2: Which country has the highest number of invoices?
-- Identified for target market expansion analysis.
SELECT COUNT(*), billing_country
FROM invoice 
GROUP BY billing_country
ORDER BY count DESC
LIMIT 1;

--Q3: What are the top 3 values of total invoice?
-- To understand high-value transaction outliers.
SELECT total
FROM invoice
ORDER BY total DESC
LIMIT 3;

--Q4: Which city generated the highest sum of invoice totals?
-- This city is proposed as the location for a promotional music festival.
SELECT billing_city, SUM(total) AS invoice_total
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total DESC
LIMIT 1;

-- ==============================================================================
-- PART 2: Customer & Artist Deep Dive
-- ==============================================================================
--Q5: ho is the best customer (spent the most money)?
-- Target for a potential loyalty program.
SELECT i.customer_id, c.first_name, c.last_name, SUM(i.total) AS invoice_total
FROM invoice AS i INNER JOIN customer AS c ON i.customer_id=c.customer_id 
GROUP BY i.customer_id, c.first_name, c.last_name
ORDER BY invoice_total DESC
LIMIT 1;

--Q6: Return the contact details (Email, Name) and primary genre of all Rock Music listeners.
-- Used to build a targeted email marketing list for upcoming Rock releases.
SELECT c.email, c.first_name, c.last_name
FROM genre g INNER JOIN track t ON g.genre_id=t.genre_id
	INNER JOIN invoice_line il ON t.track_id=il.track_id
	INNER JOIN invoice i ON il.invoice_id=i.invoice_id
	INNER JOIN customer c ON i.customer_id=c.customer_id
WHERE g.name= 'Rock'
GROUP BY c.email,c.first_name, c.last_name
ORDER BY c.email ASC;

--Q7: Identify the top 10 Rock bands/artists by total track count.
-- For potential exclusive partnership negotiations.
SELECT ar.artist_id, ar.name, COUNT(ar.artist_id) AS num_of_songs
FROM artist ar JOIN album a ON ar.artist_id=a.artist_id
			JOIN track t ON a.album_id=t.album_id
			JOIN genre g ON t.genre_id=g.genre_id
WHERE g.name= 'Rock'
GROUP BY ar.artist_id
ORDER BY num_of_songs DESC
LIMIT 10;

--Q8: Return all track names longer than the average song length.
-- For analyzing content diversity and listener engagement patterns.
SELECT name, milliseconds
FROM track
WHERE milliseconds > (SELECT AVG(milliseconds) AS avg_track_leng
						FROM track)
ORDER BY milliseconds DESC;

-- ==============================================================================
-- PART 3: Custom "Signature" Insights (Added for Advanced Analysis)
-- ==============================================================================
--Q9: Identifying Customers with High Cross-Sell Potential.
-- Finds customers who have purchased the highest number of *distinct* genres.
-- Insight: These customers are open to diverse music styles; prioritize them for new genre launches.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(DISTINCT g.genre_id) as total_distinct_genres
FROM genre g INNER JOIN track t ON g.genre_id=t.genre_id
	INNER JOIN invoice_line il ON t.track_id=il.track_id
	INNER JOIN invoice i ON il.invoice_id=i.invoice_id
	INNER JOIN customer c ON i.customer_id=c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_distinct_genres DESC
LIMIT 10;

--Q10: Support Representative Performance Analysis.
-- Calculates total revenue managed by each Sales Support Rep.
-- Note: Requires type casting (::INTEGER) on employee_id for joining.
-- Insight: Used for performance evaluation and incentive planning.
SELECT e.employee_id, e.first_name, e.last_name, e.title, SUM(i.total) as total_sales_managed
FROM employee e JOIN customer c ON e.employee_id::INTEGER = c.support_rep_id
				JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY e.employee_id, e.first_name, e.last_name, e.title
ORDER BY total_sales_managed DESC;