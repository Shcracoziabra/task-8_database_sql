SELECT username, ARRAY_AGG(movie_id) as favorite_movie_ids 
	FROM "user"
	LEFT JOIN user_movie
	ON "user".id = user_id
GROUP BY username;

	