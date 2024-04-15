{#
    This macro returns the longitude latitude built for bigquery as "<lat>, <long>"
#}

{% macro get_bq_formatted_long_lat(long,lat) %}
    (CONCAT({{ lat }},', ',{{ long }}))
{% endmacro %}