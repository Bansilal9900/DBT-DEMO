{% macro calc_match_confidence(domain, name, duns, revenue, employees) %}
(
  case when {{ domain }} is not null then 30 else 0 end +
  case when {{ name }} is not null then 20 else 0 end +
  case when {{ duns }} is not null then 20 else 0 end +
  case when {{ revenue }} is not null then 15 else 0 end +
  case when {{ employees }} is not null then 15 else 0 end
)
{% endmacro %}
