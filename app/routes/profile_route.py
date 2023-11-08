from fastapi import APIRouter, Depends
from sqlalchemy.exc import IntegrityError
from app.config.db import engine
from app.helpers.exception import handle_exception
from auth.jwt_bearer import JWTBearer
from app.models.tables import tbl_profile

profile_router = APIRouter(tags=['profile'], dependencies=[Depends(JWTBearer())])

# Get all profiles
@profile_router.get('/profile')
async def get_profiles():
    with engine.connect() as connection:
        try:
            result = connection.execute(tbl_profile.select()).fetchall()
            return {"error": False, 'msg':result}
        except IntegrityError as exc:
            return await handle_exception(exc)
