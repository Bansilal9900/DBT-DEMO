

{% macro to_ts_ntz(expr) %}
try_to_timestamp_ntz( {{ expr }} )
{% endmacro %}
