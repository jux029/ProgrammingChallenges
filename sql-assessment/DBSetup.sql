-- marketing_data table
create table marketing_data (
 date datetime,
 campaign_id varchar(50),
 geo varchar(50),
 cost float,
 impressions float,
 clicks float,
 conversions float
);

-- website_revenue table
create table website_revenue (
 date datetime,
 campaign_id varchar(50),
 state varchar(2),
 revenue float
);

-- campaign_info table
create table campaign_info (
 id int not null primary key auto_increment,
 name varchar(50),
 status varchar(50),
 last_updated_date datetime
);

-- Import for marketing_data table
LOAD DATA LOCAL INFILE './sql-assessment/marketing_performance.csv'
INTO TABLE marketing_data
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Import for website_revenue table
LOAD DATA LOCAL INFILE './sql-assessment/website_revenue.csv'
INTO TABLE website_revenue
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Import for campaign_info table
LOAD DATA LOCAL INFILE './sql-assessment/campaign_info.csv'
INTO TABLE campaign_info
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


