{#
    This macro returns the forest area code from the wildfire number
#}
{% macro get_wildfire_area_code(wildfire_number) %}
    (substring({{ wildfire_number }}, 1, 1))
{% endmacro %}
