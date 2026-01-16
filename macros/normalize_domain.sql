{% macro normalize_domain(col) %}
lower(
  trim(
    regexp_replace(
      {{ col }},
      '^(https?://)?(www\\.)?',
      ''
    )
  )
)
{% endmacro %}
