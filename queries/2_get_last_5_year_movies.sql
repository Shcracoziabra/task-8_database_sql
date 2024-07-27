SELECT movie.id, COUNT(person_id) as actors_count, title FROM actor
	RIGHT JOIN movie
	ON person_id = movie.id
	WHERE DATE_TRUNC('year', release_date) + INTERVAL '5 years' >= 
			(DATE_TRUNC('year', (CURRENT_TIMESTAMP)))
	GROUP BY movie.id;



