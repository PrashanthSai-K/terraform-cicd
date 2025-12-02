from flask import Flask, jsonify
import psycopg2
import os

app = Flask(__name__)

DB_HOST = "${db_private_ip}"
DB_NAME = "postgres"
DB_USER = "postgres"
DB_PASSWORD = "" # No password for simplicity

@app.route('/')
def home():
    try:
        conn = psycopg2.connect(host=DB_HOST, dbname=DB_NAME, user=DB_USER, password=DB_PASSWORD)
        conn.close()
        return jsonify(db_status="Connected")
    except psycopg2.OperationalError:
        return jsonify(db_status="Disconnected")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
