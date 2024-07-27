SELECT person.id, first_name, last_name, total_movies_budget 
	FROM person
	JOIN(
		SELECT person_id, 
		SUM(movie.budget) as total_movies_budget 
		FROM actor
		JOIN movie
		ON movie_id = movie.id
		GROUP BY person_id
	)
	ON person.id = person_id


