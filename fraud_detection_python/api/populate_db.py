import csv
import sqlite3

# Connect to the database
conn = sqlite3.connect('transactions.db')
cursor = conn.cursor()

# Create the transactions table
cursor.execute('''
    CREATE TABLE IF NOT EXISTS transactions (
        transaction_id INTEGER,
        merchant_id INTEGER,
        user_id INTEGER,
        card_number TEXT,
        transaction_date TEXT,
        transaction_amount REAL,
        device_id INTEGER,
        has_cbk INTEGER
    )
''')

# Read the data from the data.csv file and insert it into the transactions table
with open('../docs/resources/transactional-sample.csv', 'r') as file:
    reader = csv.reader(file)
    next(reader)  # Skip the header row

    for row in reader:
        transaction_id = int(row[0])
        merchant_id = int(row[1])
        user_id = int(row[2])
        card_number = row[3]
        transaction_date = row[4]
        transaction_amount = float(row[5])
        device_id = None if row[6] == '' else int(row[6])
        has_cbk = True if row[7] == 'TRUE' else False

        cursor.execute('''
            INSERT INTO transactions (transaction_id, merchant_id, user_id, card_number, transaction_date, transaction_amount, device_id, has_cbk)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ''', (transaction_id, merchant_id, user_id, card_number, transaction_date, transaction_amount, device_id, has_cbk))

# Commit the changes and close the connection
conn.commit()
conn.close()