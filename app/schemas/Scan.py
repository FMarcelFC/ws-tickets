from pydantic import BaseModel
from typing import Optional

class Scan(BaseModel):
    id: Optional[int] = None
    info: str
    type: int
