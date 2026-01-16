{% macro calc_data_quality(total_fields, populated_fields) %}
round(({{ populated_fields }} / nullif({{ total_fields }},0)) * 100, 2)
{% endmacro %}
