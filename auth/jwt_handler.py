import time
from typing import Dict

import jwt
from decouple import config


JWT_SECRET = config("secret")
JWT_ALGORITHM = config("algorithm")


def token_response(token: str):
    return token
    
def signJWT(payload: str) -> Dict[str, str]:
    token = jwt.encode(payload, JWT_SECRET, algorithm=JWT_ALGORITHM)

    return token_response(token)

def decodeJWT(token: str) -> dict:
    try:
        decoded_token = jwt.decode(token, JWT_SECRET, algorithms=[JWT_ALGORITHM], verify_expired=False)
        return decoded_token
    except:
        return {}