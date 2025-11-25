import SwiftUI

enum FormChoice: String, Codable {
    case obstetrics
    case clinic
    case inpatient
}

struct FormChoiceView: View {
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var formStore: FormStore
    @EnvironmentObject var currUser: CurrentUser
    @EnvironmentObject var router: Router
    
    @Environment(\.dismiss) var dismiss
    
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
    let currStudent: User
        
    // download forms from firebase
    func downloadForms() {
        Task {
            do {
                try await firebase.fetchForms()
                if firebase.formDownloadSuccessful {
                    for form in firebase.forms {
                        formStore.addForm(form)
                    }
                }
            } catch {
                print("Error fetching forms: \(error)")
            }
        }
    }
    
    var body: some View {
        ZStack (alignment: .topLeading){
            backgroundColor.ignoresSafeArea()
            VStack {
                ScrollView {
                    // Screen Label
                    Text("Evaluation\nType")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 30)
                        .padding(.bottom, 30)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                    
                    ForEach(firebase.forms) { form in
                        MainButtonView(title: form.type, color: buttonColor, action: {
                            router.push(.eval(formState: EvalFormState(data: form), student: currStudent))
                        }).padding(.horizontal)
                    }
                }
                // student uses nav tab for eval
                if currUser.user?.access == .student {
                    NavTab(currView: .evalChoice(userToEval: currStudent))
                }
            }
            // since the preceptor chooses a student to eval first, they need a back button
            if currUser.user?.access != .student || router.path != [] {
                BackButton()
                    .padding(.top, 10)
                    .padding(.leading, 10)
                    .ignoresSafeArea(.all, edges: .top)
            }
        }
        .task {
            do {
                try await firebase.fetchForms()
            } catch {
                print("Error fetching form data \(error)")
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Preview
#Preview {
    NavigationStack {
        FormChoiceView(currStudent: User(firstName: "Place", lastName: "Holder", email: "email"))
    }
    .environmentObject(FirebaseService())
    .environmentObject(FormStore())
}

