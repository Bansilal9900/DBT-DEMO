SELECT
   source_name
FROM {{ source('Config', 'MODEL_CONFIG') }} 

