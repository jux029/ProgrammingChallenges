### Understanding the Objective of the Project

1. **Explore the Relationships Among the Datasets**:
   - The `campaign_id` serves as a key to map related data across tables.
   - The data provides insights into campaign performance metrics, among other details.
2. **Showcase SQL Queries**: 
   - This project aims to demonstrate advanced SQL querying capabilities and data analysis.

---

### Steps to Approach This Project

1. Fork and Clone Project from GitHub
2. Set Up a Local MySQL Server: Opt for a local MySQL server which is beneficial for fast prototyping and easy testing.
3. Import Data: Use the provided `DBSetup.sql` script to facilitate importing data from the CSV files.
4. Answer Questions: Analyze the data and construct relevant SQL queries to draw insights and answer questions posed in the project.
5. Test SQL Scripts: Ensure that the SQL scripts run correctly and provide the desired outputs.
6. Upload to GitHub

---

### Local MySQL Database vs Cloud Database

Pick Local MySQL Database because:
   - **Simplicity**: Setting up and managing a local MySQL server is straightforward.
   - **Cost**: A local server might be more cost-effective, especially for small-scale projects.
   - **Latency**: There's virtually no latency when accessing a local database, as opposed to potential network delays with cloud databases.
   - **Control & Privacy**: Maintain full control over the infrastructure and ensure data privacy, especially if sensitive data is involved.

While cloud databases offer numerous advantages, such as scalability, built-in backups, and remote accessibility, the requirements and constraints of this project made a local MySQL database a more suitable and pragmatic choice.


---

### Concerns

1. **Scope of Revenue Data**:
   - The dataset for revenue is somewhat limited and might not paint a complete picture of a campaign's efficiency.
   - Not all daily ad revenues align perfectly with daily ad spend data, leading to potential discrepancies in analysis.


---



# SQL Challenge

The database contains three tables: marketing_performance, website_revenue, and campaign_info. Refer to the CSV
files to understand how these tables have been created.

`marketing_performance` contains daily ad spend and performance metrics -- impression, clicks, and conversions -- by campaign_id and location:
```sql
create table marketing_data (
 date datetime,
 campaign_id varchar(50),
 geo varchar(50),
 cost float,
 impressions float,
 clicks float,
 conversions float
);
```

`website_revenue` contains daily website revenue data by campaign_id and state:
```sql
create table website_revenue (
 date datetime,
 campaign_id varchar(50),
 state varchar(2),
 revenue float
);
```

`campaign_info` contains attributes for each campaign:
```sql
create table campaign_info (
 id int not null primary key auto_increment,
 name varchar(50),
 status varchar(50),
 last_updated_date datetime
);
```

### Challenge Submit Instructions

1. Fork the repository
2. Answer the questions below in a single SQL file - e.g answers.sql
3. Provide Link to Forked Repository to PMG PMG Talent Acquisition Team

### Please provide a SQL statement for each question

1. Write a query to get the sum of impressions by day.
2. Write a query to get the top three revenue-generating states in order of best to worst. How much revenue did the third best state generate?
3. Write a query that shows total cost, impressions, clicks, and revenue of each campaign. Make sure to include the campaign name in the output.
4. Write a query to get the number of conversions of Campaign5 by state. Which state generated the most conversions for this campaign?
5. In your opinion, which campaign was the most efficient, and why?

**Bonus Question**

6. Write a query that showcases the best day of the week (e.g., Sunday, Monday, Tuesday, etc.) to run ads.





