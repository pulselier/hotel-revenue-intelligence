-- Core Hotel Revenue Intelligence queries

-- Monthly estimated revenue
SELECT arrival_date_year, arrival_date_month,
       SUM(estimated_booking_revenue) AS estimated_revenue
FROM hotel_bookings_clean
WHERE is_canceled = 0
GROUP BY arrival_date_year, arrival_date_month
ORDER BY arrival_date_year, MIN(arrival_month_num);

-- Cancellation rate by market segment
SELECT market_segment, COUNT(*) AS total_bookings,
       SUM(is_canceled) AS cancellations,
       ROUND(100.0 * SUM(is_canceled) / COUNT(*), 2) AS cancellation_rate_pct
FROM hotel_bookings_clean
GROUP BY market_segment
ORDER BY cancellation_rate_pct DESC;

-- ADR by market segment
SELECT market_segment, ROUND(AVG(adr), 2) AS avg_adr
FROM hotel_bookings_clean
WHERE is_canceled = 0
GROUP BY market_segment
ORDER BY avg_adr DESC;

-- High-value countries
SELECT country, COUNT(*) AS bookings,
       ROUND(AVG(adr), 2) AS avg_adr,
       ROUND(AVG(total_nights), 2) AS avg_stay,
       ROUND(SUM(estimated_booking_revenue), 2) AS estimated_revenue
FROM hotel_bookings_clean
WHERE is_canceled = 0
GROUP BY country
HAVING COUNT(*) >= 100
ORDER BY estimated_revenue DESC;

-- Lead time vs cancellation
SELECT
 CASE WHEN lead_time < 30 THEN '0-29 days'
      WHEN lead_time < 90 THEN '30-89 days'
      WHEN lead_time < 180 THEN '90-179 days'
      ELSE '180+ days' END AS lead_time_group,
 COUNT(*) AS bookings,
 ROUND(100.0 * SUM(is_canceled) / COUNT(*), 2) AS cancellation_rate_pct
FROM hotel_bookings_clean
GROUP BY lead_time_group
ORDER BY MIN(lead_time);
