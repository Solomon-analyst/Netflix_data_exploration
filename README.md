# Netflix_data_exploration
Netflix SQL Analytics Case Study

Title: Uncovering Insights from Netflix Data: An SQL-Based Analysis of User Behavior, Content Performance, and Recommendations

Author: Lateef Solomon 
Date: September 2025

1. Introduction
Streaming services like Netflix generate large amounts of data daily — from movies in their catalog to how users search, watch, and rate content. Analyzing this data helps improve content strategy, personalization, and user engagement.
This project uses SQL to analyze Netflix-like datasets and answer key questions about movies, user activity, searches, reviews, and recommendations.

Datasets used:
•	movies – movie details (title, genre, release year, duration, rating)
•	reviews – user ratings and comments
•	watch_history – user viewing activity
•	search_logs – user search activity
•	recommendation_log – recommendation history

3. Objectives
The project aims to:
1.	Explore the Netflix catalog and review trends.
2.	Analyze user watch and search behavior.
3.	Assess recommendation effectiveness.
4.	Identify improvement opportunities for engagement and satisfaction.
   
3. Methodology
•	Imported 5 datasets into SQL.
•	Explored schema and established primary/foreign key relationships.
•	Designed 20+ SQL queries across descriptive, diagnostic, and analytical levels.
•	Applied different SQL JOINs (INNER, LEFT, RIGHT, FULL) for multi-table analysis.
•	Summarized insights and provided recommendations.

5. Research Questions & Queries
A. Movies
•	How many movies are in the catalog?
•	What is the distribution of movies by genre and release year?
•	What are the top 10 longest movies?
B. Reviews
•	Which movies have the highest average ratings?
•	Which genres have the highest ratings?
•	Who are the top reviewers?
C. Watch History
•	Which movies are most watched?
•	Which users have the longest total watch time (binge-watchers)?
•	What is the average completion rate across movies?
D. Search Logs
•	What percentage of searches return no results?
•	What are the most common search queries?
•	Which users search the most?
E. Recommendation Log
•	Which movies are recommended most frequently?
•	Which recommendation algorithm performs best?
•	Do recommended movies get watched more than non-recommended ones?
F. Multi-table Joins
•	Do recommended movies receive higher ratings than non-recommended ones?
•	Do searches lead to actual watches?
•	Which genres have the highest watch completion rate?
•	Which movies are hidden gems (high ratings but low watch counts)?

7. Results & Insights
Movies:
•	The dataset contains 1000 movies.
•	Most movies belong to Adventure and War genres.
•	The longest movie is [Last Battle, 586 Minutes].
Reviews:
•	Highest-rated movie: [Ice-house, 18].
•	Westerns received the best overall ratings.
•	Top reviewer: User ID 06151 with 5 reviews.
Watch History:
•	Most-watched movie: [A Adventure, 66 Views].
•	Average completion rate: %.
•	Top binge-watcher: User ID 08932 with 13.31 hours.
Search Logs:a
•	Failed searches: X% of total queries.
•	Most common search: [New releases].

9. Recommendations
•	Search Optimization: Reduce failed searches by improving keyword matching and indexing.
•	Content Promotion: Highlight "hidden gems" — movies with high ratings but low watch counts.
•	Recommendation Tuning: Favor Algorithm A in recommendation pipelines.
•	Genre Strategy: Invest more in Documentaries and Animation, as they show high user satisfaction and completion rates.
10. Limitations
•	Data may not reflect Netflix’s global audience.
•	Watch history may exclude partial plays.
•	Sentiment analysis of reviews was not included.

12. Conclusion
This project demonstrates how SQL queries can uncover actionable insights in a streaming platform. From analyzing movie ratings to optimizing recommendations, the study shows how data-driven strategies can enhance user experience and guide business decisions.

