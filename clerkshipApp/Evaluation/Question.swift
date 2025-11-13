//  QuestionEntry.swift
//  clerkshipApp

import SwiftUI

enum FormChoice: String, Codable {
    case obstetrics
    case clinic
    case inpatient
}

struct EvalForm: Identifiable, Codable {
    
    var id = UUID()
    var type: String
    var categories: [QuestionCategory]
    var formChoice: FormChoice
    
    init(categories: [QuestionCategory], type: String, formChoice: FormChoice) {
        self.categories = categories
        self.type = type
        self.formChoice = formChoice
    }
}

// This is going to hold a bunch of questions
struct QuestionCategory: Identifiable, Codable {
    // Properties
    var id = UUID()
    var category: String // Physical exam, collecting info, etc
    var questions: [Question] // sub aspects of the overall category
    
    init(category: String, questions: [Question]) {
        self.category = category
        self.questions = questions
    }
}


struct Question: Identifiable, Codable {
    
    // Question Types
    enum QuestionType: Codable {
        case radio
        case open
        case slider
    }
    
    // Response Types
    enum ResponseType: Codable {
        case text(String)
        case number(Int)
    }
    
    // Properties
    var id = UUID()
    var question: String = ""
    var type: QuestionType
    var required: Bool = true
    var response: ResponseType?
    
    // Initializer
    init(question: String, type: QuestionType, required: Bool) {
        self.question = question
        self.type = type
        self.required = required
        self.response = nil
    }
    
    // Initializer w/o questionType or required
    init(question: String) {
        self.question = question
        self.type = .radio
        self.required = true
        self.response = nil
    }
    
    // Text type
    var responseString: String? {
        // Returns the text value if response is a text type
        if case let .text(value)? = response {
            return value
        }
        return nil
    }
}


struct FormChoiceView: View {
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var formStore: FormStore
    
    @State private var selectedForm: EvalForm? = nil
    @State private var choiceMade = false
    
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")

    
    // download forms from firebase
    func downloadForms() {
        Task {
            do {
                try await firebase.fetchForms()
                if firebase.formDownloadSuccessful{
                    for form in firebase.forms{
                        formStore.addForm(form)
                    }
                }
            } catch {
                print("Error fetching forms: \(error)")
            }
        }
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor.ignoresSafeArea()
                VStack {
                    ScrollView {
                        // Screen Label
                        Text("Evaluation Type")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 30)
                            .padding(.bottom, 30)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                        
                        ForEach (firebase.forms) { form in
                            MainButtonView(title: form.type, color: buttonColor, action: {
                                selectedForm = form
                                choiceMade = true
                            })
                        }
                    }
                }
            }
        }.task {
            do {
                try await firebase.fetchForms()
            } catch {
                print("Error fetching form data \(error)")
            }
        }.navigationDestination(isPresented: $choiceMade) {
            CompleteEvalView(currForm: selectedForm)
        }
    }
}

struct CompleteEvalView: View {
    let currForm: EvalForm?
    
    var body: some View {
        
    }
}


#Preview {
    FormChoiceView()
        .environmentObject(FirebaseService())
        .environmentObject(FormStore())
}

