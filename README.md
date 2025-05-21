# 📊 Netflix Data Analysis using PostgreSQL (Guided Project)

This project contains a series of SQL queries aimed at analyzing Netflix's content dataset to answer 15 real-world business questions. The queries explore various insights such as content type distribution, most common ratings, content trends over the years, genre analysis, and much more.


![Netflix Banner](https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg)
> 🖼️ **Disclaimer:** The Netflix logo is the property of **Netflix, Inc.** and is used here for educational and illustrative purposes only. I do not claim ownership of the logo or any associated branding.


## 📌 Project Overview

The goal of this project is to explore and analyze the Netflix content dataset using PostgreSQL. It includes writing SQL queries to answer specific business questions, working with string and date functions, aggregations, window functions, and conditional logic.

---

## ❓ Business Questions Answered

1. **Count the number of Movies vs TV Shows**  
2. **Find the most common rating** for Movies and TV Shows  
3. **List all Movies released in a specific year** (e.g., 2020)  
4. **Top 5 countries** with the most content on Netflix  
5. **Identify the longest Movie** based on duration  
6. **Find content added in the last 5 years**  
7. **Get all content directed by Rajiv Chilaka**  
8. **List all TV Shows with more than 5 seasons**  
9. **Count number of content items in each genre**  
10. **Find each year and the average number of content releases in India**  
11. **List all Documentary Movies**  
12. **Find content without a listed director**  
13. **Count movies featuring Salman Khan in the last 10 years**  
14. **Top 10 actors in Indian movies**  
15. **Categorize content as 'Good' or 'Bad'** based on presence of keywords `'kill'` or `'violence'`

---

## 🛠️ SQL Functions and Techniques Used

This PostgreSQL project uses several built-in functions and techniques:

### ✅ String Functions:
- `SPLIT_PART(text, delimiter, position)` – extract parts of a string  
- `STRING_TO_ARRAY(text, delimiter)` – split strings into arrays  
- `UNNEST(array)` – convert arrays into rows  
- `ILIKE` – case-insensitive matching  

### ✅ Date & Time Functions:
- `TO_DATE(string, format)` – convert text to date  
- `EXTRACT(YEAR FROM date)` – extract year from a date  
- `CURRENT_DATE - INTERVAL 'x years'` – calculate time difference  

### ✅ Aggregation & Window Functions:
- `COUNT()`, `ROUND()`, `RANK()` – summarize and rank data  
- `GROUP BY`, `ORDER BY`, `LIMIT` – for grouping and filtering results  

### ✅ Conditional Logic:
- `CASE WHEN` – for creating custom categories (e.g., Good/Bad content)

---

## 📚 What I Learned

Working through this project helped me strengthen my knowledge in:

- Writing **modular and optimized SQL queries** using CTEs (Common Table Expressions)
- Applying **text processing** to handle complex columns like `cast`, `genre`, and `duration`
- Using **window functions** to perform rankings within groups
- Performing **data filtering and transformation** using conditions and pattern matching
- Applying **date logic** to filter recent records
- Performing **trend and category analysis** using `GROUP BY` and aggregations
- Gaining insight into how platforms like Netflix can use SQL for **business decision-making**

---

## Business Problems and Solutions

### 1. Count the Number of Movies vs TV Shows

```sql
SELECT 
    type,
    COUNT(*)
FROM netflix
GROUP BY 1;
```

**Objective:** Determine the distribution of content types on Netflix.

### 2. Find the Most Common Rating for Movies and TV Shows

```sql
WITH RatingCounts AS (
    SELECT 
        type,
        rating,
        COUNT(*) AS rating_count
    FROM netflix
    GROUP BY type, rating
),
RankedRatings AS (
    SELECT 
        type,
        rating,
        rating_count,
        RANK() OVER (PARTITION BY type ORDER BY rating_count DESC) AS rank
    FROM RatingCounts
)
SELECT 
    type,
    rating AS most_frequent_rating
FROM RankedRatings
WHERE rank = 1;
```

**Objective:** Identify the most frequently occurring rating for each type of content.

### 3. List All Movies Released in a Specific Year (e.g., 2020)

```sql
SELECT * 
FROM netflix
WHERE release_year = 2020;
```

**Objective:** Retrieve all movies released in a specific year.

### 4. Find the Top 5 Countries with the Most Content on Netflix

```sql
SELECT * 
FROM
(
    SELECT 
        UNNEST(STRING_TO_ARRAY(country, ',')) AS country,
        COUNT(*) AS total_content
    FROM netflix
    GROUP BY 1
) AS t1
WHERE country IS NOT NULL
ORDER BY total_content DESC
LIMIT 5;
```

**Objective:** Identify the top 5 countries with the highest number of content items.

### 5. Identify the Longest Movie

```sql
SELECT 
    *
FROM netflix
WHERE type = 'Movie'
ORDER BY SPLIT_PART(duration, ' ', 1)::INT DESC;
```

**Objective:** Find the movie with the longest duration.

### 6. Find Content Added in the Last 5 Years

```sql
SELECT *
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';
```

**Objective:** Retrieve content added to Netflix in the last 5 years.

### 7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'

```sql
SELECT *
FROM (
    SELECT 
        *,
        UNNEST(STRING_TO_ARRAY(director, ',')) AS director_name
    FROM netflix
) AS t
WHERE director_name = 'Rajiv Chilaka';
```

**Objective:** List all content directed by 'Rajiv Chilaka'.

### 8. List All TV Shows with More Than 5 Seasons

```sql
SELECT *
FROM netflix
WHERE type = 'TV Show'
  AND SPLIT_PART(duration, ' ', 1)::INT > 5;
```

**Objective:** Identify TV shows with more than 5 seasons.

### 9. Count the Number of Content Items in Each Genre

```sql
SELECT 
    UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre,
    COUNT(*) AS total_content
FROM netflix
GROUP BY 1;
```

**Objective:** Count the number of content items in each genre.

### 10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!

```sql
SELECT 
    country,
    release_year,
    COUNT(show_id) AS total_release,
    ROUND(
        COUNT(show_id)::numeric /
        (SELECT COUNT(show_id) FROM netflix WHERE country = 'India')::numeric * 100, 2
    ) AS avg_release
FROM netflix
WHERE country = 'India'
GROUP BY country, release_year
ORDER BY avg_release DESC
LIMIT 5;
```

**Objective:** Calculate and rank years by the average number of content releases by India.

### 11. List All Movies that are Documentaries

```sql
SELECT * 
FROM netflix
WHERE listed_in LIKE '%Documentaries';
```

**Objective:** Retrieve all movies classified as documentaries.

### 12. Find All Content Without a Director

```sql
SELECT * 
FROM netflix
WHERE director IS NULL;
```

**Objective:** List content that does not have a director.

### 13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years

```sql
SELECT * 
FROM netflix
WHERE casts LIKE '%Salman Khan%'
  AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;
```

**Objective:** Count the number of movies featuring 'Salman Khan' in the last 10 years.

### 14. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India

```sql
SELECT 
    UNNEST(STRING_TO_ARRAY(casts, ',')) AS actor,
    COUNT(*)
FROM netflix
WHERE country = 'India'
GROUP BY actor
ORDER BY COUNT(*) DESC
LIMIT 10;
```

**Objective:** Identify the top 10 actors with the most appearances in Indian-produced movies.

### 15. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords

```sql
SELECT 
    category,
    COUNT(*) AS content_count
FROM (
    SELECT 
        CASE 
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix
) AS categorized_content
GROUP BY category;
```

**Objective:** Categorize content as 'Bad' if it contains 'kill' or 'violence' and 'Good' otherwise. Count the number of items in each category.


## 🧰 Tools & Technologies

- **Database**: PostgreSQL  
- **Language**: SQL  
- **Editor**: PgAdmin / DBeaver / DataGrip / VS Code  
- **Dataset**: Netflix Titles 
---

## 📂 File Included

- `Solutions PSQL script.sql` – Full SQL query set solving all 15 business problems
- `netflix_titles.csv` – Orignal Dataset

---


## 🙏 Acknowledgements

This project was originally created by Zero Analyst (https://github.com/najirh/netflix_sql_project) on GitHub.  
All SQL logic and query structure belong to them. I’ve reused this project purely for learning and practice purposes.


---

## 🚀 How to Run the Project

1. Set up a PostgreSQL environment (e.g., pgAdmin, DBeaver).
2. Create a table called `NETFLIX` and load the Netflix dataset into it.
3. Open the `Solutions PSQL script.sql` file.
4. Execute each query section-by-section to view results.

---


Feel free to fork this repo or reach out if you'd like help visualizing the data using Power BI or Looker Studio!
