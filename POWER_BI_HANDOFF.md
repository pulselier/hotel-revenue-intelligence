# Hotel Revenue Intelligence — Power BI handoff

## What is included

- `data/processed/hotel_bookings_clean.csv` — the 87,395-row analysis-ready source.
- `powerbi/Hotel-Revenue-Intelligence-Theme.json` — charcoal and teal report theme.
- `powerbi/Measures.dax` — complete KPI and optional year-over-year measures.
- `powerbi/Import-Clean-Bookings.pq` — typed Power Query import; replace the example file path before applying.
- `sql/01_core_analysis.sql`, `python/01_data_cleaning.py`, raw CSV, and the project README.

## Verified baseline

| Metric | Value | Definition |
|---|---:|---|
| Clean records | 87,395 | Rows after duplicate removal and negative ADR removal |
| Completed bookings | 63,370 | `is_canceled = 0` |
| Canceled bookings | 24,025 | `is_canceled = 1` |
| Cancellation rate | 27.49% | Canceled / all cleaned bookings |
| Average completed-booking ADR | 102.00 | Mean `adr` for completed bookings |
| Average completed stay | 3.49 nights | Mean `total_nights` for completed bookings |
| Completed booking value proxy | 22,976,960.13 | Sum of `adr × total_nights` for completed bookings |

The last figure is a **proxy**, not recognized hotel revenue. The dataset has no actual revenue or occupancy fields. Zero-night records remain in the source and naturally contribute zero to the booking-value proxy.

## Included Power BI report

1. Open Power BI Desktop and choose **Get data → Text/CSV**. Select `data/processed/hotel_bookings_clean.csv` from this package and choose **Transform Data**.
2. Optional shortcut: in Power Query choose **Advanced Editor**, paste `powerbi/Import-Clean-Bookings.pq`, replace `C:\PATH\TO\hotel_bookings_clean.csv` with the real full path, and select **Done**. Rename the query to **Hotel Bookings**. If you use the Text/CSV import instead, rename the query to the same table name and confirm the types listed below.
3. Confirm `arrival_date` and `reservation_status_date` are Date; `adr`, `children`, `total_guests`, and `estimated_booking_revenue` are Decimal Number; `is_canceled` and `is_repeated_guest` are Whole Number; and category fields are Text. Select **Close & Apply**.
4. In **View → Themes → Browse for themes**, select `powerbi/Hotel-Revenue-Intelligence-Theme.json`.
5. In **Model view**, rename the data table to `Hotel Bookings` if needed. Create each measure from `powerbi/Measures.dax` via **Modeling → New measure**, one at a time. Format `Cancellation Rate`, `Completed Booking Share`, `Repeat Guest Share`, and the YoY measure as Percentage; ADR/value measures as decimal with 2 places; nights, counts, guests and lead time as suitable numeric formats.
6. Create a date table by choosing **Modeling → New table** and entering the Calendar DAX below. Mark it as a date table using `Calendar[Date]`; create an active one-to-many relationship from `Calendar[Date]` to `Hotel Bookings[arrival_date]`. Sort `Calendar[Month]` by `Calendar[Month Number]`. The optional PY measures depend on this relationship.
7. Create the three report pages described below. Add slicers for arrival year, hotel, market segment, and country; use **Edit interactions** to check that each slicer filters the intended visuals.
8. Save as `Hotel-Revenue-Intelligence.pbix`. Reopen the saved file and verify the baseline cards before sharing or publishing.

### Calendar table DAX

```DAX
Calendar =
ADDCOLUMNS(
    CALENDAR(MIN('Hotel Bookings'[arrival_date]), MAX('Hotel Bookings'[arrival_date])),
    "Year", YEAR([Date]),
    "Month Number", MONTH([Date]),
    "Month", FORMAT([Date], "MMMM"),
    "Year Month", FORMAT([Date], "YYYY-MM"),
    "Year Month Sort", YEAR([Date]) * 100 + MONTH([Date]),
    "Quarter", "Q" & ROUNDUP(MONTH([Date]) / 3, 0)
)
```

Use `Calendar[Year Month]` on monthly charts and sort it by `Calendar[Year Month Sort]` (Column tools → Sort by column). Use `Calendar[Year]` on year slicers.

## Report layout

Use a 16:9 canvas, dark page background (`#101820`), teal for primary series (`#12B8A6`), amber for comparisons (`#F2A65A`), white titles, and restrained gridlines. Keep a consistent top row for page title and slicers.

### Page 1 — Executive Overview

- KPI cards: Total Bookings, Completed Bookings, Cancellation Rate, Average ADR (Completed), Completed Booking Value Proxy.
- Line chart: `Calendar[Year Month]` vs Completed Booking Value Proxy; optionally add the prior-year measure after validating Calendar.
- Clustered column chart: completed bookings by hotel.
- Bar chart: cancellation rate by market segment.
- Slicers: Calendar Year, hotel, market segment, country.
- Add a small note: “Booking value is an ADR × nights proxy for completed bookings; it is not recognized revenue.”

### Page 2 — Customer & Booking Behavior

- KPI cards: Average Stay (Completed, Nights), Average Lead Time (Days), Repeat Guest Share, Average Guests per Booking.
- Bar chart: cancellation rate by `lead_time` bands (create bins: 0–29, 30–89, 90–179, 180+ days) or use `lead_time` bins in the visual.
- Stacked column: bookings by `customer_type` and `cancellation_status`.
- Bar chart: bookings by `market_segment`; tooltip includes Cancellation Rate and ADR.
- Add `total_of_special_requests` by cancellation status as a small supporting visual.
- Slicers: hotel, arrival year, customer type, market segment.

### Page 3 — Revenue & Pricing

- KPI cards: Completed Booking Value Proxy, Average ADR (Completed), Avg Value per Completed Booking, Completed Nights.
- Line chart: Average ADR (Completed) by `Calendar[Year Month]`.
- Bar chart: completed booking value proxy by country; apply a visual filter of Top N 10 by the proxy and retain the country slicer.
- Scatter: ADR (X), total_nights (Y), estimated_booking_revenue (size), market_segment (legend); filter `is_canceled = 0`.
- Matrix: hotel × market segment with Completed Bookings, Average ADR, Average Stay, and Booking Value Proxy.
- Add the proxy definition in a visible subtitle or info note.

## Metric and modeling notes

- Cancellation rate uses **all cleaned bookings** as the denominator. Do not filter to completed bookings for that measure.
- ADR and average stay cards are explicitly filtered to completed bookings.
- Monthly trend is by **arrival date**. It does not represent booking creation date.
- Country rankings in the SQL starter require at least 100 completed bookings to reduce small-sample noise. Apply that threshold as a filter for comparable country analysis.
- This dataset is a historical sample, not a live feed; avoid implying current inventory or forecasted revenue.
- The supplied cleaning process removed 31,994 duplicate rows, filled country/agent/children nulls, removed the company field, and removed one negative-ADR record. See `data/processed/data_quality_summary.json`.

## Final report file`r`n`r`nThe final Power BI Desktop report is included at `powerbi/Hotel-Revenue-Intelligence.pbix`. The package also contains the theme, measures, and Power Query import script used as supporting materials.`r`n
