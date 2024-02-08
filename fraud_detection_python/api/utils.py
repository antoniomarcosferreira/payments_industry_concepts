import datetime
import pandas as pd

class Utils:
    @staticmethod
    def extract_numerical_parts(string_value):
        try:
            return int(string_value[:6] + string_value[-2:])
        except ValueError:
            return -1

    @staticmethod
    def format_datetime(string_date):
        dt = pd.to_datetime(string_date)
        formatted = datetime.datetime.strftime(dt, "%Y%m%d%H%M")
        return pd.to_numeric(formatted)

    @staticmethod
    def prepare_data(data):
        data.fillna(value=-1, inplace=True)
        data["has_cbk"] = data["has_cbk"].astype(float)
        data["transaction_date_code"] = data["transaction_date"].apply(Utils.format_datetime)
        data["card_number_code"] = data["card_number"].apply(Utils.extract_numerical_parts)
        cleaned_df = data.copy()
        data = data.drop(columns=['card_number', 'transaction_date', 'transaction_id'])
        return data

    @staticmethod
    def generate_model():
        return true