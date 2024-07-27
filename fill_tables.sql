
-- Execute one-by-one to omit problems with using common sequence for creating ids

INSERT INTO genre (name)
VALUES 
	('comedy'),
	('drama'),
	('action'),
	('historical'),
	('fantasy');

INSERT INTO country (code, name, full_name)
VALUES 
	('UKR', 'UKRAINE', 'UKRAINE'),
	('BEL', 'Belgium', 'Kingdom of Belgium'),
	('JPN', 'Japan', 'Japan');

INSERT INTO file (name, mime_type, key, url)
VALUES 
	('flower.jpg', 'image/jpeg', 'flowerkey', 'http://s3-external-1.amazonaws.com/bucket/flower'),
	('smiley.webp', 'image/webp', 'smileykey', 'http://s3-external-1.amazonaws.com/bucket/smiley'),
	('avatar.png', 'image/png', 'avatarkey', 'http://s3-external-1.amazonaws.com/bucket/avatar');

INSERT INTO person (first_name, last_name, date_of_birth, gender, photo_id)
VALUES 
	('Tito', 'Tatiti', '1968-10-12', 'male', 1),
	('Ana', 'Tatiti', '1960-11-12', 'female', NULL),
	('Nemo', 'Nemo', '2000-01-18', 'other', 1);

INSERT INTO movie (title, description, budget, release_date, duration, director_id, poster_id, country_id)
VALUES 
	('Japan movie 1', 'description', 1800007, '2022-01-01', 162, 2, 2, NULL),
	('Japan movie 2', 'description', 1205454, '2015-01-01', 120, 2, NULL, 3),
	('Japan movie 3', 'description', 1805, '2020-01-01', 10, NULL , NULL, 3),
	('Ukraine movie 1', 'description u', 222000, '2002-01-01', 142, 1, 1, 1),
	('Ukraine movie 2', 'description o', 1855200, '2023-01-01', 122, 2, 3, 1),
	('Belgian movie 1', 'description',NULL,'2024-01-01', 122, 3, NULL, 2);

INSERT INTO character (name, person_id, movie_id, type, description)
VALUES 
	('Hatiko', NULL, 1, 'leading', 'barking and funny'),
	('Avrora', 2, 3, 'supporting', NULL),
	('Bagabaga', 3, 1, 'background', 'character description'),
	('Hato', NULL, 1, 'leading', 'bar funny'),
	('Avrora', 2, 3, 'supporting', NULL),
	('Babga', NULL, 4, 'background', 'character description'),
	('Riko', NULL, 5, 'leading', 'frightfully funny'),
	('Avugk', 2, 6, 'supporting', NULL),
	('Doi hoi', 3, 4, 'leading', 'character description');

INSERT INTO "user" (username, email, password, person_id)
VALUES 
	('tit0@68', 'tito@mail.com', 'secret', 1),
	('splash', 'nemo-nemo@mail.com', 'pass1111', 3);

INSERT INTO person_file (person_id, file_id)
VALUES 
	(2, 1),
	(3, 1),
	(2, 3),
	(1, 3),
	(3, 3),
	(2, 2),
	(3, 2);

INSERT INTO movie_genre (movie_id, genre_id)
VALUES 
	(2, 1),
	(2, 3),
	(4, 1),
	(2, 5),
	(3, 4),
	(6, 5),
	(5, 3),
	(1, 2);

INSERT INTO user_movie (user_id, movie_id)
VALUES 
	(2, 1),
	(2, 3),
	(1, 1),
	(2, 6),
	(2, 4),
	(2, 5),
	(1, 3),
	(2, 2);

INSERT INTO actor (person_id, movie_id)
VALUES 
	(2, 1),
	(2, 3),
	(3, 1),
	(2, 4),
	(3, 5),
	(2, 6),
	(3, 4),
	(1, 6),
	(1, 4);