## Introdução

O objetivo deste projeto é replicar todo o processo de ETL que eu havia feito para os dados do meu [TCC](https://repositorio.ufba.br/handle/ri/34582) na Universidade Federal da Bahia (UFBA). Na época, há cerca de 3 anos, eu fiz todo o código o código usando o tidyverse, pelo R, o que não é problema (muito pelo contrário), mas à época fiz tudo de forma extremamente desorganizada e com nenhuma boa prática de engenharia de dados.

Como últimamente tenho tido interesse em aprender dbt (Data Build Tool), resolvi replicar meus dados do TCC. Mas dessa vez, bem melhor organizado e com o uso de boas práticas.

## Projeto

O repositório é composto por duas etapas. Na primeira, uso python para baixar os dados brutos no format .parquet de uma conta no google drive. Depois de baixar, faço as transformações e o carregamento dos dados usando a combinação de [dbt](https://www.getdbt.com/) + [DuckDB](https://duckdb.org/).

Óbviamente, nem os dados brutos e nem a base de dados estão disponíveis publicamente por conterem informações sensíveis. A idéia é deixar público só o código e qualquer análise que eu possa fazer com esses dados. Portanto o processo de ETL só pode ser feito por mim.

## Setup

O projeto requer o [Poetry](https://python-poetry.org/) instalado na máquina. Depois de instalado, eu rodo o script do powershell run.ps1 que instala as dependências e faz todo o processo de ETL.

