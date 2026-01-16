{% macro calc_match_score(a, b) %}
(
  case when {{ a }}.domain_normalized = {{ b }}.domain_normalized then 50 else 0 end +
  case when {{ a }}.standardized_name = {{ b }}.standardized_name then 30 else 0 end +
  case
    when abs({{ a }}.annual_revenue - {{ b }}.annual_revenue)
         / nullif({{ b }}.annual_revenue,0) < 0.10
    then 20 else 0
  end
)
{% endmacro %}
