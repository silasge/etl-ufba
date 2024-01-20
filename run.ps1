# Install poetry dependences
poetry install

# Download gdrive files
poetry run download `
    -i $env:SOCIOECONOMICO `
    -i $env:ACADEMICO `

# Extract zip files
$zip_socioeco = ".\gdrive\socioeconomico.zip"
$zip_academica = ".\gdrive\ufba_academica.zip"

poetry run unzip `
    -zip $zip_socioeco `
    -zip $zip_academica `

# Delete all zips
Remove-Item $zip_socioeco
Remove-Item $zip_academica 

# Run dbt
Set-Location .\dbt
poetry run dbt seed
poetry run dbt run
Set-Location ..