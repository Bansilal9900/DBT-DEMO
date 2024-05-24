{%- set source_model = ["personal_data"] -%}
{%- set src_pk = "ID" -%}
{%- set src_nk = "FIRST_NAME" -%}
{%- set src_ldts = "lAST_NAME" -%}
{%- set src_source = "SURNAME" -%}

{{ automate_dv.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                  src_source=src_source, source_model=source_model) }}