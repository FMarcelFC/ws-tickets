from fastapi import APIRouter
from app.config.db import engine
from sqlalchemy import text
from sqlalchemy.exc import IntegrityError
from app.schemas.Scan import Scan
from app.models.tables import tbl_scan
from app.helpers.exception import handle_exception

scan_router = APIRouter(tags=['scan'])

@scan_router.get('/scan/get_networks')
async def get_networks():
    with engine.connect() as connection:
        try:
            query = text(
                """SELECT * FROM tbl_scan WHERE type = 0"""
            )
            result = connection.execute(query).fetchall()
            return result
        except IntegrityError as exc:
            return await handle_exception(exc)

@scan_router.get('/scan/get_urls')
async def get_urls():
    with engine.connect() as connection:
        try:
            query = text(
                """SELECT * FROM tbl_scan WHERE type = 1"""
            )
            result = connection.execute(query).fetchall()
            return result
        except IntegrityError as exc:
            return await handle_exception(exc)

@scan_router.post('/scan')
async def create_scan(scan: Scan):
    with engine.connect() as connection:
        try:
            new_scan = scan.dict()
            result = connection.execute(tbl_scan.insert().values(new_scan))
            return {"error": False, "msg": "Scan inserted successfully."}
        except Exception as exc:
            return await handle_exception(exc)
