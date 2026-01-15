
{{ snowflake_incremental_merge("DUNS_NUMBER") }}

with src as (
  select
    BRONZE_KEY,
    DUNS_NUMBER,
    BUSINESS_NAME,
    PRIMARY_ADDRESS,
    EMPLOYEE_TOTAL,
    SALES_REVENUE_USD,
    SIC_CODE,
    NAICS_CODE,
    YEAR_STARTED,
    PARENT_DUNS, GLOBAL_ULTIMATE_DUNS, FAMILY_TREE_SIZE,
    PAYDEX_SCORE,
    CREDIT_RATING,
    FINANCIAL_STRESS,
    OUT_OF_BUSINESS,
    RAW_JSON,
    LOAD_TIMESTAMP,
    MD5_HASH
  from {{ source('bronze','BRONZE_DNB_COMPANY') }}
  {{ filter_new_rows('LOAD_TIMESTAMP') }}
),

clean as (
  select
    BRONZE_KEY,
    DUNS_NUMBER,
    {{ normalize_company_name('BUSINESS_NAME') }} as COMPANY_NAME_NORM,
    PRIMARY_ADDRESS,
    try_cast(EMPLOYEE_TOTAL as number(38,0)) as EMPLOYEE_COUNT,
    try_cast(SALES_REVENUE_USD as number(38,2)) as REVENUE,
    try_cast(SIC_CODE as number(38,0)) as SIC_CODE,
    try_cast(NAICS_CODE as number(38,0)) as NAICS_CODE,
    try_cast(YEAR_STARTED as number(38,0)) as FOUNDED_YEAR,
    PARENT_DUNS, GLOBAL_ULTIMATE_DUNS, FAMILY_TREE_SIZE,
    try_cast(PAYDEX_SCORE as number(38,0)) as PAYDEX_SCORE,
    CREDIT_RATING,
    try_cast(FINANCIAL_STRESS as number(38,0)) as FINANCIAL_STRESS,
    try_cast(OUT_OF_BUSINESS as boolean) as OUT_OF_BUSINESS,
    {{ safe_parse_json('RAW_JSON') }} as RAW_JSON,
    LOAD_TIMESTAMP,
    MD5_HASH
  from src
)

select * from clean
