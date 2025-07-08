Select * from employee
order by levels desc
limit 1

Select count(*) as c ,billing_country
from invoice
Group by billing_country 
order by c desc
limit 1

Select total from invoice 
order by total desc
limit 3

Select SUM(total) as invoice_total,billing_city 
from invoice
group by billing_city
order by invoice_total desc

select customer.customer_id,customer.first_name,customer.last_name , sum(invoice.total) as total
from customer
join invoice on customer.customer_id=invoice.customer_id
group by customer.customer_id
order by total desc
limit 1
----------------

select distinct email,first_name,last_name from customer 
join invoice on customer.customer_id=invoice.customer_id
join invoice_line on invoice.invoice_id=invoice_line.invoice_id
join track on invoice_line.track_id=track.track_id
join genre on track.genre_id=genre.genre_id
where genre.name = 'Rock'
order by email;

select artist.artist_id,artist.name,count(artist.artist_id) as number_of_songs
from track
join album on track.album_id = album.album_id
join artist on album.artist_id=artist.artist_id
join genre on track.genre_id=genre.genre_id
where genre.name ='Rock'
group by artist.artist_id 
order by number_of_songs desc
limit 10

select name , milliseconds from track
where milliseconds > (
Select avg(milliseconds) as avg_track_length
from track)
order by milliseconds desc
----------

WITH best_selling_artist AS (
Select artist.artist_id as artist_id,artist.name as artist_name,sum(invoice_line.unit_price*invoice_line.quantity)as c
from invoice_line
join track on invoice_line.track_id=track.track_id
join album on track.album_id=album.album_id
join artist on album.artist_id=artist.artist_id
group by 1
order by 3 desc
limit 1
)
select c.customer_id, c.first_name,c.last_name,bsa.artist_name,SUM(il.unit_price * il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY 1, 2, 3, 4
ORDER BY 5 DESC

 