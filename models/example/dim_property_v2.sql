{{ config(
    materialized = 'table',
    database = var('target_database'),
    schema = var('target_schema', 'staging')
) }}

SELECT
    property_id,
    property_name,
    city,
    state,
    country
FROM {{ source('Property', 'property') }}
