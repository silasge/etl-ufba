{% {% macro clean_tipo_escola(tipo_escola) %}
    case 
        when lower({{ tipo_escola }}) like '%municipal%' then'Municipal'
        when lower({{ tipo_escola }}) like '%estadual%' then 'Estadual'
        when lower({{ tipo_escola }}) like '%federal%' then 'Federal'
        when {{ tipo_escola }} is null then null
        else 'Privada'
    end
{% endmacro %}%}
