with

source as (
    select * from {{ source('socioeconomic', 'Vestibular_2012_Inscritos') }}
),

stage_vestibular_2012 as (
    select
        ano::integer as ano_vestibular,
        inscrica::varchar as codigo_inscricao,
        nascim::varchar as data_nascimento,
        idade::integer as idade,
        faixaet::varchar as faixa_etaria,
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
        tipo1gr::varchar as tipo1gr,
        tipo2gr::varchar as tipo2gr,
        turn1gr::varchar as turn1gr,
        turn2gr::varchar as turn2gr,
        loc2gr::varchar as localizacao_escola,
        ano2gr::varchar as ano_graduacao,
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

select * from stage_vestibular_2012
