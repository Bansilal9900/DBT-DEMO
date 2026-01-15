
{% macro filter_new_rows(load_ts_col) -%}
{% if is_incremental() %}
  where {{ load_ts_col }} >
        (select coalesce(max(LOAD_TIMESTAMP), '1900-01-01'::timestamp_ntz) from {{ this }})
{% endif %}
{%- endmacro %}
