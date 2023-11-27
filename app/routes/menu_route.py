from fastapi import APIRouter, Depends
from sqlalchemy.exc import IntegrityError
from app.config.db import engine
from app.helpers.exception import handle_exception
from auth.jwt_bearer import JWTBearer
from app.models.tables import tbl_severity, tbl_system, tbl_status, tbl_category
from sqlalchemy import text

menu_router = APIRouter(tags=['menu'], dependencies=[Depends(JWTBearer())])

# Get all menus
@menu_router.get('/menu')
async def get_menu():
    with engine.connect() as connection:
        try:
            severity = connection.execute(tbl_severity.select()).fetchall()
            status = connection.execute(tbl_status.select()).fetchall()
            categories = connection.execute(tbl_category.select()).fetchall()
            query = text(
                """SELECT T1.* FROM tbl_users T1 JOIN tbl_user_profile T2 ON T1.id = T2.id_user WHERE T2.id_profile = 2 OR T2.id_profile = 1"""
            )
            query2 =  text(
                """SELECT T1.*, T2.platform FROM tbl_system T1 JOIN tbl_platform T2 ON T1.id_platform = T2.id"""
            )
            system = connection.execute(query2).fetchall()
            devs = connection.execute(query).fetchall()
            result = {
                "severity": severity,
                "system": system,
                "status": status,
                "categories": categories,
                "devs" : devs 
            }
            return {"error": False, 'msg':result}
        except IntegrityError as exc:
            return await handle_exception(exc)
