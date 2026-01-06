--Passing the source credential from command line via variable.
SELECT
    property_id,
    property_name,
    city,
    state,
    country
FROM {{ source('Property_dynamic', 'property') }}
