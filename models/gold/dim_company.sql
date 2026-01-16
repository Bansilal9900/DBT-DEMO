{{ config(
    materialized='incremental',
    unique_key='company_key',
    schema='GOLD'
) }}


select
    {{ dbt_utils.generate_surrogate_key(['s.source_system_id']) }} as company_key,
    x.client_key,
    s.source_system_id as company_id,
    s.client_name as company_name,
    s.employee_count,
    s.annual_revenue,
    s.industry_code,
    s.staging_timestamp as effective_date,
    '9999-12-31'::date as expiry_date,
    true as active_flag
from {{ ref('stg_client') }} s
join {{ ref('client_xref') }} x
  on s.source_system = x.source_system
 and s.source_system_id = x.source_system_id
where s.source_system = 'ZOOMINFO'
