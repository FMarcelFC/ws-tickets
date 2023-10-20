from fastapi import APIRouter
from fastapi.encoders import jsonable_encoder
from sqlalchemy.exc import IntegrityError
from sqlalchemy import text, and_
from app.config.db import engine
from app.helpers.exception import handle_exception
from app.schemas.Login import Login
from werkzeug.security import check_password_hash
from app.models.tables import tbl_users
from auth.jwt_handler import signJWT
login_router = APIRouter(tags=['login'])

@login_router.post("/login")
async def login(user: Login):
    with engine.connect() as connection:
        try:
            result = connection.execute(tbl_users.select().where(and_(tbl_users.c.email == user.email, tbl_users.c.status==1))).first()
            if result != None:
                if check_password_hash(password=user.password, pwhash=result.password):
                    data = {
                        "id" : result.id,
                        "name" : result.name,
                        "first_name" : result.first_name,
                        "last_name" : result.last_name,
                        "email" : result.email,
                        "menu" : await get_menu(result.id)
                        }
                    token = signJWT(data)
                    data['token'] = token
                    return { "error": False, "msg": data}
                return {"error": True, "msg": "Contraseña incorrecta"}
            return {"error": True, "msg": "El usuario incorrecto o fue eliminado"}
        except IntegrityError as exc:
            return await handle_exception(exc)

async def get_menu(id: str):
 with engine.connect() as connection:
        try:
            sql = text('''SELECT P.profile AS profile, M.id AS id_module, M.* FROM tbl_module AS M 
                    JOIN tbl_profile_module AS PM ON M.id=PM.id_module 
                    JOIN tbl_profile AS P ON PM.id_profile=P.id 
                    JOIN tbl_user_profile AS UP ON PM.id_profile = UP.id_profile 
                    WHERE UP.id_user = :id_param AND M.status = 1 
                    ORDER BY M.order ASC''')
            result = connection.execute(sql, {"id_param":id}).fetchall()
            return jsonable_encoder(result)
        except IntegrityError as exc:
            return await handle_exception(exc)

    

