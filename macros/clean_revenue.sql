{% macro clean_revenue(col) %}
case
  when {{ col }} is null then null
  else replace({{ col }}, ',', '')::number(38,2)
end
{% endmacro %}
