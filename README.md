# Credit Card Customer Report (Power BI + MySQL)

A Power BI dashboard that analyses credit card revenue and customer data. The data is stored in MySQL and loaded into Power BI using an ODBC connection.

![Dashboard](screenshots/dashboard.png)

## What this project shows
- Total Revenue, Total Interest, Total Income and Customer Satisfaction Score (CSS)
- Revenue by gender over time (weekly)
- Revenue by age group, salary group, dependent count, marital status, education level and top 5 states
- Revenue, transactions and income by customer job
- Filters for quarter, week, income group and card category

## Tools used
- MySQL (database)
- MySQL ODBC driver (connection)
- Power BI Desktop (Power Query, data model, DAX, visuals)

## Data
Two tables in the MySQL database `ccdb_pbi_project`, about 10,108 rows each:

| Table | Source file | Content |
|---|---|---|
| `cc_details` | credit_card.csv | card category, annual fees, credit limit, transactions, interest |
| `cust_details` | customer.csv | age, gender, job, income, education, marital status, satisfaction score |

The tables are joined on `Client_Num` (one customer to many card records).

## How I built it
1. Created the database and imported both CSV files into MySQL (see `sql/create_tables.sql`).
2. Connected Power BI to MySQL using **ODBC** (Get Data > ODBC).
3. Cleaned the data in Power Query and set the correct data types.
4. Built the relationship `Customer[Client_Num]` to `Credit_card[Client_Num]` (one to many).
5. Created DAX columns (Agegroup, Revenue) and measures.
6. Built the visuals and slicers.

## DAX measures
```
Total Revenue = SUM(Credit_card[Revenue])
Total Income = SUM(Customer[Income])
CSS = AVERAGE(Customer[Cust_Satisfaction_Score])
```
Other measures in the report: Total Interest, Total Customers, Delinquency Rate, Activation Rate.

## Problems I fixed
- **MySQL connector error:** the built-in connector gave a `MissingClientLibrary` error, so I used an ODBC driver and DSN instead.
- **Relationship error:** Power BI would not save the relationship because `Client_Num` had duplicate values on the "one" side. I removed the duplicates in Power Query. After that, the gender split in the charts worked.
- **Slicers hiding data:** the cards showed very small numbers because some slicers were selected. I cleared them so the totals matched across all visuals.
- **Line chart showing one point:** the date axis was using the Year level of the date hierarchy. I switched it to the plain date field to show the weekly trend.

## How to run it
1. Install MySQL and the MySQL ODBC driver.
2. Create the database and import the tables using the files in the `sql/` and `data/` folders.
3. Create an ODBC DSN for the database.
4. Open the `.pbix` file and update the data source to your DSN if needed.

The `.pbix` already holds the data, so you can open it and see the dashboard without MySQL.

## Key insights
- Total revenue is about 55.32M, total interest about 7.84M and total income about 575.9M. The average satisfaction score (CSS) is 3.19.
- Male customers bring more revenue (about 30.22M) than female customers (about 25.09M).
- Businessman is the top customer job by revenue (about 17.39M), followed by White-collar (about 10.11M). Retirees bring the least (about 4.54M).
- Texas (TX) is the top state by revenue, followed by NY, CA, FL and NJ.
- Married customers bring the most revenue, and the 40-50 age group is the largest.
- Graduate customers bring the most revenue among education levels.
- Blue is the biggest card category by revenue.

## Credit
The dashboard layout is based on a sample dashboard I used as a reference. I set up the MySQL database and ODBC connection, fixed the connection and relationship errors, and built the DAX measures and visuals myself.

## Folder structure
```
├── README.md
├── data/
├── sql/create_tables.sql
├── powerbi/credit_card_dashboard.pbix
└── screenshots/dashboard.png
```
