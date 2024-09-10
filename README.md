# Pizza Runner Data Analysis with SQL and Python

## Introduction

Pizza consumption is a global phenomenon with over 115 million kilograms consumed daily worldwide! Danny, a data scientist by profession, realized he could merge his passion for pizza with the gig economy by launching **Pizza Runner**, an Uber-like service for delivering pizzas. With this project, Danny aims to optimize his operations through data analysis and transformation.

## 🌟 Project Overview
This project focuses on answering a series of case study questions related to Pizza Runner's operations using SQL and Python. The goal is to analyze customer orders, runner performance, and ingredient usage to provide actionable insights. The project covers pizza order metrics, customer and runner experience, ingredient optimization, pricing and ratings, and additional data management challenges.

The analysis is performed using both SQL scripts and Python for comparison, allowing you to see how tasks can be accomplished using different languages. The SQL queries are designed for PostgreSQL, and the Python analysis uses pandas and other data manipulation libraries.

### Available Data

- **Runners**: Information about the runners, including registration dates.
- **Customer Orders**: Captures individual pizza orders, including any exclusions and extras.
- **Runner Orders**: Details about delivery orders, including pickup times, distances, durations, and cancellations.
- **Pizza Names**: Contains available pizza types (Meat Lovers, Vegetarian).
- **Pizza Recipes**: Lists the default toppings for each pizza type.
- **Pizza Toppings**: Provides topping names for each topping ID.

## 🔑 Key Highlights
- **Pizza Metrics**: Analyze pizza order quantities, customer behavior, and order details.
- **Runner and Customer Experience**: Evaluate runner performance, delivery times, and customer experience.
- **Ingredient Optimization**: Assess ingredient usage, common exclusions, and extras.
- **Pricing and Ratings**: Calculate total revenue, including extras, and propose a ratings system for runners.
- **Bonus DML Challenges**: Tackle advanced database challenges such as adding new pizzas to the menu and modifying the data structure.

## 🛠️ Tools & Technologies
- **Docker**: Containerize the entire data pipeline for consistency across environments.
- **SQL**: Analyze data with efficient SQL queries for PostgreSQL.
- **Python**: Use Python libraries (`pandas`, `numpy`) to replicate SQL tasks and analyze data.
- **dbt**: Automate data transformations and manage models using dbt for PostgreSQL databases.
- **Jupyter Notebooks**: Document and execute Python analysis in an interactive environment.
- **PostgreSQL**: The relational database system used for SQL queries and analysis.

## 📚 Key Skills Demonstrated
- **Data Manipulation**: Handling large datasets, null values, and missing data with both SQL and Python.
- **Data Transformation with dbt**: Structuring data transformations using dbt models.
- **SQL Query Optimization**: Writing efficient SQL queries to retrieve and transform data.
- **Python Data Analysis**: Replicating SQL tasks using Python to demonstrate versatility in data analysis tools.

## 🚀 Project Structure

### Architecture Overview
- **Docker**: Containerization of the development environment, including PostgreSQL, dbt, and Python.
- **PostgreSQL**: Used as both the source and destination databases.
- **SQL Analysis**: Data is analyzed using PostgreSQL queries stored in SQL scripts.
- **Python Analysis**: Python notebooks replicate the SQL analysis using `pandas` for data manipulation and analysis.
- **dbt Models**: dbt is used to automate data transformation pipelines, leveraging macros and models for efficient data handling.


### ELT Breakdown
1. **Extract**: Pull raw data from Pizza Runner’s database.
2. **Load**: Store intermediary data in SQL tables for further analysis.
3. **Transform**: Use dbt to clean and transform raw data into meaningful insights.


## 📂 Folder Structure
```bash
## Folder Structure

├── `elt_script`                               # ELT scripts and Docker configuration
│   ├── `Dockerfile`                          # Dockerfile for the ELT environment
│   ├── `requirements.txt`                    # Python dependencies for the ELT script
│   ├── `elt_script.py`                       # Python script for ETL processes
│   └── `notebooks/`                          # Jupyter Notebooks for Python analysis
│       ├── `Pizzarunner_notebook.ipynb`          # Example notebook
├── `docker-compose.yml`                      # Docker Compose configuration
├── `runnerdbt_transformations`               # dbt project files
│   ├── `dbt_project.yml`                     # dbt project configuration
│   ├── `macros`                              # Custom dbt macros for transformations
│   │   ├── `calculate_pizza_price.sql`       # SQL script to calculate pizza prices
│   │   ├── `handle_exclusions_extras.sql`    # SQL script to manage exclusions and extras
│   ├── `models`                              # dbt models and configurations
│   │   ├── `Reporting`                      # Reporting models
│         ├── `order_ingredient_changes.sql`       # SQL script for analyzing ingredient changes
│         ├── `order_ingredients_details.sql`      # SQL script for detailed ingredient info
│         ├── `pizza_ingredients.sql`              # SQL script for listing pizza ingredients
│         ├── `pizza_order_profit_summary.sql`     # SQL script to summarize order profits
│         ├── `successful_delivery_summary.sql`    # SQL script to summarize successful deliveries
│   │   ├── `Staging`                       # Staging models
│         ├── `customer_orders_processed.sql`      # Script for processing customer orders
│         ├── `pizza_recipes_processed.sql`        # Script for processing pizza recipes
│         ├── `runner_orders_processed.sql`        # Script for processing runner orders
│         ├── `schema.yml`                         # Schema definitions for dbt models
│         ├── `sources.yml`                        # Source definitions for dbt models
├── `source_db_init`                         # Initialization scripts for the source database
│   ├── `init.sql`                           # SQL file for initializing the source database

```
## How to Run
## Getting Started

### Prerequisites

Ensure you have the following installed:
- Python 3.11
- PostgreSQL
- dbt-core
- dbt-postgres
- Jupyter Notebooks
  
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/shiza16/PizzaRunner-dbt-Pipeline.git
   cd PizzaRunner-dbt-Pipeline
   ```

2. **Build and Run Docker Containers**:
   ```bash
   docker-compose up --build
   ```

3. **Accessing the Destination PostgreSQL Database via Docker**:
   ```bash
   docker exec -it pizzarunner-pipeline-destination_postgres-1 psql -U postgres destination_db
   ```
  - **Listing and Querying Tables**:

   ```bash
      destination_db: \dt
      destination_db: SELECT * FROM runner_orders;
   ```

4. **Access Jupyter Notebooks**:
   
   Open your web browser and navigate to http://localhost:8888 to access Jupyter Notebooks.
   Or run the below command to access the Jupyter notebook container.

   ```bash
    docker exec -it pizzarunner-pipeline-jupyter-1/<container_name> bash
   ```

## DBT Models

Order Summary Table: Contains a cleaned and summarized view of all orders, with any exclusions, extras, and delivery details applied.
Views: Intermediate transformations are available as views for detailed exploration of runners, pizzas, orders, and delivery times.

--------------------------
## Python Notebook Analysis
In addition to the SQL analysis, this project also includes a Python notebook where all the case study questions are solved using Python. Libraries such as **pandas** and **numpy** are used for data manipulation, analysis, and visualization.

The Tasks are organized into the following categories:

1. **Pizza Metrics**:

- Calculate the number of pizzas ordered.
- Analyze customer orders and delivery success.
- Aggregate pizza types and modifications.

2. **Runner and Customer Experience**:

- Analyze runner sign-up periods, delivery times, and distances.
- Investigate relationships between pizza orders and preparation times.
- Calculate successful delivery rates.

3. **Ingredient Optimization**:

- Identify common exclusions and extras.
- Calculate the total usage of each ingredient.

4. **Pricing and Ratings**:

- Calculate total revenue based on pizza prices.
- Evaluate the impact of additional charges for extras.
- Design a new ratings system for runners.
