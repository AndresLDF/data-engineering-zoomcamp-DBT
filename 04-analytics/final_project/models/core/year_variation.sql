{{ 
    config(
    materialized="table"
    )
}}

WITH early_years AS (
  SELECT
    pais,
    AVG(foco_count) AS mean_foco_count
  FROM {{ ref("fires_year") }}
  WHERE pais != 'Falkland Islands' AND year BETWEEN 2009 AND 2011
  GROUP BY pais
),
late_years AS (
  SELECT
    pais,
    AVG(foco_count) AS mean_foco_count
  FROM {{ ref("fires_year") }}
  WHERE pais != 'Falkland Islands' AND year BETWEEN 2020 AND 2022
  GROUP BY pais
),
combined_data AS (
  SELECT
    e.pais,
    e.mean_foco_count AS early_mean,
    l.mean_foco_count AS late_mean,
    ((l.mean_foco_count - e.mean_foco_count) / NULLIF(e.mean_foco_count, 0)) * 100 AS percent_difference
  FROM early_years AS e
  LEFT JOIN late_years AS l
  ON e.pais = l.pais
)
SELECT
  *
FROM combined_data
ORDER BY pais