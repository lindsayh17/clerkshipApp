import json
import sys
from Form import Form
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


# upload the actual vehicle data to the database
def upload_data():
    firestore_db = open_firestore_db()
    json_file = "dummy_quiz.json"
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
            # create a Vehicle object from one listing
            f_object = Form.from_dict(form_data[f_data])

            # get the vin to use as unique ID and create document
            form_id = f_object.form_id
            # return the Vehicle object back to a dictionary with chosen attributes
            f_dict = f_object.to_dict()

            # Add a new doc in collection 'Vehicles' with vinID
            firestore_db.collection("Forms").document(form_id).set(f_dict)
        print ("----------------\n"
            "----------------\n"
            "---SUCCESSFUL---\n"
            "-----UPLOAD-----\n"
            "----------------\n"
            "----------------\n")
    except FileNotFoundError:
        print(f"Error:File '{json_file} not found.")


if __name__ == "__main__":
    upload_data()
