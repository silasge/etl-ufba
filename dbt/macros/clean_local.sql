{% {% macro clean_local(local) %}
    case 
        when {{ local }} ~ '.*(Salvador|Capital).*' then 'Capital ou RM da Bahia'
        when {{ local }} ~ '.*(Interior|baiano).*' then 'Interior da Bahia'
        when lower({{ local }}) ~ '.*(outro estado).*' then 'Outro Estado'
        when lower({{ local }}) ~ '.*(país).*' then 'Outro país'
    end
{% endmacro %}%}
