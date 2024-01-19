from pathlib import Path
from typing import Tuple

import click
from pydrive2.auth import GoogleAuth
from pydrive2.drive import GoogleDrive


def get_gdrive() -> None:
    gauth = GoogleAuth()
    gauth.LocalWebserverAuth()
    drive = GoogleDrive(gauth)
    return drive


def get_file_from_gdrive(gdrive: GoogleDrive, id: str, destination: Path) -> None:
    file = gdrive.CreateFile({"id": id})
    file_title = file["title"]
    file.GetContentFile(destination / file_title)


@click.command()
@click.option("-i", "--id", multiple=True, required=True)
@click.option("-d", "--destination", required=True, type=str, default="./gdrive")
def download_from_gdrive(id: Tuple[str], destination: str) -> None:
    # Get gdrive auth
    gdrive = get_gdrive()
    # Transform destination in a Path object and create directory if it doesn't exists
    d = Path(destination)
    d.mkdir(exist_ok=True)
    # get files in a loop
    for i in id:
        get_file_from_gdrive(gdrive=gdrive, id=i, destination=d)
