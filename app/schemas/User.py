from pydantic import BaseModel
from datetime import datetime
from typing import Optional

class User(BaseModel):
    id: Optional[str] = None
    name: str
    first_name: str
    last_name: str
    status: Optional[int] = 1
    email: str
    password: str
    phone: str
    picture: str
    id_gender: int 
    id_profile: Optional[int] = 3
    register_date: Optional[datetime] = datetime.now()