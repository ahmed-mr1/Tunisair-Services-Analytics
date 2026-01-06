# Tunisair Services Analytics

A comprehensive end-to-end data analytics pipeline for analyzing Tunisair flight operations, delays, and performance metrics. This project extracts real-time flight data from the Aviationstack API, processes it through a robust ETL pipeline, stores it in a dimensional data warehouse, and visualizes insights using Power BI.

## 📋 Project Overview

This project provides a complete analytics solution for Tunisair flight data, enabling stakeholders to:
- Monitor flight operations and delays in real-time
- Analyze route performance and airline efficiency
- Track temporal patterns in flight operations
- Make data-driven decisions based on historical trends

## 🏗️ Architecture

The project follows a modern data analytics architecture:

```
API Source (Aviationstack) → ETL Pipeline → Data Warehouse → Power BI Dashboard
                                    ↓
                          Cleaned CSV Exports → Analytics & Enrichment
```

### Key Components

1. **ETL Pipeline** (`ETL/`): Extract, transform, and load flight data
2. **Data Warehouse** (`ETL/SQL/`): Star schema with fact and dimension tables
3. **Cleaned Data** (`data_cleaned/`): Processed datasets in multiple formats (JSON, CSV, SQLite)
4. **Data Model** (`model/`): Dimensional model diagram for the data warehouse
5. **Power BI Dashboard** (`dashboard/`): Interactive visualization and reporting

## 🚀 Features

### ETL Pipeline
- **Extraction**: Fetches Tunisair flights (IATA code `TU`) from Aviationstack API
- **Auto-increment**: Automatically names raw JSON files to avoid overwriting
- **Deduplication**: Removes exact duplicate records
- **Transformation**: Normalizes nested JSON into flat, analytics-ready tables
- **Enrichment**: Adds derived features (day of week, route combinations, delay flags)
- **Multiple formats**: Exports to CSV, JSON, and SQLite database

### Data Warehouse
- **Star schema**: Optimized for analytical queries
- **Dimension tables**: Airlines, Airports, Routes, Dates
- **Fact table**: Flight events with foreign keys to dimensions
- **MySQL compatible**: Ready for deployment on any MySQL server

### Analytics & Visualization
- **Power BI Dashboard**: Interactive reports with drill-down capabilities
- **Delay Analysis**: Comprehensive metrics on flight delays
- **Route Performance**: Analysis by origin-destination pairs
- **Temporal Patterns**: Year, month, day, and day-of-week trends

## 📁 Repository Structure

```
Tunisair-Services-Analytics/
├── ETL/
│   ├── Tunair_etl.ipynb              # Main ETL notebook
│   ├── clean_flights_enrichment.ipynb # Data enrichment and feature engineering
│   ├── convertdbcsv.ipynb            # Database to CSV conversion utilities
│   ├── step1_test_api.py             # API connectivity test script
│   ├── step2_extract_tunisair.py     # Standalone extraction script
│   └── SQL/                          # Data warehouse schema
│       ├── warehouse_project_staging_raw.sql
│       ├── warehouse_project_dim_airline.sql
│       ├── warehouse_project_dim_airport.sql
│       ├── warehouse_project_dim_route.sql
│       ├── warehouse_project_dim_date.sql
│       ├── warehouse_project_fact_flights.sql
│       └── Insert.sql                # Data loading script
├── data_cleaned/
│   ├── json/                         # Raw and processed JSON files
│   ├── csv/                          # Clean CSV exports
│   └── db/                           # SQLite database
├── model/
│   └── warehouse diagram.pdf         # Data warehouse dimensional model
├── dashboard/
│   └── Final Power BI Report - Tunisair.pbix
└── README.md
```

## 🛠️ Prerequisites

- **Python**: 3.9 or higher
- **Python Packages**: `pandas`, `numpy`, `requests`, `sqlite3`
- **MySQL**: 8.0+ (for data warehouse deployment)
- **Power BI Desktop**: For viewing and editing dashboards
- **Jupyter**: VS Code with Jupyter extension or JupyterLab
- **Aviationstack API Key**: [Get one here](https://aviationstack.com/)

## 📦 Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ahmed-mr1/Tunisair-Services-Analytics.git
   cd Tunisair-Services-Analytics
   ```

2. **Install Python dependencies**
   ```bash
   pip install pandas numpy requests
   ```

3. **Configure API Key**
   
   Update the `API_KEY` variable in `ETL/Tunair_etl.ipynb` or set it as an environment variable:
   ```bash
   export AVIATIONSTACK_API_KEY="your_api_key_here"
   ```

4. **(Optional) Set up MySQL Data Warehouse**
   ```bash
   mysql -u root -p < ETL/SQL/warehouse_project_staging_raw.sql
   mysql -u root -p < ETL/SQL/warehouse_project_dim_airline.sql
   mysql -u root -p < ETL/SQL/warehouse_project_dim_airport.sql
   mysql -u root -p < ETL/SQL/warehouse_project_dim_route.sql
   mysql -u root -p < ETL/SQL/warehouse_project_dim_date.sql
   mysql -u root -p < ETL/SQL/warehouse_project_fact_flights.sql
   ```

## 🎯 Usage

### 1. Run the ETL Pipeline

**Option A: Using the Main Notebook (Recommended)**

1. Open `ETL/Tunair_etl.ipynb` in VS Code or Jupyter
2. Execute cells in order:
   - **Import libraries**: Load required packages
   - **Extract**: Fetch data from Aviationstack API (creates `raw_tunisair_flights*.json`)
   - **Combine**: Merge all raw files → `raw_tunisair_flights_combined.json`
   - **Deduplicate**: Remove duplicates → `raw_tunisair_flights_combined_dedup.json` and CSV
   - **Transform**: Clean and flatten data → `clean_tunisair_flights.csv`

**Option B: Using Helper Scripts**

```bash
# Test API connection
cd ETL
python step1_test_api.py

# Extract Tunisair data
python step2_extract_tunisair.py
```

### 2. Enrich the Data

1. Open `ETL/clean_flights_enrichment.ipynb`
2. Run all cells to add derived features:
   - Route combinations (origin-destination pairs)
   - Temporal features (year, month, day, day of week)
   - Delay indicators and metrics
   - Flight status enrichment

Output: `data_cleaned/csv/clean_tunisair_flights_enriched.csv`

### 3. Load Data into Data Warehouse

```bash
# Load data into MySQL
mysql -u root -p warehouse_project < ETL/SQL/Insert.sql
```

### 4. View Power BI Dashboard

1. Open `dashboard/Final Power BI Report - Tunisair.pbix` in Power BI Desktop
2. Refresh data sources to see updated visualizations
3. Explore interactive reports and filters

## 📊 Data Flow

### ETL Process

1. **Extraction**
   - API calls to Aviationstack with `airline_iata=TU`
   - Incremental file naming: `raw_tunisair_flights.json`, `raw_tunisair_flights2.json`, ...
   - Raw JSON stored in `data_cleaned/json/`

2. **Combination**
   - Merge all raw JSON files
   - Output: `raw_tunisair_flights_combined.json` (file size varies based on data volume)

3. **Deduplication**
   - Remove exact duplicate records based on entire JSON content
   - Output: `raw_tunisair_flights_combined_dedup.json` (size depends on duplicate ratio)

4. **Transformation**
   - Flatten nested JSON with `pandas.json_normalize`
   - Rename columns for clarity (departure/arrival, airline, flight)
   - Convert datetimes and numeric delay fields
   - Output: `clean_tunisair_flights.csv`

5. **Enrichment**
   - Add derived features (year, month, day, day_of_week, route, is_delayed)
   - Calculate delay metrics
   - Output: `clean_tunisair_flights_enriched.csv`

### Data Warehouse Schema

**Star Schema Design:**

- **Fact Table**: `fact_flights` (flight events with measures)
- **Dimension Tables**:
  - `dim_airline`: Airline information
  - `dim_airport`: Airport details and locations
  - `dim_route`: Origin-destination route combinations
  - `dim_date`: Date dimension for time-based analysis

See `model/warehouse diagram.pdf` for the complete dimensional model.

## 🎨 Key Insights & Analytics

The Power BI dashboard provides:

- **Flight Operations Overview**: Total flights, on-time percentage, average delays
- **Delay Analysis**: Distribution of delays by severity and causes
- **Route Performance**: Top routes by volume and delay metrics
- **Temporal Trends**: Flight patterns by hour, day, month, and year
- **Airport Analysis**: Busiest airports and their performance metrics
- **Airline Comparison**: Performance benchmarking (when extended beyond Tunisair)

## 🔧 Troubleshooting

### ETL Issues

- **0 records returned**: Check your `airline_iata` code, API rate limits, or subscription plan
- **Network/timeout errors**: Re-run extraction or try again later
- **Non-UTF-8 encoding**: All files use UTF-8; ensure your editor is configured correctly
- **Missing API key**: Verify the API key is set in the notebook or environment variable

### Data Warehouse Issues

- **Foreign key violations**: Ensure dimension tables are loaded before fact table
- **Character encoding errors**: Use UTF-8 for MySQL connection and import
- **Slow queries**: Add indexes on foreign keys and frequently filtered columns

### Power BI Issues

- **Cannot open file**: Requires Power BI Desktop (Windows or Power BI Service)
- **Data source errors**: Update connection strings to point to your data files or database
- **Refresh failures**: Check that source files exist in expected locations

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues or pull requests for:
- Additional data sources or airlines
- Enhanced analytics and visualizations
- Performance optimizations
- Documentation improvements

## 📄 License

This project is available for educational and analytical purposes.

## 🙏 Acknowledgments

- **Aviationstack API**: For providing comprehensive flight data
- **Tunisair**: Subject airline for this analytics project
- Data warehouse design follows industry best practices for dimensional modeling

## 📧 Contact

For questions or feedback, please open an issue in the GitHub repository.

---

**Last Updated**: January 2026

