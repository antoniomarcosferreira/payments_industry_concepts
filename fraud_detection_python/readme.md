# Fraud Detection Python


## Why
Python is very simple and has many features for using machine learning.

Large companies like Tesla, for example, use Python to carry out tests and POCs, after the models are approved, then the team implements the model in higher performance languages ​​such as C++, for example.


This API must be the implementation of a trained model to identify anomalies and define suspicious operations as deny.


## Enviroment (DEV)

    
    python3 -m venv env
    
    source env/bin/activate
    
    pip install -r requirements.txt

## Populate

    python3 populate_db.py

## Run 

    cd api/ && uvicorn main:app --reload --port 8000


The API will be running at http://localhost:8000. You can test it with sample requests to the /approve endpoint.
