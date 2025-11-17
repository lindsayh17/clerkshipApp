import SwiftUI

enum FormChoice: String, Codable {
    case obstetrics
    case clinic
    case inpatient
}

struct FormChoiceView: View {
    @EnvironmentObject var firebase: FirebaseService
    @EnvironmentObject var formStore: FormStore
    
    @State private var selectedForm: EvalForm? = nil
    @State private var choiceMade = false
    
    // Back button
    @State private var navigateHome: Bool = false
    
    private let backgroundColor = Color("BackgroundColor")
    private let buttonColor = Color("ButtonColor")
    
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
                    Text("Evaluation Type")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 30)
                        .padding(.bottom, 30)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                    
                    ForEach(firebase.forms) { form in
                        MainButtonView(title: form.type, color: buttonColor, action: {
                            selectedForm = form
                            choiceMade = true
                        })
                    }
                }
            }
            BackToHomeButton(navigateHome: $navigateHome)
                .padding(.top, 10)
                .padding(.leading, 10)
                .ignoresSafeArea(.all, edges: .top)
        }
        .task {
            do {
                try await firebase.fetchForms()
            } catch {
                print("Error fetching form data \(error)")
            }
        }
        .navigationDestination(isPresented: $choiceMade) {
            if let selected = selectedForm {
                FillOutFormView(currForm: selected)
            }
        }
        .navigationDestination(isPresented: $navigateHome) {
            HomeView()
                .transition(.move(edge: .leading))
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Preview
#Preview {
    NavigationStack {
        FormChoiceView()
    }
    .environmentObject(FirebaseService())
    .environmentObject(FormStore())
}

