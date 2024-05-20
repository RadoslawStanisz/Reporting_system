CREATE SCHEMA IF NOT EXISTS reporting
;
CREATE OR REPLACE VIEW reporting.flight as
SELECT 
*,
CASE WHEN dep_delay_new > 15 THEN 1 ELSE 0 END AS is_delayed
FROM public.flight
WHERE cancelled = 0
;
CREATE OR REPLACE VIEW reporting.top_reliability_roads AS
SELECT
    f.origin_airport_id,
    al.origin_city_name AS origin_airport_name,
    f.dest_airport_id,
    al_2.origin_city_name AS dest_airport_name,
    f.year,
    f.cnt,
    f.reliability,
    DENSE_RANK() OVER (ORDER BY f.reliability DESC) AS nb
FROM (
    SELECT
        origin_airport_id,
        dest_airport_id,
        year,
        COUNT(*) AS cnt,
        SUM(is_delayed) / COUNT(*)::float AS reliability
    FROM reporting.flight
    GROUP BY origin_airport_id, dest_airport_id, year
    HAVING COUNT(*) > 10000
) f
LEFT JOIN airport_list al ON f.origin_airport_id = al.origin_airport_id
LEFT JOIN airport_list al_2 ON f.dest_airport_id = al_2.origin_airport_id
;
CREATE OR REPLACE VIEW reporting.year_to_year_comparision AS
SELECT
    year,
    month,
    COUNT(*) AS flights_amount,
    SUM(is_delayed) / COUNT(*)::float AS reliability
FROM reporting.flight
GROUP BY year, month
ORDER BY year, month
;
CREATE OR REPLACE VIEW reporting.day_to_day_comparision AS
SELECT
    year,
    day_of_week,
    COUNT(*) AS flights_amount,
    SUM(is_delayed) / COUNT(*)::float AS reliability
FROM reporting.flight
GROUP BY year, day_of_week
ORDER BY year, day_of_week
;
CREATE OR REPLACE VIEW reporting.day_by_day_reliability AS
SELECT
    DATE(year || '-' || month || '-' || day_of_month) AS date,
    SUM(is_delayed) / COUNT(*)::float AS reliability
FROM reporting.flight
GROUP BY year, month, day_of_month
ORDER BY year, month, day_of_month