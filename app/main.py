import secrets

from fastapi import Depends, FastAPI, HTTPException, status
from fastapi.openapi.docs import get_redoc_html, get_swagger_ui_html
from fastapi.openapi.utils import get_openapi
from fastapi.security import HTTPBasic, HTTPBasicCredentials
from starlette.middleware.cors import CORSMiddleware
from decouple import config

from app.config.db import engine
from app.routes.gender_route import gender_router
from app.routes.severity_route import severity_router
from app.routes.login_route import login_router
from app.routes.user_route import user_router
from app.routes.status_route import status_router
from app.routes.system_route import system_router
from app.routes.profile_route import profile_router
from app.routes.category_route import category_router
from app.routes.menu_route import menu_router
# from app.routes.report_route import report_router
from app.routes.ticket_route import ticket_router





app = FastAPI(docs_url=None, redoc_url=None, openapi_url = None)

app.add_middleware(CORSMiddleware,
                   allow_origins=['*'], allow_credentials=True,
                   allow_methods=['*'], allow_headers=['*']
                   )
app.include_router(ticket_router)
app.include_router(category_router)
app.include_router(status_router)
app.include_router(system_router)
app.include_router(profile_router)
app.include_router(gender_router)
app.include_router(login_router)
app.include_router(menu_router)
# app.include_router(report_router)
app.include_router(user_router)
app.include_router(severity_router)


security = HTTPBasic()


def get_current_username(credentials: HTTPBasicCredentials = Depends(security)):
    correct_username = secrets.compare_digest(credentials.username, config("user"))
    correct_password = secrets.compare_digest(credentials.password, config("password"))
    if not (correct_username and correct_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect email or password",
            headers={"WWW-Authenticate": "Basic"},
        )
    return credentials.username


@app.get("/docs", include_in_schema=False)
async def get_swagger_documentation(username: str = Depends(get_current_username)):
    return get_swagger_ui_html(openapi_url="/openapi.json", title="docs")


@app.get("/redoc", include_in_schema=False)
async def get_redoc_documentation(username: str = Depends(get_current_username)):
    return get_redoc_html(openapi_url="/openapi.json", title="docs")


@app.get("/openapi.json", include_in_schema=False)
async def openapi(username: str = Depends(get_current_username)):
    return get_openapi(title=app.title, version=app.version, routes=app.routes)
