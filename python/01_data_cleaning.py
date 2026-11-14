import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv("data/raw/hotel_bookings.csv")

# Initial audit
print(df.shape)
print(df.info())
print(df.isnull().sum().sort_values(ascending=False))
print(df.duplicated().sum())
print(df.describe().T)

# Cleaning
clean = df.drop_duplicates().copy()
clean["country"] = clean["country"].fillna("Unknown")
clean["children"] = clean["children"].fillna(0)
clean["agent"] = clean["agent"].fillna("Unknown")
clean = clean.drop(columns=["company"])
clean = clean[clean["adr"] >= 0].copy()

# Feature engineering
month_order = {"January":1,"February":2,"March":3,"April":4,"May":5,"June":6,
               "July":7,"August":8,"September":9,"October":10,"November":11,"December":12}
clean["arrival_month_num"] = clean["arrival_date_month"].map(month_order)
clean["arrival_date"] = pd.to_datetime(
    clean["arrival_date_year"].astype(str) + "-" +
    clean["arrival_month_num"].astype(str) + "-" +
    clean["arrival_date_day_of_month"].astype(str),
    errors="coerce"
)
clean["total_nights"] = clean["stays_in_weekend_nights"] + clean["stays_in_week_nights"]
clean["total_guests"] = clean["adults"] + clean["children"] + clean["babies"]
clean["estimated_booking_revenue"] = clean["adr"] * clean["total_nights"]
clean["booking_year_month"] = clean["arrival_date"].dt.to_period("M").astype(str)
clean["cancellation_status"] = clean["is_canceled"].map({0:"Not Canceled",1:"Canceled"})
clean["guest_status"] = clean["is_repeated_guest"].map({0:"New Guest",1:"Returning Guest"})

clean.to_csv("data/processed/hotel_bookings_clean.csv", index=False)
print("Clean dataset saved.")
