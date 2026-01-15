
{% macro extract_domain(url_col) -%}
    lower(
        regexp_replace(
            regexp_replace(
                regexp_replace({{ url_col }},
                    '^(https?://)', ''   -- remove http:// or https://
                ),
                '^www\\.', ''          -- remove leading www.
            ),
            '/.*$', ''                 -- remove everything after first slash
        )
    )
{%- endmacro %}
