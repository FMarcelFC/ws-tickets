from fastapi import APIRouter, Depends, status, Request, Response
from fastapi.responses import StreamingResponse
from sqlalchemy.exc import IntegrityError
from sqlalchemy import or_, text
from datetime import date

from app.config.db import engine
from app.helpers.exception import handle_exception
from app.helpers.utils import id_generator
from app.models.tables import tbl_tickets
from app.schemas.Ticket import Ticket
from auth.jwt_bearer import JWTBearer

ticket_router = APIRouter(tags=["ticket"], dependencies=[Depends(JWTBearer())])

# Get all tickets
@ticket_router.get("/ticket/get_tickets")
async def get_tickets():
    with engine.connect() as connection:
        try:
            query = text(
                """SELECT T1.*, 
                T2.status, 
                T3.severity, 
                CONCAT(T4.name, ' ', T4.first_name) dev, 
                CONCAT(T5.name, ' ', T5.first_name) user, 
                T6.name module, 
                T8.category FROM tbl_tickets T1 
                JOIN tbl_status T2 ON T1.id_status = T2.id 
                JOIN tbl_severity T3 ON T1.id_severity = T3.id 
                JOIN tbl_users T4 ON T1.id_dev = T4.id 
                JOIN tbl_users T5 ON T1.id_user = T5.id 
                JOIN tbl_system T6 ON T1.id_system = T6.id 
                JOIN tbl_category T8 ON T1.id_category = T8.id"""
            )
            result = connection.execute(query).fetchall()
            return {"error": False, "msg": result}
        except IntegrityError as exc:
            return await handle_exception(exc)

# Get your tickets
@ticket_router.get("/ticket/get_your_tickets")
async def get_your_tickets(id:str):
    with engine.connect() as connection:
        try:
            query = text(
                """SELECT T1.*, 
                T2.status, 
                T3.severity, 
                CONCAT(T4.name, ' ', T4.first_name) dev, 
                CONCAT(T5.name, ' ', T5.first_name) user, 
                T6.name module, 
                T8.category FROM tbl_tickets T1 
                JOIN tbl_status T2 ON T1.id_status = T2.id 
                JOIN tbl_severity T3 ON T1.id_severity = T3.id 
                JOIN tbl_users T4 ON T1.id_dev = T4.id 
                JOIN tbl_users T5 ON T1.id_user = T5.id 
                JOIN tbl_system T6 ON T1.id_system = T6.id 
                JOIN tbl_category T8 ON T1.id_category = T8.id
                WHERE T1.id_user = :id_param"""
            )
            result = connection.execute(query, {"id_param":id}).fetchall()
            return {"error": False, "msg": result}
        except IntegrityError as exc:
            return await handle_exception(exc)

# Get dev tickets
@ticket_router.get("/ticket/get_dev_tickets")
async def get_dev_tickets(id:str):
    with engine.connect() as connection:
        try:
            query = text(
                """SELECT T1.*, 
                T2.status, 
                T3.severity, 
                CONCAT(T4.name, ' ', T4.first_name) dev, 
                CONCAT(T5.name, ' ', T5.first_name) user, 
                T6.name module, 
                T8.category FROM tbl_tickets T1 
                JOIN tbl_status T2 ON T1.id_status = T2.id 
                JOIN tbl_severity T3 ON T1.id_severity = T3.id 
                JOIN tbl_users T4 ON T1.id_dev = T4.id 
                JOIN tbl_users T5 ON T1.id_user = T5.id 
                JOIN tbl_system T6 ON T1.id_system = T6.id 
                JOIN tbl_category T8 ON T1.id_category = T8.id
                WHERE T1.id_dev = :id_param"""
            )
            result = connection.execute(query, {"id_param":id}).fetchall()
            return {"error": False, "msg": result}
        except IntegrityError as exc:
            return await handle_exception(exc)
        

# Create ticket
@ticket_router.post("/ticket")
async def create_ticket(ticket: Ticket):
    with engine.connect() as connection:
        try:
            new_ticket = ticket.dict()
            new_ticket["id"] = id_generator()
            connection.execute(tbl_tickets.insert().values(new_ticket))
            return {
                "error": False,
                "msg": "Ticket creado con éxito",
                "code": status.HTTP_201_CREATED,
            }
        except Exception as exc:
            return await handle_exception(exc)

# Update ticket
@ticket_router.put("/ticket")
async def update_ticket(ticket: Ticket):
    with engine.connect() as connection:
        try:
            new_ticket = ticket.dict()
            connection.execute(
                tbl_tickets.update()
                .values(new_ticket)
                .where(tbl_tickets.c.id == ticket.id)
            )
            return {
                "error": False,
                "msg": "Ticket actualizado exitosamente",
                "code": status.HTTP_200_OK,
            }
        except Exception as exc:
            return await handle_exception(exc)