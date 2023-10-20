from fastapi import APIRouter, Depends, status
from fastapi.responses import JSONResponse
from sqlalchemy.exc import IntegrityError

async def handle_exception(exc: IntegrityError):
    result = {"error": True, "msg": exc.orig.args[1]}
    return result