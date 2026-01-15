
{% macro generate_company_sk(zoominfo_id, duns_number) -%}
  {{ dbt_utils.generate_surrogate_key([zoominfo_id, duns_number]) }}
{%- endmacro %}
