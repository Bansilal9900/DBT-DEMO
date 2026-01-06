SELECT
   source_name
FROM {{ source('config', 'MODEL_CONFIG') }} 

