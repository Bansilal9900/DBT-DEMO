
{{ snowflake_incremental_merge("ZOOMINFO_ID") }}

with src as (
  select
    BRONZE_KEY,
    ZOOMINFO_ID,
    COMPANY_NAME,
    TICKER,
    WEBSITE,
    EMPLOYEE_COUNT,
    REVENUE,
    INDUSTRY,
    FOUNDED_YEAR,
    HQ_ADDRESS, HQ_CITY, HQ_STATE, HQ_COUNTRY,
    LINKEDIN_URL,
    TECHNOLOGIES,
    RAW_JSON,
    LOAD_TIMESTAMP,
    MD5_HASH
  from {{ source('bronze','BRONZE_ZOOMINFO_COMPANY') }}
  {{ filter_new_rows('LOAD_TIMESTAMP') }}
),

clean as (
  select
  BRONZE_KEY,
    ZOOMINFO_ID,
    {{ normalize_company_name('COMPANY_NAME') }} as COMPANY_NAME_NORM,
    upper(nullif(TICKER, '')) as TICKER,
    lower(WEBSITE) as WEBSITE,
    try_cast(EMPLOYEE_COUNT as number(38,0)) as EMPLOYEE_COUNT,
    try_cast(REVENUE as number(38,2)) as REVENUE,
    INDUSTRY,
    try_cast(FOUNDED_YEAR as number(38,0)) as FOUNDED_YEAR,
    HQ_ADDRESS, HQ_CITY, HQ_STATE, HQ_COUNTRY,
    LINKEDIN_URL,
    TECHNOLOGIES,
    {{ safe_parse_json('RAW_JSON') }} as RAW_JSON,
    LOAD_TIMESTAMP,
    MD5_HASH
  from src
)

select * from clean
