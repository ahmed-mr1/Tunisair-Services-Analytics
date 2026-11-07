LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/clean_tunisair_flights.csv'
INTO TABLE staging_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
  flight_date,
  flight_status,
  departure_airport,
  departure_iata,
  departure_delay_minutes,
  departure_scheduled,
  departure_estimated,
  departure_actual,
  arrival_airport,
  arrival_iata,
  arrival_scheduled,
  arrival_delay_minutes,
  arrival_estimated,
  arrival_actual,
  airline_name,
  airline_iata,
  airline_icao,
  flight_number,
  flight_iata,
  flight_icao,
  @year,
  @month,
  @day,
  day_of_week,
  total_delay_minutes,
  route,
  is_delayed
)
SET
  year  = CAST(FLOOR(@year) AS UNSIGNED),
  month = CAST(FLOOR(@month) AS UNSIGNED),
  day   = CAST(FLOOR(@day) AS UNSIGNED);
