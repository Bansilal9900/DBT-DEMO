{% macro pick_best_value(zoom_val, dnb_val, zoom_score, dnb_score, preferred_source) %}
case
  when '{{ preferred_source }}' = 'DNB' and {{ dnb_val }} is not null then {{ dnb_val }}
  when '{{ preferred_source }}' = 'ZOOMINFO' and {{ zoom_val }} is not null then {{ zoom_val }}
  when {{ dnb_score }} >= {{ zoom_score }} then {{ dnb_val }}
  else {{ zoom_val }}
end
{% endmacro %}
