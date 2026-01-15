
{% macro normalize_company_name(name) -%}
  INITCAP(TRIM({{ name }}))
{%- endmacro %}