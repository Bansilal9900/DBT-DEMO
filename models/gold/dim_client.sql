{{ config(materialized='incremental', unique_key='client_key',schema='GOLD') }}

with base as (
    select
        x.client_key,

        max(s.client_name) as client_name,
        max(s.client_legal_name) as client_legal_name,
        max(s.duns_number) as duns_number,
        max(case when s.source_system='ZOOMINFO' then s.source_system_id end) as zoominfo_id,
        max(s.industry_code) as industry_code_naics,
        max(s.employee_count) as employee_count,
        max(s.annual_revenue) as annual_revenue

    from {{ ref('stg_client') }} s
    join {{ ref('client_xref') }} x
      on s.source_system = x.source_system
     and s.source_system_id = x.source_system_id
    group by x.client_key
),

final as (
    select
        *,
        {{ calc_change_hash([
            'client_name',
            'client_legal_name',
            'duns_number',
            'employee_count',
            'annual_revenue',
            'industry_code_naics'
        ]) }} as change_hash
    from base
)

select
    *,
    current_date as effective_date,
    '9999-12-31'::date as expiry_date,
    true as active_flag,
    current_timestamp as created_timestamp
from final
