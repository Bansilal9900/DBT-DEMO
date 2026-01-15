
{% macro to_num(expr, precision=38, scale=0) %}
try_to_number( {{ expr }} )::number({{ precision }}, {{ scale }})
{% endmacro %}