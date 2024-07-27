-- start Create enums
CREATE TYPE image_mime_type AS ENUM('image/jpeg', 'image/gif', 'image/bmp', 'image/svg+xml', 'image/png', 'image/webp');
CREATE TYPE role_type AS ENUM('leading', 'supporting', 'background');
CREATE TYPE gender_type AS ENUM('female', 'male', 'other');
-- end Create enums

-- start Create update function
CREATE FUNCTION update_updated_at()
  RETURNS TRIGGER
  LANGUAGE PLPGSQL
AS $$
BEGIN
  NEW.updated_at = current_timestamp;
  RETURN NEW;
END;
$$;
-- end Create update function

-- start Create tables
CREATE TABLE person (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  biography TEXT,
  date_of_birth DATE,
  photo_id INT, 
  gender GENDER_TYPE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE movie_genre (
  id SERIAL PRIMARY KEY,
  genre_id INT NOT NULL,
  movie_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
    
CREATE TABLE "user" (
  id SERIAL PRIMARY KEY,
  username VARCHAR(50) NOT NULL,
  email VARCHAR(50) UNIQUE NOT NULL,
  password VARCHAR(50) NOT NULL,
  person_id INT NOT NULL,
  avatar_id INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE actor (
  person_id INT NOT NULL,
  movie_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE character (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  description TEXT,
  person_id INT,
  movie_id INT NOT NULL,
  role ROLE_TYPE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_movie (
  user_id INT NOT NULL,
  movie_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE person_file (
  person_id INT NOT NULL,
  file_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE country (
  id SERIAL PRIMARY KEY,
  code VARCHAR(3) NOT NULL,
  name VARCHAR(50) NOT NULL,
  full_name VARCHAR(50) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE file (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  mime_type IMAGE_MIME_TYPE NOT NULL,
  key VARCHAR(50) UNIQUE,
  url VARCHAR(50) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE genre (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE movie (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  budget INT,
  release_date DATE,
  duration INT,
  director_id INT,
  poster_id INT,
  country_id INT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- end Create tables

--start Add constraints
ALTER TABLE movie 
  ADD CONSTRAINT fk_movie_file
      FOREIGN KEY(poster_id)
        REFERENCES file(id),
  ADD CONSTRAINT fk_movie_country
      FOREIGN KEY(country_id)
        REFERENCES country(id),
  ADD CONSTRAINT fk_movie_person
      FOREIGN KEY(director_id)
        REFERENCES person(id);

ALTER TABLE person
  ADD CONSTRAINT fk_person_file
    FOREIGN KEY(photo_id)
      REFERENCES file(id);

ALTER TABLE "user" 
  ADD CONSTRAINT fk_user_person
      FOREIGN KEY(person_id)
        REFERENCES person(id),
  ADD CONSTRAINT fk_user_file
      FOREIGN KEY(avatar_id)
        REFERENCES file(id);

ALTER TABLE actor 
  ADD CONSTRAINT fk_role_person
      FOREIGN KEY(person_id)
        REFERENCES person(id),
  ADD CONSTRAINT fk_role_movie
      FOREIGN KEY(movie_id)
        REFERENCES movie(id);

ALTER TABLE character 
  ADD CONSTRAINT fk_character_person
      FOREIGN KEY(person_id)
        REFERENCES person(id),
  ADD CONSTRAINT fk_character_movie
      FOREIGN KEY(movie_id)
        REFERENCES movie(id);

ALTER TABLE person_file 
  ADD CONSTRAINT fk_person
      FOREIGN KEY(person_id)
        REFERENCES person(id),
  ADD CONSTRAINT fk_file
      FOREIGN KEY(file_id)
        REFERENCES file(id);

ALTER TABLE user_movie
  ADD CONSTRAINT fk_user
      FOREIGN KEY(user_id)
        REFERENCES "user"(id),
  ADD CONSTRAINT fk_movie
      FOREIGN KEY(movie_id)
        REFERENCES movie(id);

ALTER TABLE movie_genre
  ADD CONSTRAINT fk_movie
      FOREIGN KEY(movie_id)
        REFERENCES movie(id),
  ADD CONSTRAINT fk_genre
      FOREIGN KEY(genre_id)
        REFERENCES genre(id);
--end Add constraints

-- start Create table update triggers
CREATE TRIGGER movie_update_at_trigger
BEFORE UPDATE ON movie
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER user_update_at_trigger
BEFORE UPDATE ON "user"
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER file_update_at_trigger
BEFORE UPDATE ON file
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER genre_update_at_trigger
BEFORE UPDATE ON genre
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER person_update_at_trigger
BEFORE UPDATE ON person
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER country_update_at_trigger
BEFORE UPDATE ON country
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER character_update_at_trigger
BEFORE UPDATE ON character
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER actor_update_at_trigger
BEFORE UPDATE ON actor
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER movie_genre_update_at_trigger
BEFORE UPDATE ON movie_genre
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER person_file_update_at_trigger
BEFORE UPDATE ON person_file
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER user_movie_update_at_trigger
BEFORE UPDATE ON user_movie
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();
-- end Create table update triggers