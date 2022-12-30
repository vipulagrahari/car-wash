from database_helper import Database
from werkzeug.security import generate_password_hash, check_password_hash


def home():
    with Database() as db:

        json_dict = {"user_id":"admin", "password":"abcd"}


        user = json_dict["user_id"]
        pssw = json_dict["password"]

        # vulnerable to SQL injection. Fix later.


        result = db(f' SELECT password FROM Users WHERE username = "{user}" ')
        # result = db("SELECT * FROM Users")
        users = result.fetchall()

    if len(users) == 0:
        return "No users Found"
    
    else:
        return check_password_hash(users[0][0], pssw);

home()