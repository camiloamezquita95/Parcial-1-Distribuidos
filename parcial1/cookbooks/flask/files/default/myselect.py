import psycopg2
from flask import Flask
app = Flask(__name__)

def connect():
  try:
    conn = psycopg2.connect("dbname='database1' user='admin' host='192.168.0.15'")
  except:
    print "I am unable to connect to the database"
  return conn

@app.route("/hi")
def hi():
  return "Hi!, I am a greedy algorithm"

@app.route("/select")
def select():
  conn = connect()
  cur = conn.cursor()
  cur.execute("""SELECT * from flask.example""")
  rows = cur.fetchall()
  print "\nShow me the table example:\n"
  print "id |   name   |  age"
  rowsstring = "\nShow me the table example: \n"
  rowsstring = rowsstring + "id |   name   |  age \n"
  for row in rows:
    print "",row[0],"  ",row[1],"  ",row[2]
    rowsstring = rowsstring + str(row[0]) + str(row[1]) +str(row[2]) +"\n"
  print rowsstring
  return rowsstring

if __name__ == "__main__":
  app.run('0.0.0.0')