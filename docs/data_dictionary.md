# Data Dictionary & Warehouse Schema — Tunisair Services Analytics

This document defines the schema, fields, and business rules for the **Tunisair Services Analytics** data pipeline, star-schema data warehouse (`warehouse_project`), and processed analytical datasets.

> [!NOTE]
> See [`warehouse_diagram.pdf`](./warehouse_diagram.pdf) for the visual Entity-Relationship Diagram (ERD) of the star schema.

---

## 1. Star-Schema Data Warehouse (`warehouse_project`)

### Fact Table: `fact_flights`
Granularity: One row per scheduled/operated flight instance.

| Column Name | Data Type | Key / Constraint | Description |
| :--- | :--- | :--- | :--- |
| `flight_id` | `INT` | `PRIMARY KEY` | Unique surrogate identifier for each flight record. |
| `airline_id` | `INT` | `FK -> dim_airline.airline_id` | Foreign key linking to the operating airline dimension. |
| `route_id` | `INT` | `FK -> dim_route.route_id` | Foreign key linking to the origin-destination route pair. |
| `from_airport_id` | `INT` | `FK -> dim_airport.airport_id` | Departure airport surrogate key. |
| `to_airport_id` | `INT` | `FK -> dim_airport.airport_id` | Arrival airport surrogate key. |
| `flight_date` | `DATE` | `INDEX` | Scheduled date of the flight (`YYYY-MM-DD`). |
| `day_of_week` | `VARCHAR(20)` | — | Day name of the flight (`Monday`–`Sunday`). |
| `flight_number` | `VARCHAR(20)` | — | Numeric or alphanumeric flight number (e.g., `722`, `TU722`). |
| `flight_status` | `VARCHAR(20)` | `INDEX` | Operational status (`scheduled`, `landed`, `active`, `cancelled`, `diverted`). |
| `departure_scheduled` | `VARCHAR(50)` | — | Scheduled gate departure timestamp/date. |
| `departure_actual` | `VARCHAR(50)` | — | Actual gate/runway departure timestamp/date. |
| `arrival_scheduled` | `VARCHAR(50)` | — | Scheduled gate arrival timestamp/date. |
| `arrival_actual` | `VARCHAR(50)` | — | Actual gate/runway arrival timestamp/date. |
| `departure_delay_minutes` | `INT` | `DEFAULT 0` | Departure delay in minutes (`0` if on-time or early). |
| `arrival_delay_minutes` | `INT` | `DEFAULT 0` | Arrival delay in minutes (`0` if on-time or early). |
| `total_delay_minutes` | `INT` | `DEFAULT 0` | Sum of departure and arrival delay minutes (`departure_delay_minutes + arrival_delay_minutes`). |
| `is_delayed` | `TINYINT(1)` | `INDEX` | Binary delay flag (`1` / `True` if `total_delay_minutes > 15`, else `0` / `False`, following the aviation 15-minute OTP standard). |

---

### Dimension Tables

#### `dim_airline`
| Column Name | Data Type | Key / Constraint | Description |
| :--- | :--- | :--- | :--- |
| `airline_id` | `INT` | `PRIMARY KEY AUTO_INCREMENT` | Surrogate key for the airline. |
| `airline_code` | `VARCHAR(10)` | `UNIQUE` | IATA airline designator (e.g., `TU` for Tunisair). |
| `airline_name` | `VARCHAR(200)` | — | Full commercial name of the airline (`Tunisair`). |

#### `dim_airport`
| Column Name | Data Type | Key / Constraint | Description |
| :--- | :--- | :--- | :--- |
| `airport_id` | `INT` | `PRIMARY KEY AUTO_INCREMENT` | Surrogate key for the airport (64+ distinct stations). |
| `airport_code` | `VARCHAR(10)` | `UNIQUE` | 3-letter IATA airport code (e.g., `TUN`, `ORY`, `DJE`, `LHR`, `JED`). |
| `airport_name` | `VARCHAR(200)` | — | Commercial airport name (e.g., `Carthage`, `Orly`, `Djerba-Zarzis`). |

#### `dim_route`
| Column Name | Data Type | Key / Constraint | Description |
| :--- | :--- | :--- | :--- |
| `route_id` | `INT` | `PRIMARY KEY AUTO_INCREMENT` | Surrogate key for the directional flight corridor (127+ distinct routes). |
| `from_airport_id` | `INT` | `FK -> dim_airport.airport_id` | Origin airport foreign key. |
| `to_airport_id` | `INT` | `FK -> dim_airport.airport_id` | Destination airport foreign key. |
| `route_name` | `VARCHAR(100)` | `INDEX` | Standardized directional corridor string (e.g., `TUN to ORY`, `ORY to DJE`). |

#### `dim_date`
| Column Name | Data Type | Key / Constraint | Description |
| :--- | :--- | :--- | :--- |
| `date_id` | `INT` | `PRIMARY KEY` | Integer date key (`YYYYMMDD`). |
| `date` | `DATE` | `INDEX` | Calendar date (`YYYY-MM-DD`). |
| `year` | `INT` | — | Calendar year (`2022`, `2025`). |
| `month` | `INT` | — | Calendar month number (`1`–`12`). |
| `day` | `INT` | — | Day of month (`1`–`31`). |
| `day_name` | `VARCHAR(20)` | — | Full weekday name (`Monday`–`Sunday`). |
| `is_weekend` | `TINYINT(1)` | — | Weekend indicator (`1` for Saturday/Sunday, `0` for weekdays). |

---

## 2. Processed Analytical Datasets (`data/processed/`)

| File | Records | Columns | Description |
| :--- | :---: | :---: | :--- |
| `clean_tunisair_flights_enriched.csv` | 1,148 | 27 | Primary enriched dataset combining historical (2022) and recent (2025) Tunisair flights with standardized `YYYY-MM-DD` dates, derived `total_delay_minutes`, `is_delayed` (>15 min threshold), and normalized ` Origin to Destination ` routes. |
| `clean_tunisair_flights.csv` | 1,148 | 27 | Cleaned flight dataset prior to final route delimiter standardization. |
| `Tunisair2022.csv` | 243 | 27 | Historical 2022 summer peak flight performance benchmark dataset. |
| `tunisair_delay_export_TU.csv` | 243 | 22 | Filtered Tunisair (`AIRLINE == 'TU'`) operational delay records extracted from `tunisair_delay.db`. |
| `raw_tunisair_flights_combined_dedup.json` | 957 | 54 (nested) | Deduplicated Aviationstack API JSON payload (35,105 exact duplicate records removed from 36,062 raw records across 27 extraction batches). |
