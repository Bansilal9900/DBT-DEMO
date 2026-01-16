{% snapshot dim_client_snapshot %}

{{
  config(
    target_schema='GOLD',
    unique_key='client_key',
    strategy='check',
    check_cols=[
      'client_name',
      'client_legal_name',
      'duns_number',
      'employee_count',
      'annual_revenue',
      'industry_code_naics'
    ]
  )
}}

select
    client_key,
    client_name,
    client_legal_name,
    duns_number,
    employee_count,
    annual_revenue,
    industry_code_naics
from {{ ref('dim_client') }}

{% endsnapshot %}
