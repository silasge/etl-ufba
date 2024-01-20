{% {% macro clean_ocupacao(ocupacao) %}
    if(lower({{ ocupacao }}) in ('Não exerce atividade remunerada', 'Não trabalha'), null, {{ ocupacao }})
{% endmacro %}%}
