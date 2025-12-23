# Tunisair ETL

A lightweight ETL pipeline to extract, combine, deduplicate, transform, and export Tunisair flight data from the Aviationstack API. The workflow is primarily implemented in the notebook `Tunair_etl.ipynb`, with small helper scripts for quick testing.

## Features
- Extracts Tunisair flights (IATA `TU`) via the Aviationstack API
- Auto‑increments raw JSON filenames to avoid overwriting (`raw_tunisair_flights.json`, `raw_tunisair_flights2.json`, ...)
- Combines all raw files into a single dataset
- Removes exact duplicate records
- Normalizes nested JSON into a clean analytics‑ready table
- Exports a final CSV for analysis and visualization

## Repository Structure
- `Tunair_etl.ipynb`: Main ETL notebook (extract → combine → dedupe → transform → load)
- `step1_test_api.py`: Minimal script to verify API connectivity
- `step2_extract_tunisair.py`: Simple extractor script (optional alternative to the notebook)
- `raw_tunisair_flights*.json`: Raw API payload files
- `raw_tunisair_flights_combined.json`: Concatenated raw `data` entries from all raw files
- `raw_tunisair_flights_combined_dedup.json`: Combined data with exact duplicates removed
- `clean_tunisair_flights.csv`: Final cleaned dataset

## Requirements
- Python 3.9+
- Python packages: `pandas`, `numpy`, `requests`


## API Key

Update the `API_KEY` string in the extract cell of the notebook

> Note: The notebook includes an `API_KEY` variable for convenience. For security and portability, prefer using the environment variable.

## How to Run
###  Run the Notebook
1. Open `Tunair_etl.ipynb` in VS Code or Jupyter
2. Execute cells in order:
   - Import libraries
   - Extract (this writes a new `raw_tunisair_flights*.json` file each run)
   - Combine raw files → produces `raw_tunisair_flights_combined.json`
   - Remove duplicates → produces `raw_tunisair_flights_combined_dedup.json` and CSV
   - Load + Transform + Clean → exports `clean_tunisair_flights.csv`


## Data Flow & Artifacts
- Raw Files: `raw_tunisair_flights*.json` (direct API payloads)
- Combined: `raw_tunisair_flights_combined.json` (concatenated `data` arrays; ignores API pagination metadata)
- Deduped: `raw_tunisair_flights_combined_dedup.json` and `raw_tunisair_flights_combined_dedup.csv`
- Clean: `clean_tunisair_flights.csv` (flattened, typed, enriched)

## Deduplication Strategy

- Exact duplicate removal based on the entire JSON record contents


## Transform Highlights
- Flattens nested JSON fields with `pandas.json_normalize`
- Renames key columns for readability (departure/arrival, airline, flight)
- Converts datetimes and numeric delay fields
- Adds derived features (year, month, day, day_of_week, route, is_delayed)

## Troubleshooting
- 0 records returned: Check your `airline_iata`, rate limits, or API plan
- Network/timeout: Re‑run extraction or try again later
- Non‑UTF‑8 output: All files are saved with UTF‑8; ensure your editor uses UTF‑8 encoding

