with

source as (
    select * from {{ source('socioeconomic', 'Vestibular_2013_Inscritos') }}
),

stage_vestibular_2013 as (
    select
        ano::integer as ano_vestibular,
        inscrica::varchar as codigo_inscricao,
        strptime(
            if(nascim = '(null)', null, nascim), '%d/%m/%Y'
        ) as data_nascimento,
        sexo::varchar as sexo,
        deficie::varchar as deficiencia,
        area::varchar as area,
        curso::varchar as curso,
        bairro::varchar as bairro,
        cidade::varchar as cidade,
        estado::varchar as estado,
        situacao::varchar as situacao_vestibular,
        escfinal::real as escore,
        polo::varchar as cidade_polo,
        origem::varchar as origem_escola,
        etnia::varchar as etnia,
        catselec::varchar as categoria_cotas,
        cpf::varchar as cpf,
        estcivil::varchar as estado_civil,
        numfilho::varchar as numero_filhos,
        resid::varchar as local_residencia,
        tipo1gr::varchar as tipo_escola_ensino_fundamental,
        tipo2gr::varchar as tipo_escola_ensino_medio,
        turn1gr::varchar as turno_escola_ensino_fundamental,
        turn2gr::varchar as turno_escola_ensino_medio,
        loc2gr::varchar as local_escola_ensino_medio,
        ano2gr::varchar as ano_graduacao_ensino_medio,
        tipcurso::varchar as tipo_curso,
        numvest::varchar as vezes_vestibular,
        cursinho::varchar as periodo_cursinho,
        influenc::varchar as influencia_vestibular,
        expectat::varchar as expectativa_vestibular,
        trab::varchar as quando_trabalhou,
        vidaecon::varchar as vida_economica,
        cargahor::varchar as carga_horaria_trabalho,
        tipocup::varchar as tipo_ocupacao,
        prettrab::varchar as pretende_trabalhar,
        rendatot::varchar as renda_total,
        resprend::varchar as responsavel_renda,
        instrpai::varchar as educacao_pai,
        instrmae::varchar as educacao_mae,
        trabconj::varchar as flg_conjuge_trabalha,
        ocuppai::varchar as ocupacao_pai,
        ocupmae::varchar as ocupacao_mae,
        celular::varchar as flg_celular,
        comput::varchar as flg_computador,
        internet::varchar as flg_internet,
        quarto::varchar as flg_quarto,
        automove::varchar as flg_automovel,
        cor::varchar as cor
    from
        source

)

select * from stage_vestibular_2013
