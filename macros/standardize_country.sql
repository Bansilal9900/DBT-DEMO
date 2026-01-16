{% macro standardize_country(col) %}
case
  when {{ col }} is null then null
  when upper({{ col }}) in ('USA','U.S.A','US','UNITED STATES') then 'UNITED STATES'
  when upper({{ col }}) in ('UK','U.K.','GB','UNITED KINGDOM') then 'UNITED KINGDOM'
  else upper({{ col }})
end
{% endmacro %}
