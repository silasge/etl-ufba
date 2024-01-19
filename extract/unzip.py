from pathlib import Path
from zipfile import ZipFile

import click


def unzip(zip_path: Path) -> None:
    new_path = zip_path.parent / zip_path.name.replace(".zip", "")
    new_path.mkdir(parents=True, exist_ok=True)
    # extract file in the new path
    with ZipFile(zip_path, "r") as z:
        z.extractall(path=new_path)


@click.command()
@click.option("-zip", "--zip-path", multiple=True, required=True)
def unzip_gdrive_files(zip_path) -> None:
    for z in zip_path:
        z = Path(z)
        unzip(zip_path=z)
