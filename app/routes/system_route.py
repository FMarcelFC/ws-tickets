from fastapi import APIRouter, Depends
from sqlalchemy.exc import IntegrityError
from sqlalchemy import text
from app.config.db import engine
from app.helpers.exception import handle_exception
from auth.jwt_bearer import JWTBearer
from app.models.tables import tbl_system

system_router = APIRouter(tags=['system'], dependencies=[Depends(JWTBearer())])

# Get all systems
@system_router.get('/get_systems')
async def get_systems():
    with engine.connect() as connection:
        try:
            query = text(
                """SELECT T1.*, T2.platform platform FROM tbl_system T1 
                JOIN tbl_platform T2 ON T1.id_platform = T2.id"""
            )
            result = connection.execute(query).fetchall()
            return {"error": False, 'msg':result}
        except IntegrityError as exc:
            return await handle_exception(exc)
