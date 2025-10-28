class User:
    # constructor for document type quiz
    def __init__(self, user_id, first_name, last_name, position):
        self.user_id = user_id
        self.first_name = first_name
        self.last_name = last_name
        self.position = position


    @staticmethod
    # Reads in ONE dictionary from JSON file returns a completed form object
    def from_dict(source):
        return User(
            user_id=source('user_id'),
            first_name=source('first_name'),
            last_name=source('last_name'),
            position=source('position'),
        )

    # Takes a user object returns dicitonary with ONLY chosen attributes
    # No vin printed as it is the unique ID (document) not an attribute
    # Needs to be in dictionary form to read into firestore
    def to_dict(self):
        return {
            'user_id': self.user_id,
            'first_name': self.first_name,
            'last_name': self.last_name,
            'position': self.position
        }
