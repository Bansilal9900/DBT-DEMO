{{ config(materialized='incremental', unique_key='staging_key',schema='SILVER') }}

with zoominfo as (
select
    {{ dbt_utils.generate_surrogate_key(['zoominfo_id','\'ZOOMINFO\'']) }} as staging_key,
    'ZOOMINFO' as source_system,
    zoominfo_id as source_system_id,
    company_name as client_name,
    company_name as client_legal_name,
    null as duns_number,
    {{ normalize_domain('website') }} as website,
    hq_address as address,
    hq_city as city,
    hq_state as state,
    {{ standardize_country('hq_country') }} as country,
    null as postal_code,
    null as industry_code,
    employee_count,
    {{ clean_revenue('revenue') }} as annual_revenue,
    {{ normalize_company_name('company_name') }} as standardized_name,
    {{ normalize_domain('website') }} as domain_normalized,
    {{ calc_match_confidence('website','company_name','null','revenue','employee_count') }} as match_confidence,
    current_timestamp as staging_timestamp
from {{ source('bronze','bronze_zoominfo_company') }}
{% if is_incremental() %}
where load_timestamp > (select max(staging_timestamp) from {{ this }})
{% endif %}
),

dnb as (
select
    {{ dbt_utils.generate_surrogate_key(['duns_number','\'DNB\'']) }} as staging_key,
    'DNB' as source_system,
    duns_number as source_system_id,
    business_name as client_name,
    business_name as client_legal_name,
    duns_number,
    null as website,
    primary_address as address,
    null as city,
    null as state,
    'UNITED STATES' as country,
    null as postal_code,
    naics_code as industry_code,
    employee_total as employee_count,
    {{ clean_revenue('sales_revenue_usd') }} as annual_revenue,
    {{ normalize_company_name('business_name') }} as standardized_name,
    null as domain_normalized,
    {{ calc_match_confidence('null','business_name','duns_number','sales_revenue_usd','employee_total') }} as match_confidence,
    current_timestamp as staging_timestamp
from {{ source('bronze','bronze_dnb_company') }}
{% if is_incremental() %}
where load_timestamp > (select max(staging_timestamp) from {{ this }})
{% endif %}
)

select * from zoominfo
union all
select * from dnb
