{% macro calc_credit_risk(paydex, rating, stress) %}
round(
  100 - (
    {{ paydex }} * 0.5 +
    case when {{ rating }} like '5A%' then 30 else 15 end +
    {{ stress }} * 10
  ), 2
)
{% endmacro %}
