{{ config(materialized='incremental', unique_key='source_system_id',schema='SILVER') }}

select
    {{ dbt_utils.generate_surrogate_key(['source_system','source_system_id']) }} as xref_key,
    source_system,
    source_system_id,
    {{ dbt_utils.generate_surrogate_key(['standardized_name']) }} as client_key,
    'DETERMINISTIC' as match_type,
    match_confidence,
    true as is_current,
    current_date as link_start_date,
    null as link_end_date,
    current_timestamp as created_timestamp
from {{ ref('stg_client') }}
{% if is_incremental() %}
where staging_timestamp > (select max(created_timestamp) from {{ this }})
{% endif %}
