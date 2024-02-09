# Predicting Layoff Probability in Tech Companies

## Introduction

In this project, I aimed to predict the probability of layoffs in technology companies for the upcoming quarter using a machine learning model. I trained a CatBoost Regressor model to predict whether a company would conduct layoffs in the next quarter.

## Dataset
The dataset includes information such as company names, layoff dates, the number of employees laid off, and other relevant factors.
This dataset was scraped from: https://layoffs.fyi/

## SQL Implementation

- **Data Extraction and Transformation**: I employed SQL queries to extract relevant data from various sources, such as quarterly reports, news articles, and company announcements. This data included information on company names, layoff dates, the number of employees laid off, financial performance metrics, and economic indicators. I then cleaned the data by removing duplicates and handling missing values, ensuring its readiness for further analysis.
- **Table Creation and Management**: To effectively manage the data, I designed and created SQL tables with appropriate schemas. These tables included separate entities for company information, layoff history, financial performance, and economic indicators. By organizing the data into distinct tables, I ensured efficient data management and facilitated subsequent feature engineering for machine learning modeling.
- **Query Optimization**: I optimized SQL queries to enhance efficiency and performance. This involved analyzing query execution plans, leveraging advanced SQL features like window functions and common table expressions (CTEs), and monitoring query performance metrics to ensure optimal database performance.


## Python Implementation
In Python, I seamlessly integrated SQL with the machine learning pipeline to train the model for layoff prediction. Here's how I utilized Python for machine learning modeling:

- **Data Preprocessing**: Using the preprocessed data stored in SQL tables, I loaded the data into Python using Pandas DataFrames. I performed necessary preprocessing steps, such as handling missing values, encoding categorical variables, and scaling numerical features. Additionally, I engineered additional features based on historical layoffs, financial performance, and economic indicators to enhance the predictive power of the model.
- **Model Training**: Leveraging the CatBoost Regressor model from the CatBoost library, I trained the model on the preprocessed data. During model training, I optimized hyperparameters to improve performance and minimize prediction errors.
- **Model Evaluation**: To assess the model's performance, I evaluated its predictive accuracy using metrics such as mean squared error, mean absolute error, and R-squared. This evaluation helped validate the effectiveness of the model in predicting layoff probabilities for tech companies.
- **Prediction**: Finally, I utilized the trained model to predict the probability of layoffs for each tech company in the next quarter. These predictions provided valuable insights for stakeholders and investors, enabling them to make informed decisions regarding workforce management and investment strategies.


## Conclusion
In this project, I aimed to predict the likelihood of layoffs in technology companies for the upcoming quarter using a machine learning model. By leveraging SQL for data preprocessing and organization, along with Python for machine learning modeling, I created a robust framework to achieve this goal.

[![6cfq4v2p.png](https://i.postimg.cc/6qSKnGvv/6cfq4v2p.png)](https://postimg.cc/T5rBX1Qd)

[![tohtq94x.png](https://i.postimg.cc/hGMHVdFt/tohtq94x.png)](https://postimg.cc/FfdW41sM)
