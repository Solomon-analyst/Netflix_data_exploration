CREATE DATABASE Netflix_analysis;

-- MOVIE DATASET
SELECT * FROM movies;

-- Total Movies
SELECT COUNT(DISTINCT movie_id) 
AS Total_Movies FROM movies;

-- Total Movies in each content_type
SELECT content_type, COUNT(movie_id) AS Total_movie
FROM movies
GROUP BY content_type
ORDER BY Total_movie DESC;

SELECT genre_primary, genre_secondary
FROM movies
WHERE genre_primary IS NOT NULL
AND genre_secondary IS NOT NULL;

-- Distribution of content_type with country
SELECT country_of_origin, content_type, COUNT(movie_id) AS total_movie
FROM movies
GROUP BY country_of_origin, content_type
ORDER BY total_movie DESC;

-- Distribtion of movies by genre and release year
SELECT genre_primary, release_year, COUNT(movie_id) AS Total_movies
FROM movies
GROUP BY genre_primary, release_year
ORDER BY Total_movies DESC;

-- Top 10 Longest Movies
SELECT title, duration_minutes, ROUND(duration_minutes/60, 2) AS duration_hours
FROM movies
ORDER BY duration_minutes DESC
LIMIT 10;

-- Rating distribution
SELECT 
CASE
WHEN imdb_rating < 5 THEN 'Average'
WHEN imdb_rating BETWEEN 4 AND 7 THEN 'Good'
ELSE 'Interesting'
END AS Movie_rating,
COUNT(movie_id) AS total_movie
FROM movies
GROUP BY Movie_rating
ORDER BY total_movie DESC;

-- Average rating of all movies
SELECT ROUND(AVG(imdb_rating), 2) AS Average_rating
FROM movies;


-- RECOMMENDATION DATASET
SELECT * FROM recommendation_logs;

-- Total recommendation
SELECT COUNT(DISTINCT recommendation_id)
AS Total_rec FROM recommendation_logs;

-- recommendation distribution by type
SELECT recommendation_type, COUNT(recommendation_id) AS Total_rec
FROM recommendation_logs
GROUP BY recommendation_type
ORDER BY Total_rec DESC;


-- REVIEW DATASET
SELECT * FROM reviews;

-- Total search_logs
SELECT COUNT(*) AS Total_rev
FROM reviews;


-- SEARCH_LOGS DATASET
SELECT * FROM search_logs;

-- Total search_logs
SELECT COUNT(*) AS Total_serc
FROM search_logs;

-- search count by location
SELECT COUNT(search_id) AS search_count, location_country
FROM search_logs
GROUP BY location_country;

-- Top 5 users that search the most
SELECT COUNT(search_id) AS num_search, user_id, location_country
FROM search_logs
GROUP BY user_id, location_country
ORDER BY num_search DESC
LIMIT 5;

-- Top 10 most serched queries
SELECT COUNT(*) AS Search_count, search_query
FROM search_logs
GROUP BY search_query
ORDER BY Search_count DESC
LIMIT 10;

-- percentage of search with no result
SELECT ROUND((SUM(CASE WHEN results_returned = 0 THEN 1 ELSE 0 END) * 100) / COUNT(*), 2)
AS failed_serached_percentage
FROM search_logs;


-- WATCH_HISTORY DATASET
SELECT * FROM watch_history;

SELECT COUNT(*)
AS Total_sess FROM watch_history;

-- change of date datatype
UPDATE watch_history
SET watch_date = STR_TO_DATE(watch_date, '%m/%d/%Y');


-- JOIN QUERIES 

-- movies with the highest watch
SELECT COUNT(wh.session_id) AS watch_count,  mv.title
FROM watch_history AS wh
JOIN movies AS mv
ON wh.movie_id = mv.movie_id
GROUP BY mv.title 
ORDER BY watch_count DESC;

-- Top binge_watchers 
SELECT wh.user_id, wh.watch_duration_minutes, ROUND((wh.watch_duration_minutes/60), 2) AS watch_hours, mv.title
FROM watch_history AS wh
JOIN movies AS mv
ON wh.movie_id = mv.movie_id
GROUP BY mv.title, wh.user_id, wh.watch_duration_minutes
ORDER BY wh.watch_duration_minutes DESC;

-- what % of recommended movies are watched
SELECT ROUND(COUNT(DISTINCT wh.session_id) * 100 / COUNT(DISTINCT rl.movie_id), 2) AS watch_rate
FROM recommendation_logs AS rl
LEFT JOIN watch_history AS wh
ON rl.movie_id = wh.movie_id
AND rl.user_id = wh.user_id;

-- Total movies recommendation in each year
SELECT COUNT(rl.recommendation_id) AS Total_rec, mv.title, mv.release_year
FROM recommendation_logs AS rl
JOIN movies AS mv
ON rl.movie_id = mv.movie_id
GROUP BY mv.title, mv.release_year
ORDER BY Total_rec DESC;

-- Total Movies watched after recommended
SELECT COUNT(recommendation_id) AS num_rec
FROM recommendation_logs AS rl
JOIN watch_history AS wh
ON rl.movie_id = wh.movie_id
AND rl.user_id = wh.user_id;

-- Top 10 movies by average rating
SELECT mv.title, ROUND(AVG(rv.rating)) AS Average_rating
FROM movies AS mv
JOIN reviews AS rv
ON mv.movie_id = rv.movie_id
GROUP BY mv.title
ORDER BY Average_rating DESC
LIMIT 10;

-- genre with the highest average rating
SELECT mv.genre_primary, ROUND(AVG(rv.rating), 2) AS Average_rating
FROM movies AS mv
JOIN reviews AS rv
ON mv.movie_id = rv.movie_id
GROUP BY mv.genre_primary
ORDER BY Average_rating DESC
LIMIT 1;

-- correlation btw watch completion and rating 
SELECT wh.action, ROUND(AVG(rv.rating), 1) AS Avg_rating, mv.title
FROM watch_history AS wh
JOIN reviews AS rv
ON wh.movie_id = rv.movie_id
JOIN movies AS mv
ON rv.movie_id = mv.movie_id
WHERE action = 'completed'
GROUP BY wh.action, mv.title
ORDER BY Avg_rating DESC;

-- which search quesries lead to watch?
SELECT sl.search_query, COUNT(*) AS succesful_search
FROM watch_history AS wh
JOIN search_logs AS sl
ON wh.user_id = sl.user_id
AND sl.search_date <= wh.watch_date 
AND wh.watch_date <= sl.search_date 
GROUP BY sl.search_query;

-- Highly rated but rarely watched
SELECT COUNT(wh.session_id) AS watch_count, ROUND(AVG(rv.rating), 2) AS Avg_rating, mv.title
FROM watch_history AS wh
JOIN reviews AS rv
ON wh.movie_id = rv.movie_id
JOIN movies AS mv
ON rv.movie_id = mv.movie_id
GROUP BY mv.title
ORDER BY Avg_rating DESC;

-- The most common movie duration (mode)
SELECT duration_minutes, COUNT(*) AS Movie_count
FROM movies
GROUP BY duration_minutes
ORDER BY Movie_count DESC
LIMIT 1;

-- The top 5 users who gave the highest average ratings.
SELECT user_id, ROUND(AVG(rating)) AS Avg_rating
FROM reviews
GROUP BY user_id
ORDER BY Avg_rating DESC
LIMIT 5;

-- movies that have at least 3 reviews and average rating > 3.0.
SELECT m.title, COUNT(r.review_id) AS Total_review, ROUND(AVG(r.rating), 1) AS Avg_rating
FROM reviews AS r
JOIN movies AS m
ON r.movie_id = m.movie_id
GROUP BY m.title
HAVING Total_review >= 3 AND Avg_rating > 3
ORDER BY Avg_rating DESC;

-- The top 10 most binge-watched movies (based on action_flag = completed)
SELECT m.title, COUNT(*) AS movie_completion
FROM watch_history AS w
JOIN movies AS m
WHERE w.action = 'completed'
GROUP BY m.title
ORDER BY movie_completion DESC
LIMIT 10;