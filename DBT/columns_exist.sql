{% test columns_exist(model) %}
    {#
        Check if all column in documentation exist in the table.
        An error will be call if the column does not exist.
    #}
    {% if execute %}
        {% set models = [] %}
        {% for node in graph.nodes.values() | selectattr("resource_type", "equalto", "model") | selectattr("name", "equalto", model.identifier) %}
            {% do models.append(node) %}
        {% endfor %}

        {% if models|count != 1 %}
            {{ exceptions.raise_compiler_error(model.identifier ~ " not found in graph") }}
        {% endif %}

        {% set test_model = models|first %}

        with column_check as (
            select
            {% for column_name in test_model.columns %}
                {{ column_name }},
            {% endfor %}
            from {{ model }}
            where 1=0
            limit 1
        )

        select * from column_check
    {% endif %}
{% endtest %}
