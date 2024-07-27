SELECT 
	movie.id,
	title,
	release_date,
	duration,
	description,
	poster,
	director,
	actors,
	genres
FROM movie
LEFT JOIN (
	SELECT id, row_to_json(p) poster
	FROM (SELECT * FROM file) p
) mp
ON mp.id = poster_id
LEFT JOIN (
	SELECT pi.id, row_to_json(pi) director 
	FROM (
		SELECT person.id, first_name, last_name, photo FROM person
		LEFT JOIN (
			SELECT p.id, row_to_json(p) photo 
			FROM (SELECT * FROM file) p
		) pp 
		ON pp.id = person.photo_id
	) pi
) di
ON di.id = director_id
LEFT JOIN (
	SELECT actor.movie_id, jsonb_agg(actor) actors FROM actor
	LEFT JOIN (
		SELECT pi.id, row_to_json(pi) actor 
		FROM (
			SELECT person.id, first_name, last_name, photo FROM person
			LEFT JOIN (
				SELECT p.id, row_to_json(p) photo 
				FROM (SELECT * FROM file) p
			) pp 
			ON pp.id = person.photo_id
		) pi
	) ai
	ON actor.person_id = ai.id
	GROUP BY actor.movie_id
) a
ON a.movie_id = movie.id
LEFT JOIN (
	SELECT movie_id, json_agg(json_build_object('id', genre.id, 'name', name)) genres
		FROM movie_genre
		JOIN genre
		ON genre_id = genre.id
	GROUP BY movie_id
) g
ON g.movie_id = movie.id
WHERE movie.id = 1
