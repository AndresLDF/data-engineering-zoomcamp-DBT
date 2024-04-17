{{ 
    config(
    materialized="table"
    )
}}

SELECT
  year,
  pais,
  COUNT(foco_id) AS foco_count
FROM {{ ref("stg_staging__all_data") }}
GROUP BY year, pais
ORDER BY year, pais