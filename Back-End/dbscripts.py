import sqlite3
import datetime


now = datetime.datetime.now()
now = now.date()

conn = sqlite3.connect("database.db")
c = conn.cursor()
SQL_STATEMENT = """
DELETE FROM Services WHERE id = 4

"""
c.execute(SQL_STATEMENT)
# c.execute(
#     """INSERT INTO  Users(username, password, is_admin) VALUES("admin", "pbkdf2:sha256:260000$obEFfW0FEPqUWP6y$32fa03aa0dc7f374ea70670368da81c11e827d8b2c814e2c83cd96f069e1ec89", true);""")

c.execute("SELECT * FROM Services")
result = c.fetchall()
for i in result:
	print(i)

# Remember to save + close
conn.commit()
conn.close()