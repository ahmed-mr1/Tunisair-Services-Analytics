import requests

API_KEY = "f9a3ebd329fea81d036463417e0b6ce9"

url = "http://api.aviationstack.com/v1/flights"
params = {
    "access_key": API_KEY,
    "limit": 5
}

response = requests.get(url, params=params)

print("STATUS CODE:", response.status_code)
print(response.text)
