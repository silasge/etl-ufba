{% {% macro clean_flgs_nse(flg) %}
    case 
        when {{ flg }} = 'Tem' then 1
        when {{ flg }} = 'Não tem' then 0
    end
{% endmacro %}%}
