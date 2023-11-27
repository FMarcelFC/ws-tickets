from pydantic import BaseModel
from datetime import date, datetime
from typing import Optional

class Ticket(BaseModel):
    id: Optional[str]  = None
    id_status: int
    id_category: int
    id_severity: int
    issue: str
    start_date: Optional[date]  = None
    end_date: Optional[date]  = None
    last_update: Optional[datetime]  = None
    id_dev: str
    id_user: str
    id_system: int
    created_at: Optional[datetime]  = datetime.now()