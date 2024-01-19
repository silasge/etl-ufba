with

source as (
    select * from {{ source('academic', 'ufba_academica') }}
),

ufba_academica_selected as (
    select 
        cpf::varchar as cpf,
        mtr::varchar as mtr,
        inscrica::varchar as inscrica,
        nome::varchar as nome,
        per_ingr::real as per_ingr,
        cd_forma_ingr::real as cd_forma_ingr,
        descr_forma_ingr::varchar as descr_forma_ingr,
        per_saida::real as per_saida,
        cd_forma_saida::real as cd_forma_saida,
        descr_forma_saida::varchar as descr_forma_saida,
        cr::real as cr,
        escore::real as escore,
        class_geral::real as class_geral,
        categoria_class::varchar as categoria_class,
        cod_curso::real as cod_curso,
        per_crs_ini::real as per_crs_ini,
        nome_curso::varchar as nome_curso,
        colegiado::real as colegiado,
        col_nm_colegiado::varchar as col_nm_colegiado,
        per_let_disc::real as per_let_disc,
        disc::varchar as disc,
        ch_disc::real as ch_disc,
        nat_disc::varchar as nat_disc,
        tur::varchar as tur,
        nota::real as nota,
        resultado::varchar as resultado,
        doc_nu_matricula_docente::varchar as doc_nu_matricula_docente,
        doc_nm_docente::varchar as doc_nm_docente,
        doc_vinculo::varchar as doc_vinculo,
        doc_titulacao::varchar as doc_titulacao,
        doc_nivel::varchar as doc_nivel,
        doc_regime_trab::varchar as doc_regime_trab,
        nascimento::varchar as nascimento,
        aln_cd_estado_civil::varchar as aln_cd_estado_civil,
        ecv_ds_estado_civil::varchar as ecv_ds_estado_civil,
        sexo::varchar as sexo,
        dtnasc::varchar as dtnasc,
        aln_sg_estado_nascimento::varchar as aln_sg_estado_nascimento,
        aln_nm_pai::varchar as aln_nm_pai,
        aln_nm_mae::varchar as aln_nm_mae,
        aln_cd_cor::varchar as aln_cd_cor,
        cor_nm_cor::varchar as cor_nm_cor,
        aln_nm_cidade_nascimento::varchar as aln_nm_cidade_nascimento,
        eda_nm_email::varchar as eda_nm_email
    from 
        source

)

select * from ufba_academica_selected
