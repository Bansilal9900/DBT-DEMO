SELECT
    property_id,
    property_name,
    city,
    state4,
    country
FROM {{ source('Property', 'property') }}  


