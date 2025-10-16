class Form:
    # constructor for document type quiz
    def __init__(self, name, form_id, num_questions, student_id, preceptor_id, questions):
        self.name = name
        self.form_id = form_id
        self.num_questions = num_questions
        self.studentId = student_id
        self.preceptorId = preceptor_id
        self.questions = questions


    @staticmethod
    # Reads in ONE dictionary from JSON file returns a completed form object
    def from_dict(source):
        return Form(
            name=source.get('name'),
            form_id=source.get('form_id'),
            num_questions=source.get('num_questions'),
            student_id=source.get('student_id'),
            preceptor_id=source.get('preceptor_id'),
            questions=source.get('questions')
        )

    # Takes a form object returns dicitonary with ONLY choosen attributes
    # No vin printed as it is the unique ID (document) not an attribute
    # Needs to be in dictionary form to read into firestore
    def to_dict(self):
        return {
            'name': self.name,
            # 'form_id': self.form_id,
            'num_questions': self.num_questions,
            'student_id': self.studentId,
            'preceptor_id': self.preceptorId,
            'questions': self.questions
        }
