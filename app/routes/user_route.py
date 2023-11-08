from fastapi import APIRouter, Depends
from sqlalchemy.exc import IntegrityError
from app.config.db import engine
from app.helpers.exception import handle_exception
from app.helpers.utils import id_generator
from app.models.tables import tbl_users
from app.schemas.User import User
from auth.jwt_bearer import JWTBearer
from werkzeug.security import generate_password_hash
from sqlalchemy import text

user_router = APIRouter(tags=['user'])

# Get all users
@user_router.get('/user/get_all_users', dependencies=[Depends(JWTBearer())])
async def get_all_users():
    with engine.connect() as connection:
        try:
            result = connection.execute(tbl_users.select()).fetchall()
            return {"error": False, "msg": result}
        except IntegrityError as exc:
            return await handle_exception(exc)
# Get devs
@user_router.get('/user/get_devs', dependencies=[Depends(JWTBearer())])
async def get_dev_users():
    with engine.connect() as connection:
        try:
            query = text(
                """SELECT T1.* FROM tbl_users T1 JOIN tbl_user_profile T2 ON T1.id = T2.id_user WHERE T2.id_profile = 2"""
            )
            result = connection.execute(query).fetchall()
            return {"error": False, "msg": result}
        except IntegrityError as exc:
            return await handle_exception(exc)
# Add new user
@user_router.post('/user')
async def create_user(user: User):
    with engine.connect() as connection:
        try:
            new_password = generate_password_hash(user.password, "pbkdf2", 30)
            query = text('CALL add_user(:id, :name, :first_name, :last_name, :email, :password, :phone, :picture, :id_profile, :id_gender)')
            new_user = user.dict()
            new_user["id"] = id_generator()
            new_user["password"] = new_password
            result = connection.execute(query, new_user).first()
            if result.errno == 1062:
                return {"error":True,"msg": "Éste email ya está registrado."}
            return {"error":False,"msg":result.msg}
        except IntegrityError as exc:
            return await handle_exception(exc)