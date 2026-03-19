# Digital Music Store - SQL Data Analysis Project

## Project Overview

This project involves a comprehensive data analysis of a digital music store's database using PostgreSQL. The goal is to answer critical business questions and help the store optimize its marketing strategies, employee performance evaluations, and customer targeting.

By analyzing sales data, customer preferences, and employee records, this project transforms raw relational data into actionable business intelligence.

## Tools & Technologies

- **Database:** PostgreSQL and PgAdmin4
- **Concepts Used:** Joins, CTEs, Subqueries, Aggregate Functions, Type Casting, Data Filtering.
- **Visualization/Schema:** Entity-Relationship Diagram (ERD)

## Database Schema

Below is the relational structure of the music store database:
<img width="761" height="614" alt="schema_diagram" src="https://github.com/user-attachments/assets/ffd19d7e-e855-4bba-be53-7ded52778868" />

![schema_diagram.png](attachment:d4a76b67-948b-42d2-800b-2c0a0d6856df:schema_diagram.png)

## Key Business Insights Discovered

1. **Cross-Selling Potential:** Identified the top 10 customers with the most diverse music tastes (purchasing the highest number of distinct genres). These customers are the ideal target audience for new genre/album launches.
2. **Employee Performance:** Calculated the total sales revenue managed by each Support Representative, providing clear metrics for year-end performance reviews.
3. **Targeted Marketing:** Pinpointed the specific city generating the highest revenue, making it the mathematically optimal location for the company's next promotional music festival.

## Repository Structure

- `/dataset`: Contains all the raw CSV files used to build the database.
- `/sql_queries`: Includes the heavily commented SQL script containing all 10 business queries.
- `/images`: Visual assets including the schema diagram.
