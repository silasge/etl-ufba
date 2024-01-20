with

uniao_socioeconomicos as (
    select * from {{ ref('stg_bi_vestibular_2009') }}
    union all
    select * from {{ ref('stg_bi_vestibular_2010') }}
    union all
    select * from {{ ref('stg_bi_vestibular_2011') }}
    union all
    select * from {{ ref('stg_bi_vestibular_2012') }}
    union all
    select * from {{ ref('stg_bi_vestibular_2013') }}
    union all
    select * from {{ ref('stg_vestibular_2005') }}
    union all
    select * from {{ ref('stg_vestibular_2006') }}
    union all
    select * from {{ ref('stg_vestibular_2007') }}
    union all
    select * from {{ ref('stg_vestibular_2008') }}
    union all
    select * from {{ ref('stg_vestibular_2009') }}
    union all
    select * from {{ ref('stg_vestibular_2010') }}
    union all
    select * from {{ ref('stg_vestibular_2011') }}
    union all
    select * from {{ ref('stg_vestibular_2012') }}
    union all
    select * from {{ ref('stg_vestibular_2013') }}
),

socioeconomico_tratado as (
    select
        a.ano_vestibular,
        lpad(
            regexp_extract(a.codigo_inscricao, '(\d+)'), 7, '0'
        ) as codigo_inscricao,
        a.data_nascimento,
        a.sexo,
        case
            when a.deficiencia = 'Auditiva' then 'Auditiva'
            when a.deficiencia like '%Motora%' then 'Motora'
            when a.deficiencia like '%Visual%' then 'Visual'
        end as deficiencia,
        a.area,
        b.curso_ajustado as curso,
        lower(strip_accents(a.bairro)) as bairro,
        lower(strip_accents(a.cidade)) as cidade,
        if(a.estado = 'NI', null, a.estado) as estado,
        c.situacao_vestibular_ajustado as situacao_vestibular,
        d.cidade_polo_ajustado as cidade_polo,
        case
            when a.origem_escola in ('Particular', 'Privada') then 'Privada'
            when a.origem_escola in ('Pública', 'Público') then 'Pública'
        end as origem_escola,
        case
            when a.etnia like '%Índio%' then 'Indígena'
            when a.etnia in ('Pardo', 'Preto') then 'Negro'
            when a.etnia in ('Outros', 'Outras') then 'Outras'
            else a.etnia
        end as etnia,
        case
            when 
                a.categoria_cotas in (
                    'Cotas: Aldeado ou quilombola de escola pública',
                    'Cotas: Índio-descendente de escola pública'
                ) then 'Indígena ou Quilombola; Escola Pública'
            when 
                a.categoria_cotas = 'Cotas: preto ou pardo de escola pública' 
                then 'Raça; Escola Pública'
            when 
                a.categoria_cotas 
                = 'Cotas: preto ou pardo de escola pública - menor renda' 
                then 'Raça; Escola Pública; Renda'
            when 
                a.categoria_cotas = 'Cotas: todas as etnias de escola pública' 
                then 'Escola Pública'
            when 
                a.categoria_cotas 
                = 'Cotas: todas as etnias de escola pública - menor renda' 
                then 'Escola Pública; Renda'
        end as categoria_cotas,
        if(a.cpf not in ('(null)', ''), a.cpf, null) as cpf,
        case 
            when 
                a.estado_civil 
                in (
                    'Desquitado', 
                    'Desquitado ou separado judicialmente', 
                    'Divorciado'
                ) 
                then 'Separado/Divorciado'
            else a.estado_civil
        end as estado_civil,
        case 
            when 
                lower(strip_accents(a.numero_filhos)) = 'acima de tres'
                then 'Acima de Três'
            else a.numero_filhos
        end as numero_filhos,
        {{ clean_local('a.local_residencia') }} as local_residencia,
        {{ clean_tipo_escola('a.tipo_escola_ensino_fundamental') }} as tipo_escola_ensino_fundamental,
        {{ clean_tipo_escola('a.tipo_escola_ensino_medio') }} as tipo_escola_ensino_medio,
        a.turno_escola_ensino_fundamental,
        a.turno_escola_ensino_medio,
        {{ clean_local('a.local_escola_ensino_medio') }} as local_escola_ensino_medio,
        case 
            when lower(a.ano_graduacao_ensino_medio) like '%ano passado%' then 'Ano Passado'
            when lower(a.ano_graduacao_ensino_medio) like '%este ano%' then 'Este ano'
            else a.ano_graduacao_ensino_medio
        end as ano_graduacao_ensino_medio,
        case 
            when lower(a.tipo_curso) like '%suplência%' then 'Supletivo'
            when lower(a.tipo_curso) in ('Colegial', 'Técnico', 'Magistério') then a.tipo_curso
            else a.tipo_curso
        end as tipo_curso,
        vezes_vestibular,
        case 
            when 
                a.periodo_cursinho is not null 
                and a.periodo_cursinho <> 'Não fiz cursinho' 
                then 1
            when a.periodo_cursinho is null then null
            else 0
        end as flg_cursinho,
        case 
            when a.periodo_cursinho like '%um semestre%' then 'Um semestre'
            when a.periodo_cursinho like '%mais de um ano%' then 'Mais de um ano'
            when a.periodo_cursinho like '%curso de revisão%' then 'Curso de revisão'
            when a.periodo_cursinho like '%um ano%' then 'Um ano'
        end as periodo_cursinho,
        influencia_vestibular,
        if(expectativa_vestibular ~ '.*(Outr).*', 'Outras', expectativa_vestibular) as expectativa_vestibular,
        case 
            when a.quando_trabalhou like '%Sim%' then 1
            when a.quando_trabalhou is null then null
            else 0
        end as flg_trabalhou_na_escola,
        case 
            when 
                a.quando_trabalhou like '%Educação Básica%'
                or a.quando_trabalhou like '%Ensino Fundamental%' 
                then 'Ensino Fundamental'
            when a.quando_trabalhou like '%Ensino Médio%' then 'Ensino Médio'
        end as quando_trabalhou,
        case 
            when a.vida_economica = 'Não trabalha e gastos são financiados' then 0
            when a.vida_economica is null then null
            else 1
        end as flg_trabalha_atualmente,
        case 
            when
                a.vida_economica = 'Trabalha e é responsável pelo próprio sustento'
                then 'Autossuficiente'
            when
                a.vida_economica in (
                    'Trabalha e é principal responsável pelo sustento da família',
                    'Trabalha, é respons. pelo sustento e contribui para outros'
                )
                then 'Autossuficiente; Contribui com a Familia'
            when
                a.vida_economica = 'Trabalha, mas recebe ajuda financeira'
                then 'Parcialmente Suficiente'
            else 'Dependente'
        end as vida_economica,
        case 
            when a.carga_horaria_trabalho like '%40 horas%' then '40h'
            when a.carga_horaria_trabalho like '%20 horas%' then '20h'
            when a.carga_horaria_trabalho like '%20 a 30 horas%' then '20 a 30h'
            when 
                a.carga_horaria_trabalho = 'Não trabalha' 
                or a.carga_horaria_trabalho is null then null
            else 'Depende'
        end as carga_horaria_trabalho,
        case 
            when a.carga_horaria_trabalho like '%noite%' then 1
            when 
                a.carga_horaria_trabalho = 'Não trabalha' 
                or a.carga_horaria_trabalho is null then null
            else 0
        end as flg_trabalho_noturno,
        {{ clean_ocupacao('a.tipo_ocupacao') }} as tipo_ocupacao,
        a.pretende_trabalhar,
        a.renda_total,
        a.responsavel_renda,
        {{ clean_educacao('a.educacao_pai') }} as educacao_pai,
        {{ clean_educacao('a.educacao_mae') }} as educacao_mae,
        case 
            when a.flg_conjuge_trabalha like '%Trabalha%' then 1
            when 
                a.flg_conjuge_trabalha in (
                    'Está desempregado(a)',
                    'Vive de renda',
                    'É aposentado(a)',
                    'É estudante'
                )
                then 0
            else null
        end as flg_conjuge_trabalha,
        {{ clean_ocupacao('a.ocupacao_pai') }} as ocupacao_pai,
        {{ clean_ocupacao('a.ocupacao_mae') }} as ocupacao_mae,
        {{ clean_flgs_nse('a.flg_celular') }} as flg_celular,
        {{ clean_flgs_nse('a.flg_computador') }} as flg_computador,
        {{ clean_flgs_nse('a.flg_internet') }} as flg_internet,
        {{ clean_flgs_nse('a.flg_quarto') }} as flg_quarto,
        {{ clean_flgs_nse('a.flg_automovel') }} as flg_automovel,
        cor
    from
        uniao_socioeconomicos as a
    left join
        {{ ref("cursos") }} as b
        on a.curso = b.curso
    left join
        {{ ref("situacao_vestibular") }} as c
        on a.situacao_vestibular = c.situacao_vestibular
    left join
        {{ ref("cidade_polo") }} as d
        on a.cidade_polo = d.cidade_polo

)

select * from socioeconomico_tratado
