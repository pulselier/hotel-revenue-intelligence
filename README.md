# Hotel Revenue Intelligence

An end-to-end portfolio project exploring hotel booking behavior, cancellation patterns, and booking-value proxies with Python, SQL, and Power BI.

## Business question
How can hotel teams understand their booking mix and cancellation exposure, compare acquisition channels, and identify where pricing and booking-policy decisions deserve closer investigation?

## Project contents
- `data/raw/`: original Hotel Booking Demand CSV
- `data/processed/`: cleaned analysis dataset and quality summary
- `python/`: Python data-cleaning script
- `sql/`: core analysis queries for SQLite
- `powerbi/`: final Power BI report, theme, measures, and Power Query import steps
- `POWER_BI_HANDOFF.md`: metric definitions and dashboard notes

## Key findings
- The cleaned dataset contains 87,395 bookings after removing exact duplicates and one record with negative ADR.
- 24,025 cleaned bookings were canceled, a rate of 27.49%.
- Cancellation rates vary across market segments and lead-time groups.
- The Power BI report includes Executive Overview, Booking & Cancellation Analysis, and Pricing & Revenue Insights pages.

## Metric limitation
The source data contains no recognized hotel revenue, room inventory, or occupancy. `estimated_booking_revenue` is ADR × total nights and is only a **booking-value proxy** for non-canceled bookings. It is not actual revenue. Findings are descriptive associations in historical booking records and do not establish causes or predict current demand.

## Reproduce data preparation
Python 3.10+ is recommended.
```bash
pip install -r requirements.txt
python python/01_data_cleaning.py
```
The script reads `data/raw/hotel_bookings.csv` and writes `data/processed/hotel_bookings_clean.csv`.

## Power BI
Open [`powerbi/Hotel-Revenue-Intelligence.pbix`](powerbi/Hotel-Revenue-Intelligence.pbix) in Power BI Desktop. Supporting measures, theme, and import query are also in `powerbi/`.

## Dataset and attribution
The Hotel Booking Demand dataset was published on Kaggle by Jesse Mostipak and is associated with “Hotel booking demand datasets” by Nuno Antonio, Ana Almeida, and Luis Nunes. The Kaggle dataset listing declares a [CC BY 4.0 license](https://creativecommons.org/licenses/by/4.0/). [Dataset source](https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand). Please retain this attribution when reusing the data.

## Tools
Python · pandas · SQL · SQLite · Power BI
