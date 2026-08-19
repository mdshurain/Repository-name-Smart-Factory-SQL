# Smart Factory SQL Analytics

## Project Overview

This project uses PostgreSQL and SQL to analyze data from a fictional smart manufacturing facility.

The database stores information about:

- Factory machines
- Machine sensors
- Sensor readings
- Production output
- Defective products
- Maintenance activities
- Machine downtime

The goal is to use SQL to identify machines that may require attention based on sensor conditions, production quality and maintenance history.

## Technologies Used

- PostgreSQL
- pgAdmin 4
- SQL
- Visual Studio Code

## Database Structure

The project contains five main tables:

### Machines

Stores information about each factory machine.

Important columns:

- machine_id
- machine_name
- machine_type
- location
- installation_date
- status

### Sensors

Stores the sensors installed on each machine.

Important columns:

- sensor_id
- machine_id
- sensor_type
- unit
- installation_date

### Sensor_Readings

Stores temperature, vibration and power readings.

Important columns:

- reading_id
- machine_id
- reading_time
- temperature
- vibration
- power_consumption

### Production

Stores daily production information.

Important columns:

- production_id
- machine_id
- production_date
- shift
- units_produced
- defective_units

### Maintenance

Stores maintenance activities and their associated costs and downtime.

Important columns:

- maintenance_id
- machine_id
- maintenance_date
- maintenance_type
- description
- downtime_hours
- maintenance_cost

## SQL Concepts Used

This project demonstrates:

- SELECT
- WHERE
- ORDER BY
- LIMIT
- Aggregate functions
- SUM()
- AVG()
- COUNT()
- MAX()
- MIN()
- GROUP BY
- HAVING
- CASE
- INNER JOIN
- CTEs
- Calculated columns

## Analysis Performed

The project analyzes:

1. Average machine temperature
2. Average machine vibration
3. Power consumption
4. Total production
5. Total defective units
6. Defect rate
7. Maintenance costs
8. Machine downtime
9. Machine health classification

## Machine Health Classification

Machines are classified using simple SQL rules.

### Critical

A machine is classified as Critical when:

- Average temperature is above 65°C
- Average vibration is above 3.5 mm/s
- Defect rate is above 5%

### Warning

A machine is classified as Warning when at least one of the following conditions is met:

- Average temperature is above 62°C
- Average vibration is above 3 mm/s
- Defect rate is above 3%

### Healthy

Machines that do not meet the Warning or Critical conditions are classified as Healthy.

## Important SQL Problem Solved

During development, joining Production and Maintenance directly caused duplicated rows.

For example, if a machine had 90 production records and 4 maintenance records, the JOIN could produce:

90 × 4 = 360 rows

This caused maintenance costs and downtime to be incorrectly multiplied.

The problem was solved by summarizing each table separately using CTEs before joining the results.

This ensures that each summary contains only one row per machine before the final JOIN.

## Project Structure

```text
Smart-Factory-SQL/

├── 01_database_setup.sql
├── 02_create_tables.sql
├── 03_insert_data.sql
├── 04_sensor_analysis.sql
├── 05_production_analysis.sql
├── 06_maintenance_analysis.sql
├── 07_machine_health_report.sql
└── README.md
## Project Results

### Machine Overview

The database contains information about the machines operating in the simulated factory.

![Machine Overview](screenshots/01_machine_overview.png)

### Production Analysis

The production analysis compares total production, defective units and defect rates across machines.

![Production Analysis](screenshots/02_production_analysis.png)

### Machine Health Report

The final report combines sensor, production and maintenance data to classify machines as Healthy, Warning or Critical.

![Machine Health Report](screenshots/03_machine_health_report.png)
