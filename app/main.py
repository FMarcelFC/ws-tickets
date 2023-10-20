import secrets

from fastapi import Depends, FastAPI, HTTPException, status
from fastapi.openapi.docs import get_redoc_html, get_swagger_ui_html
from fastapi.openapi.utils import get_openapi
from fastapi.security import HTTPBasic, HTTPBasicCredentials
from starlette.middleware.cors import CORSMiddleware
from decouple import config

from app.config.db import engine
# from app.routes.file_route import file_router
# from app.routes.warranty_route import warranty_router
from app.routes.login_route import login_router
from app.routes.user_route import user_router
# from app.routes.client_route import client_router
# from app.routes.express_route import express_router
# from app.routes.external_route import external_router
# from app.routes.chart_route import chart_router
# from app.routes.service_route import service_router
# from app.routes.report_route import report_router
from app.routes.ticket_route import ticket_router





app = FastAPI(docs_url=None, redoc_url=None, openapi_url = None)

app.add_middleware(CORSMiddleware,
                   allow_origins=['*'], allow_credentials=True,
                   allow_methods=['*'], allow_headers=['*']
                   )
app.include_router(ticket_router)
# app.include_router(chart_router)
# app.include_router(client_router)
# app.include_router(express_router)
# app.include_router(external_router)
# app.include_router(file_router)
app.include_router(login_router)
# app.include_router(report_router)
# app.include_router(service_router)
app.include_router(user_router)
# app.include_router(warranty_router)


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
