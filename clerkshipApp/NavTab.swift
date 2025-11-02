////
////  NavTab.swift
////  clerkshipApp
////
////  Created by Hannah Deyst on 11/2/25.
////
//import SwiftUI
//
//struct NavTab2: View {
//    @State private var selection = 1
//    private let backgroundColor = Color("BackgroundColor")
//    private let buttonColor = Color("ButtonColor")
//
//    var body: some View {
//            TabView(selection: $selection) {
//                HomeView()
//                    .tabItem() {
//                        Image(systemName: "house")
//                    }.tag(1)
//                ResourcesView()
//                    .tabItem() {
//                        Image(systemName:)
//                    }
//                StudentProfile()
//                    .tabItem() {
//                        Image(systemName: "person.crop.circle.fill")
//                    }.tag(3)
//            }
//    }
//}
//
//struct NavTab: View {
//    @SceneStorage("NavTab.currentTab") private var currentTab = 0
//      
//      var body: some View {
//        TabView(selection: $currentTab) {
//          HomeView()
//            .tabItem() {
//                Image(systemName: "house")
//                Text("Home")
//            }.tag(0)
//          StudentProfile()
//            .tabItem() {
//              Image(systemName: "person.crop.circle.fill")
//            }.tag(2)
//        }.frame(alignment: .bottomLeading)
//      }
//}
//
//
//struct circleNavButtonView: View {
//    private let backgroundColor = Color("BackgroundColor")
//    private let buttonColor = Color("ButtonColor")
//    
//    let text: String
//    var action: () -> Void = {}
//    
//    var body: some View {
//        VStack {
//            Button(action: action) {
//                Circle()
//                    .fill(buttonColor) // Olive green
//                    .frame(width: 50, height: 50)
//                Text(text)
//                    .foregroundColor(.black)
//                    .padding(.top, 4)
//            }
//        }
//    }
//}
//
//#Preview {
//    NavTab()
//}
