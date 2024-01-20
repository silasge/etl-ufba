{% {% macro clean_educacao(educacao) %}
    case 
        when {{ educacao }} like '%Primário%' then replace({{ educacao }}, 'Primário', 'Fundamental I')
        when {{ educacao }} like '%Ginasial%' then replace({{ educacao }}, 'Ginasial', 'Fundamental II')
        when {{ educacao }} like '%Colegial%' then replace({{ educacao }}, 'Colegial', 'Médio')
        when {{ educacao }} is null then null
        else {{ educacao }}
    end
{% endmacro %}%}
