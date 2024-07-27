SELECT 
	movie_id as id,
	movie.title,
	release_date,
	duration,
	description,
	jsonb_build_object('file_id', file.id, 'name', file.name, 'mime_type', mime_type, 'key', key, 'url', url) as poster,
	jsonb_build_object('id', director_id, 'first_name', first_name, 'last_name', last_name) as director
	FROM genre
		JOIN movie_genre 
		ON genre.id = genre_id
		JOIN movie
		ON movie.id = movie_id
		JOIN person 
		ON person.id = director_id
		JOIN file
		ON file.id = poster_id
WHERE genre.name IN ('action', 'drama')
	AND country_id = 2
	AND EXTRACT('year' FROM release_date) >= 2022
	AND duration > (2 * 60 + 15)