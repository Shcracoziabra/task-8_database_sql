SELECT 
	person.id as director_id,
	(first_name || ' ' || last_name) as director_name,
	ROUND(AVG(budget)) as average_budget
FROM person 
	JOIN movie 
	ON person.id = director_id
GROUP BY person.id