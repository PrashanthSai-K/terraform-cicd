from flask import Flask, render_template_string
import requests

app = Flask(__name__)

BACKEND_URL = "http://${app_private_ip}:8080"

@app.route('/')
def home():
    # try:
    #     response = requests.get(BACKEND_URL)
    #     if response.status_code == 200:
    #         db_status = response.json().get('db_status', 'Unknown')
    #         status = f"Connected to Backend. DB Status: {db_status}"
    #     else:
    #         status = "Failed to connect to Backend"
    # except requests.exceptions.ConnectionError:
    #     status = "Failed to connect to Backend (Connection Error)"
    # except ValueError: # Catches JSON decoding errors
    #     status = "Failed to parse backend response"


    return render_template_string('<h1>{{ status }}</h1>', status='Welcome !! This is an Web app')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
