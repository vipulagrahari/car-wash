import sqlite3

class Database(object):
	def __enter__(self):
		self.conn = sqlite3.connect("database.db")
		return self
	def __exit__(self, exc_type, exc_val, exc_tb):
		self.conn.close()

	def __call__(self, query):
		c = self.conn.cursor()
		try:
			result = c.execute(query)
			self.conn.commit()
		except Exception as e:
			result = e
		return result  