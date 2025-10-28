import json
import sys
from Form import Form
from User import User
# admin program to upload the used car data to google firestore

# access firestore database using credentials
def open_firestore_db():
    import firebase_admin
    from firebase_admin import credentials
    from firebase_admin import firestore

    # Use the sdk credentials
    cred = credentials.Certificate('sdk_key_mobile_app.json') # grabs key from parent local folder

    # Initialize access to firestore database
    firebase_admin.initialize_app(cred)
    db = firestore.client()
    return db


# upload the actual form data to the database
def upload_data():
    firestore_db = open_firestore_db()
    json_file = "dummy_quiz.json"
    user_file = "dummy_user.json"
    try:
        with open(json_file, encoding = 'utf8') as f:
            form_data = json.load(f)
            print ("----------------\n"
            "----------------\n"
            "--LOAD SUCCESS--\n"
            "--BEGIN UPLOAD--\n"
            "----------------\n"
            "----------------\n")
        for f_data in range(len(form_data)):
            # create a form object from one listing
            f_object = Form.from_dict(form_data[f_data])

            # get the form id
            form_id = f_object.form_id
            # return the form object back to a dictionary with chosen attributes
            f_dict = f_object.to_dict()

            # Add a new doc in collection 'forms' with formid
            firestore_db.collection("Forms").document(form_id).set(f_dict)
        print ("----------------\n"
            "----------------\n"
            "---SUCCESSFUL---\n"
            "-----UPLOAD-----\n"
            "----------------\n"
            "----------------\n")
    except FileNotFoundError:
        print(f"Error:File '{json_file} not found.")

    try:
        with open(user_file, encoding='utf8') as uf:
            user_data = json.load(uf)
            print("----------------\n"
                  "----------------\n"
                  "--LOAD SUCCESS--\n"
                  "--BEGIN UPLOAD--\n"
                  "----------------\n"
                  "----------------\n")
        for uf_data in range(len(user_data)):
            # create a user object from one listing
            uf_object = User.from_dict(user_data[uf_data])

            # get the user id
            user_id = uf_object.user_id
            # return the form object back to a dictionary with chosen attributes
            uf_dict = uf_object.to_dict()

            # Add a new doc in collection 'forms' with formid
            firestore_db.collection("Forms").document(user_id).set(uf_dict)
        print("----------------\n"
              "----------------\n"
              "---SUCCESSFUL---\n"
              "-----UPLOAD-----\n"
              "----------------\n"
              "----------------\n")
    except FileNotFoundError:
        print(f"Error:File '{user_file} not found.")


if __name__ == "__main__":
    upload_data()
