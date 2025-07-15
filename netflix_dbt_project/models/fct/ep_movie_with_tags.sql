-- models/fct/ep_movie_with_tags.sql

WITH fct_movie_w_tags AS (
    SELECT * 
    FROM {{ ref('dim_movies_with_tags') }}
)

SELECT * 
FROM fct_movie_w_tags
