WITH raw_movies AS (
    SELECT * 
    FROM NETFLIX_DB.RAW.RAW_MOVIES
)
SELECT movieId AS movie_id,title,genres
FROM raw_movies