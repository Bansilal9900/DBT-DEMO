{% macro calc_growth(curr, prev) %}
case
  when {{ prev }} is null or {{ prev }} = 0 then null
  else round(({{ curr }} - {{ prev }}) / {{ prev }} * 100, 2)
end
{% endmacro %}
