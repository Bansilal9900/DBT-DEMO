{{ config(
    materialized='incremental',
    unique_key='snapshot_key',
    schema='GOLD'
) }}


select
    {{ dbt_utils.generate_surrogate_key(['client_key', 'current_date']) }} as snapshot_key,
    client_key,
    current_date as snapshot_date,
    employee_count,
    annual_revenue,
    {{ calc_growth('annual_revenue','lag(annual_revenue) over(partition by client_key order by current_date)') }} as revenue_growth_rate,
    {{ calc_growth('employee_count','lag(employee_count) over(partition by client_key order by current_date)') }} as employee_growth_rate,
    {{ calc_credit_risk('82','\'5A1\'','1') }} as credit_risk_score,
    {{ calc_digital_maturity('10') }} as digital_maturity_score,
    {{ calc_data_quality('50','46') }} as data_quality_score,
    current_timestamp as created_timestamp
from {{ ref('dim_client') }}
