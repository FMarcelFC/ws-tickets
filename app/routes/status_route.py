from fastapi import APIRouter, Depends
from sqlalchemy.exc import IntegrityError
from app.config.db import engine
from app.helpers.exception import handle_exception
from auth.jwt_bearer import JWTBearer
from app.models.tables import tbl_status

status_router = APIRouter(tags=['status'], dependencies=[Depends(JWTBearer())])

# Get all status
@status_router.get('/status')
async def get_status():
    with engine.connect() as connection:
        try:
            result = connection.execute(tbl_status.select()).fetchall()
            return {"error": False, 'msg':result}
        except IntegrityError as exc:
            return await handle_exception(exc)
