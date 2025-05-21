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

## 🧰 Tools & Technologies

- **Database**: PostgreSQL  
- **Language**: SQL  
- **Editor**: PgAdmin / DBeaver / DataGrip / VS Code  
- **Dataset**: Netflix Titles 
---

## 📂 File Included

- `Solutions PSQL script.sql` – Full SQL query set solving all 15 business problems

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
