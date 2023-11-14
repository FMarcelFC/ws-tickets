from sqlalchemy import create_engine, MetaData

#engine = create_engine("mysql+pymysql://root:secret@mysql:3306/tracker_db")
engine = create_engine("mysql+pymysql://root:secret@localhost:8090/tracker_db")

meta = MetaData()
