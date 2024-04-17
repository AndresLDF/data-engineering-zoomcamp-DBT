{{ 
    config(
    materialized="table"
    )
}}

SELECT
  year,
  lat,
  lon,
  CAST(lat AS STRING) || CAST(lon AS STRING) AS latlonid,
  COUNT(foco_id) AS foco_count
FROM {{ ref("stg_staging__all_data") }}
GROUP BY year, latlonid
ORDER BY year, latlonid