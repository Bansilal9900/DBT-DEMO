SELECT
    property_id,
    property_name,
    city,
    state,
    country
FROM {{ source('Property_dynamic', 'property') }} --Dynamic Source.

UNION all

SELECT
    property_id,
    property_name,
    city,
    state,
    country
FROM {{ source('Property', 'property') }} --Hard coded source
