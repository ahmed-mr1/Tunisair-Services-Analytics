import requests
import json

API_KEY = "f9a3ebd329fea81d036463417e0b6ce9"

url = "http://api.aviationstack.com/v1/flights"
params = {
    "access_key": API_KEY,
    "airline_iata": "TU",
    "limit": 100
}

response = requests.get(url, params=params)

data = response.json()

# Save raw JSON data
with open("raw_tunisair_flights.json", "w") as f:
    json.dump(data, f, indent=2)

print("JSON data saved to raw_tunisair_flights.json")
print("Records extracted:", len(data.get("data", [])))

