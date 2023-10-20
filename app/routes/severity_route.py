from fastapi import APIRouter, Depends
from sqlalchemy.exc import IntegrityError
from app.config.db import engine
from app.helpers.exception import handle_exception
from auth.jwt_bearer import JWTBearer
from app.models.tables import tbl_severity

severity_router = APIRouter(tags=['severity'], dependencies=[Depends(JWTBearer())])

# Get all severity levels
@severity_router.get('/severity')
async def get_severity():
    with engine.connect() as connection:
        try:
            result = connection.execute(tbl_severity.select()).fetchall()
            return {"error": False, 'msg':result}
        except IntegrityError as exc:
            return await handle_exception(exc)
