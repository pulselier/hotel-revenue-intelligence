# Hotel Revenue Intelligence

An end-to-end portfolio project exploring hotel booking behavior, cancellation patterns, and booking-value proxies with Python, SQL, and Power BI.

## Business question

How can hotel teams understand their booking mix and cancellation exposure, compare acquisition channels, and identify where pricing and booking-policy decisions deserve closer investigation?

## Project contents

| Folder | Contents |
|---|---|
| `data/raw/` | Original Hotel Booking Demand CSV |
| `data/processed/` | Cleaned analysis dataset and data-quality summary |
| `python/` | Python data-cleaning script |
| `sql/` | Core analysis queries for SQLite |
| `powerbi/` | Final Power BI report, theme, measures, and Power Query import steps |
| `POWER_BI_HANDOFF.md` | Metric definitions, dashboard details, and validation notes |

## Key findings

- The cleaned dataset contains 87,395 bookings after removing exact duplicate rows and one record with negative ADR.
- 24,025 cleaned bookings were canceled, a cancellation rate of 27.49%.
- Online Travel Agents account for the largest market segment in the analysis; cancellation rates vary across segments and lead-time groups.
- The report includes three pages: Executive Overview, Booking & Cancellation Analysis, and Pricing & Revenue Insights.

See [POWER_BI_HANDOFF.md](POWER_BI_HANDOFF.md) for metric definitions and the report build notes.

## Important metric limitation

The source data does not contain recognized hotel revenue, room inventory, or occupancy. `estimated_booking_revenue` is calculated as ADR × total nights and is used only as a **booking-value proxy** for non-canceled bookings. It must not be interpreted as actual revenue. Findings describe associations in historical booking records and do not establish causes or predict current demand.

## Reproducing the data preparation

Python 3.10 or newer is recommended.

```bash
pip install -r requirements.txt
python python/01_data_cleaning.py
```

The script reads `data/raw/hotel_bookings.csv` and writes `data/processed/hotel_bookings_clean.csv`.

## Power BI

Open [`powerbi/Hotel-Revenue-Intelligence.pbix`](powerbi/Hotel-Revenue-Intelligence.pbix) in Power BI Desktop. The report uses the included processed CSV. Supporting measures, theme, and import query are also in `powerbi/`.

## Dataset and attribution

The Hotel Booking Demand dataset was published on Kaggle by Jesse Mostipak and is associated with the research article “Hotel booking demand datasets” by Nuno Antonio, Ana Almeida, and Luis Nunes. The Kaggle dataset listing declares a [CC BY 4.0 license](https://creativecommons.org/licenses/by/4.0/). Dataset source: [Kaggle — Hotel Booking Demand](https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand). Please retain this attribution when reusing the dataset.

## Tools

Python · pandas · SQL · SQLite · Power BI
