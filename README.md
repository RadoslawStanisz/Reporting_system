## Overview

The goal of this project is to build a reporting system according to specific requirements to track flight delays. 

#### The project structure:

1.	Data engineering

-	Collecting data from API
-	Setting up a database in Postgres
-	Populating a database

Notebooks: `Collect_data`, `Initialize_Db`, `Populate_Db`

2.	Data Analysis

-	Data cleaning
-	EDA 

Notebooks: `Data_Analysis_01`, `Data_Analysis_02`, `Data_Analysis_03`

3.	BI development

-	Building a reporting schema
-	Creating a dashboard

Notebooks: `Building_reporting_schema`, `Building_Dashboard`

#### Dataset

The dataset comes from [Kaggle](https://www.kaggle.com/datasets/threnjen/2019-airline-delays-and-cancellations) and was limited to 97 airports.

#### Tools

Data engineering:
-	Requests – collecting data from API
-	Psycopg2 - database adapter for Python
  
Data analysis and visualization:
-	Pandas
-	Seaborn
  
BI development:
-	Dash
-	Plotly

#### Outcome
The final result of the project is a multipage dashboard developed in Dash. User navigates between visualizations through buttons at the top of the app. A dedicated schema was created in the database with customized views to facilitate data retrieval for the charts.
A `reporting.sql` contains sql queries for building the views and can be found in the project repository under `sql` folder.


![flights](https://github.com/RadoslawStanisz/Reporting_system/assets/136122006/1a35129f-0269-46da-a0ac-54071d73c230)

