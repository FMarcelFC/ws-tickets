from pydantic import BaseModel
from datetime import datetime

class Ticket(BaseModel):
    id: str
    id_status: int
    id_category: int
    id_serverity: int
    start_date: datetime
    end_date: datetime
    last_update: datetime
    id_dev: int
    id_user: int
    id_system: int
    created_at: datetime
    id_register: int