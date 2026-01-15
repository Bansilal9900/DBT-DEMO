{% macro snowflake_incremental_merge(unique_key) -%}
  {{
    config(
      materialized='incremental',
      incremental_strategy='merge',
      unique_key=unique_key,
      on_schema_change='sync_all_columns'
    )
  }}
{%- endmacro %}
