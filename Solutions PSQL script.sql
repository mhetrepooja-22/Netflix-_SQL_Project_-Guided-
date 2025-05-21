-- Netflix Data Analysis using SQL
-- Solutions of 15 business problems
-- 1. Count the number of Movies vs TV Shows

SELECT TYPE,
COUNT(*)
FROM
	NETFLIX
GROUP BY
	1
	-- 2. Find the most common rating for movies and TV shows
WITH
	RATINGCOUNTS AS (
		SELECT
			TYPE,
			RATING,
			COUNT(*) AS RATING_COUNT
		FROM
			NETFLIX
		GROUP BY
			TYPE,
			RATING
	),
	RANKEDRATINGS AS (
		SELECT
			TYPE,
			RATING,
			RATING_COUNT,
			RANK() OVER (
				PARTITION BY
					TYPE
				ORDER BY
					RATING_COUNT DESC
			) AS RANK
		FROM
			RATINGCOUNTS
	)
SELECT
	TYPE,
	RATING AS MOST_FREQUENT_RATING
FROM
	RANKEDRATINGS
WHERE
	RANK = 1;

-- 3. List all movies released in a specific year (e.g., 2020)
SELECT
	*
FROM
	NETFLIX
WHERE
	RELEASE_YEAR = 2020
	
	-- 4. Find the top 5 countries with the most content on Netflix
SELECT
	*
FROM
	(
		SELECT
			-- country,
			UNNEST(STRING_TO_ARRAY(COUNTRY, ',')) AS COUNTRY,
			COUNT(*) AS TOTAL_CONTENT
		FROM
			NETFLIX
		GROUP BY
			1
	) AS T1
WHERE
	COUNTRY IS NOT NULL
ORDER BY
	TOTAL_CONTENT DESC
LIMIT
	5
	
	-- 5. Identify the longest movie
SELECT
	*
FROM
	NETFLIX
WHERE
	TYPE = 'Movie'
ORDER BY
	SPLIT_PART(DURATION, ' ', 1)::INT DESC
	
-- 6. Find content added in the last 5 years
SELECT
	*
FROM
	NETFLIX
WHERE
	TO_DATE(DATE_ADDED, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years'


-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT
	*
FROM
	NETFLIX
WHERE
	DIRECTOR ILIKE '%Rajiv Chilaka%'


-- 8. List all TV shows with more than 5 seasons


SELECT
	*
FROM
	NETFLIX
WHERE
	TYPE = 'TV Show'
	AND SPLIT_PART(DURATION, ' ', 1)::INT > 5


-- 9. Count the number of content items in each genre

SELECT
	UNNEST(STRING_TO_ARRAY(LISTED_IN, ',')) AS GENRE,
	COUNT(SHOW_ID)
FROM
	NETFLIX
GROUP BY
	UNNEST(STRING_TO_ARRAY(LISTED_IN, ','))


-- 10.Find each year and the average numbers of content release in India on netflix. Return top 5 year with highest avg content release!

SELECT
	EXTRACT(
		YEAR
		FROM
			TO_DATE(DATE_ADDED, 'Month DD, YYY')
	) AS YEAR,
	COUNT(*) AS YEARLY_CONTENT,
	ROUND(
		COUNT(*)::NUMERIC / (
			SELECT
				COUNT(*)
			FROM
				NETFLIX
			WHERE
				COUNTRY = 'India'
		)::NUMERIC * 100,
		2
	) AS AVG_CONTENT
FROM
	NETFLIX
WHERE
	COUNTRY = 'India'
GROUP BY
	1
ORDER BY
	AVG_CONTENT DESC
LIMIT
	5


-- 11. List all movies that are documentaries

SELECT
	*
FROM
	NETFLIX
WHERE
	TYPE = 'Movie'
	AND LISTED_IN ILIKE '%Documentaries%'




-- 12. Find all content without a director

SELECT
	*
FROM
	NETFLIX
WHERE
	DIRECTOR IS NULL


-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT
	*
FROM
	NETFLIX
WHERE
	CASTS ILIKE '%Salman khan%'
	AND RELEASE_YEAR > EXTRACT(
		YEAR
		FROM
			CURRENT_DATE
	) - 10



-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

SELECT
	UNNEST(STRING_TO_ARRAY(CASTS, ',')) AS ACTORS,
	COUNT(*) AS COUNT
FROM
	NETFLIX
WHERE
	TYPE = 'Movie'
	AND COUNTRY ILIKE '%India%'
GROUP BY
	ACTORS
ORDER BY
	COUNT DESC LIMIT
	10;



-- 15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. Label content containing these keywords as 'Bad' and all other content as 'Good'. Count how many items fall into each category.

WITH
	CTE AS (
		SELECT
			*,
			(
				CASE
					WHEN DESCRIPTION ILIKE 'kill%'
					OR DESCRIPTION ILIKE '%Voilence%' THEN 'Bad'
					ELSE 'Good'
				END
			) AS CATEGORY
		FROM
			NETFLIX
	)
SELECT
	CATEGORY,
	COUNT(CATEGORY)
FROM
	CTE
GROUP BY
	CATEGORY