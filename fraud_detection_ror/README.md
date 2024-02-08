# FRAUD DETECTION

This app has the function of checking whether a transaction is suspected of financial fraud.

Battery
-   ruby 3.3.0
-   rails 7.1.3'
-   sqlite3
-   Puma

## Important
This application is just a simple API example (small POC), to run in production it needs to be modified, such as changing the database to a cloud database, running in some type of cluster to be able to scale, etc.


## Routes 
    GET    /  transactions#index
    POST    /evaluate         transactions#evaluate

See more routes run

    rails routes

### To start as develop mod:

Install
    
    bundle install
    rails db:create
    rails db:migrate
    rails db:seed

Run all tests

    rspec

Run server

    rails server

### You don't use IDE?

Use rubocop to auto-correct code style:

    rubocop --auto-correct-all --disable-uncorrectable

---
[Back](../README.md)
