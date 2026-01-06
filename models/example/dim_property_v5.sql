SELECT
    property_id,
    property_name,
    city,
    state,
    country
FROM {{ source('broker', 'property') }}  

UNION all

SELECT
    property_id,
    property_name,
    city,
    state,
    country
FROM {{ source('Property', 'property') }}  


