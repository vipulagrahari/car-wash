from flask import Flask, jsonify, request
from flask_cors import CORS, cross_origin
from threading import Thread
import sqlite3
import json
from database_helper import Database
from werkzeug.security import generate_password_hash, check_password_hash
import datetime
from flask import jsonify

app = Flask('')
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'


@app.route('/')
def home():
  with Database() as db:
    result = db("SELECT * FROM Users")
    result = result.fetchall()
  return result


@app.route('/user/login', methods=['POST'])
def user_login():
  if request.method in ['POST', 'OPTIONS']:
    with Database() as db:
      # json_dict = {"user_id":"admin", "password":"abcd"}
      json_dict = request.get_json()
      user = json_dict["user_id"]
      pssw = json_dict["password"]

      # vulnerable to SQL injection. Fix later.
      result = db(
        f' SELECT password, is_admin FROM Users WHERE username = "{user}" ')
      # result = db("SELECT * FROM Users")
      users = result.fetchall()

    if len(users) == 0:
      return jsonify({"message": "No users Found"})

    if users[0][1] == 1:
      return jsonify({"message": "Please Log in Through the Admin Portal"})

    if check_password_hash(users[0][0], pssw):
      return jsonify({"message": "Success"})
    return jsonify({"message": "Failure"})


@app.route('/user/signIn', methods=['POST'])
def signIn():
  if request.method == "POST":
    with Database() as db:
      json_dict = request.get_json()
      user = json_dict["user_id"]
      pssw = json_dict["password"]

      hashed_password = generate_password_hash(pssw)

      duplicates = db(f'SELECT username FROM Users WHERE username = "{user}" ')
      duplicates = duplicates.fetchall()
      if len(duplicates) == 0:
        result = db(
          f' INSERT INTO Users(username, password, is_admin) VALUES("{user}", "{hashed_password}", false)'
        )
        return jsonify({"message": "success"})

      return jsonify({"message": "Username Taken"})


@app.route('/user/search/<place>')
def search_based_on_place(place):
  with Database() as db:
    result = db(f'SELECT name FROM Locations WHERE name = "{place}"')
    result = result.fetchall()
    if len(result) == 0:
      return jsonify({"message": "Not Found"})
    return jsonify({"name": result[0][0]})


@app.route('/user/bookings', methods=["POST"])
def bookings():

  if request.method == "POST":
    with Database() as db:
      json_dict = request.get_json()
      username = json_dict["username"]

      user_id = db(f'SELECT id FROM Users WHERE username = "{username}"')
      user_id = user_id.fetchall()[0][0]

      bookings = db(f'SELECT * FROM Boookings WHERE user_id = "{user_id}" ')
      bookings = bookings.fetchall()

      if len(bookings) == 0:
        return jsonify({"message": "No Bookings yet"})

      return jsonify({"bookings": bookings})


@app.route('/user/bookService', methods=['GET', 'POST'])
def book():

  if request.method == 'POST':

    with Database() as db:
      json_dict = request.get_json()

      username = json_dict["username"]

      user_id = db(f'SELECT id FROM Users WHERE username = "{username}"')
      user_id = user_id.fetchall()[0][0]

      servicename = json_dict["servicename"]

      service_id = db(f'SELECT id FROM Services WHERE name = "{servicename}"')
      service_id = service_id.fetchall()[0][0]

      location = json_dict["location"]

      location_id = db(f'SELECT id FROM Locations WHERE name = "{location}"')
      location_id = location_id.fetchall()[0][0]

      now = datetime.datetime.now()
      now = now.date()

      count = db(
        f'SELECT COUNT(*) FROM Bookings WHERE user_id = {user_id} AND service_id = {service_id} AND location_id = {location_id} AND date = {now}'
      )
      count = count.fetchall()[0][0]

      if count >= 5:
        return "Cannot proceed, Daily Criteria Fulfilled."

      res = db(
        f'INSERT INTO Bookings(user_id, location_id, service_id, date, status) VALUES({user_id}, {location_id}, {service_id}, {now}, "pending")'
      )

      return "success"


@app.route('/admin/login', methods=['POST'])
def admin_login():
  if request.method == "POST":
    with Database() as db:
      # json_dict = {"user_id":"admin", "password":"abcd"}
      json_dict = request.get_json()
      user = json_dict["user_id"]
      pssw = json_dict["password"]

      # vulnerable to SQL injection. Fix later.
      result = db(
        f' SELECT password, is_admin FROM Users WHERE username = "{user}" ')
      # result = db("SELECT * FROM Users")
      users = result.fetchall()

    if len(users) == 0:
      return jsonify({"message": "No users Found"})

    if users[0][1] == 0:
      return jsonify({"message": "Please Log in Through the User Portal"})

    if check_password_hash(users[0][0], pssw) == True:
      return jsonify({"message": "success"})

    return jsonify({"message": "failure"})


@app.route('/admin/addLocation', methods=['POST'])
def add_locations():

  with Database() as db:
    json_dict = request.get_json()

    name = json_dict["location"]

    duplicates = db(f'SELECT count(name) FROM Locations WHERE name = "{name}"')
    duplicates = duplicates.fetchall()

    if duplicates[0][0] == 0:
      res = db(f'INSERT INTO Locations(name) VALUES("{name}")')
      return jsonify({"message": "success"})

    return "Location Already Exists"


@app.route('/admin/addServices', methods=['POST'])
def add_services():

  if request.method == 'POST':

    with Database() as db:

      json_dict = request.get_json()

      location = json_dict["location"]

      name = json_dict["service_name"]

      location_id = db(f'SELECT id FROM Locations WHERE name = "{location}"')
      location_id = location_id.fetchall()

      if len(location_id) == 0:
        return "This place does not exist, Please add it before adding a service to it."

      location_id = location_id[0][0]
      print(location_id)

      services = db(
        f'SELECT COUNT(*) FROM Services WHERE name = "{name}" AND location_id = {location_id}'
      )
      services = services.fetchall()

      if services[0][0] == 0:

        res = db(
          f'INSERT INTO Services(location_id, name) VALUES({location_id}, "{name}")'
        )
        return "success"

      return "This service already exists"


@app.route('/admin/updateBookings', methods=['POST'])
def update_bookings():

  if request.method == "POST":
    with Database() as db:
      json_dict = request.get_json()

      booking_id = json_dict["booking_id"]

      update_statement = json_dict["update_statement"]

      res = db(
        f'UPDATE Bookings SET status = "{update_statement}" WHERE id = {booking_id}'
      )

      return "success"


app.run(host='0.0.0.0', port=81)
