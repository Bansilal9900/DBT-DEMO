{% macro calc_change_hash(cols) %}
md5(
  concat_ws(
    '|',
    {% for c in cols %}
      coalesce({{ c }}::varchar,'')
      {% if not loop.last %},{% endif %}
    {% endfor %}
  )
)
{% endmacro %}
