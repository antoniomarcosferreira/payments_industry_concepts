# main.py
from fastapi import FastAPI
from pydantic import BaseModel
import pandas as pd
from joblib import load
from utils import Utils

# Define the FastAPI app
app = FastAPI()

# Load the trained model
model = load('resources/model.joblib')

# Define the request payload model
class TransactionPayload(BaseModel):
    transaction_id: int
    merchant_id: int
    user_id: int
    card_number: str
    transaction_date: str
    transaction_amount: float
    device_id: float

# Define the response model
class TransactionResponse(BaseModel):
    transaction_id: int
    recommendation: str

# Define the API endpoint
@app.post("/approve")
def approve_transaction(payload: TransactionPayload):
    # Convert the payload to a DataFrame
    data = pd.DataFrame([payload.dict()])
    data = Utils.prepare_data(data)  
    
    predictions = model.predict(data)
    
    # Determine the recommendation based on the prediction
    if predictions[0] == 1:
        recommendation = "deny"
    else:
        recommendation = "approve"

    # Create the response
    response = TransactionResponse(transaction_id=payload.transaction_id, recommendation=recommendation)

    return response