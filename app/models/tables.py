from ..config.db import engine, meta

meta_object = meta

meta_object.reflect(bind=engine)

tbl_users = meta.tables['tbl_users']
tbl_profile = meta.tables['tbl_profile']
tbl_module = meta.tables['tbl_module']
tbl_status = meta.tables['tbl_status']
tbl_severity = meta.tables['tbl_severity']
tbl_profile_module = meta.tables['tbl_profile_module']
tbl_user_profile = meta.tables['tbl_user_profile']
tbl_platform = meta.tables['tbl_platform']
tbl_gender = meta.tables['tbl_gender']
tbl_category = meta.tables['tbl_category']
tbl_system = meta.tables['tbl_system']
tbl_tickets = meta.tables['tbl_tickets']
tbl_register = meta.tables['tbl_register']
tbl_scan = meta.tables['tbl_scan']



if len(meta.sorted_tables) > 0:
    print('Connection to database active.')