import random
import string
from datetime import datetime

def id_generator():
    characters = string.digits + string.ascii_lowercase + string.ascii_uppercase
    random_string = ''.join(random.choice(characters) for _ in range(18))    
    current_time = datetime.now()
    formatted_time = current_time.strftime("%Y%m%d%H%M%S")
    return formatted_time + random_string
