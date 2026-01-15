
{% macro safe_parse_json(expr) %}
case
  when typeof( {{ expr }} ) = 'VARIANT' then ( {{ expr }} )
  else try_parse_json( {{ expr }} )
end
{% endmacro %}
