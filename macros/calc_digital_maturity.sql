{% macro calc_digital_maturity(tech_count) %}
case
  when {{ tech_count }} >= 20 then 90
  when {{ tech_count }} >= 10 then 70
  when {{ tech_count }} >= 5 then 50
  else 30
end
{% endmacro %}
