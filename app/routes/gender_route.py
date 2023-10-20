from fastapi import APIRouter, Depends
from sqlalchemy.exc import IntegrityError
from app.config.db import engine
from app.helpers.exception import handle_exception
from auth.jwt_bearer import JWTBearer
from app.models.tables import tbl_gender

gender_router = APIRouter(tags=['gender'], dependencies=[Depends(JWTBearer())])

# Get all genders
@gender_router.get('/get_genders')
async def get_genders():
    with engine.connect() as connection:
        try:
            result = connection.execute(tbl_gender.select()).fetchall()
            return {"error": False, 'msg':result}
        except IntegrityError as exc:
            return await handle_exception(exc)
