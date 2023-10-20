from fastapi import APIRouter, Depends
from sqlalchemy.exc import IntegrityError
from app.config.db import engine
from app.helpers.exception import handle_exception
from auth.jwt_bearer import JWTBearer
from app.models.tables import tbl_category

category_router = APIRouter(tags=['category'], dependencies=[Depends(JWTBearer())])

# Get all categories
@category_router.get('/get_categories')
async def get_categories():
    with engine.connect() as connection:
        try:
            result = connection.execute(tbl_category.select()).fetchall()
            return {"error": False, 'msg':result}
        except IntegrityError as exc:
            return await handle_exception(exc)
