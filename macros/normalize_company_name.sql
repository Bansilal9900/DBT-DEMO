{% macro normalize_company_name(col) %}
upper(
  trim(
    regexp_replace(
      {{ col }},
      '(\\b(INC|LLC|LTD|LIMITED|LP|L\\.P\\.|CORP|CORPORATION|GROUP|HOLDINGS)\\b)|[^A-Z0-9 ]',
      ''
    )
  )
)
{% endmacro %}
