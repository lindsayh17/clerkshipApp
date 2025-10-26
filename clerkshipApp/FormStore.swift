////
////  FormStore.swift
////  clerkshipApp
////
////  Created by Lindsay on 10/25/25.
////
//
//
//import Foundation
//
//// I don't know what this is, it was in Jason's code, might not need
//class RedrawFlag: ObservableObject {
//  @Published var counter = 0
//  func increment() {
//    counter = counter + 1
//  }
//}
//
//func load<T: Decodable>(_ url: URL) -> T {
//  let data: Data
//
//  do {
//    data = try Data(contentsOf: url)
//  } catch {
//    fatalError("Couldn't load \(url.path) from main bundle:\n\(error)")
//  }
//
//  do {
//    let decoder = JSONDecoder()
//    return try decoder.decode(T.self, from: data)
//  } catch {
//    print("parse \(url.path)")
//    fatalError("Couldn't parse \(url.path) as \(T.self):\n\(error)")
//  }
//}
//
//class FormStore: ObservableObject {
//  @Published var allForms: [Form]
//  let loadFromFile = true
//  let bundleFilename = "form-init.json"
//  
//  let formArchiveURL: URL = {
//    let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//    let documentDirectory = documentsDirectories.first!
//    let s = documentDirectory.appendingPathComponent("forms.json")
//    print("saving to \(s)")
//    return s
//  } ()
//  
//  init() {
//    if loadFromFile {
//      let fileManager = FileManager.default
//      if fileManager.fileExists(atPath: formArchiveURL.path) {
//        print("load from \(formArchiveURL.path)")
//        self.allForms = load(formArchiveURL)
//      } else {
//        if let url = Bundle.main.url(forResource: bundleFilename, withExtension: nil) {
//          print("load from \(url.path)")
//          self.allForms = load(url)
//        } else {
//          fatalError("can't find file to load")
//        }
//      }
//    } else {
//      allForms = []
////            allQuizzes.append(Quiz(quizNumber: 1))
////            allQuizzes.append(Quiz(quizNumber: 2))
////            allQuizzes.append(Quiz(quizNumber: 3))
////            allQuizzes.append(Quiz(quizNumber: 4))
//    }
//  }
//  
//  func delete(form: Form) {
//    if let idx = allForms.firstIndex(where: {$0.id == form.id}) {
//      allForms.remove(at: idx)
//    }
//  }
//  
//  func deleteAll() {
//    allForms.removeAll()
//  }
//  
//  func add(form: Form) {
//    allForms.append(form)
//  }
//  
//  func replace(id: UUID, with form: Form) {
//    if let idx = allForms.firstIndex(where: {$0.id == id}) {
//      allForms.remove(at: idx)
//      allForms.append(form)
//    }
//  }
//  
//  @discardableResult
//  func saveChanges() -> Bool {
//    do {
//      let encoder = JSONEncoder()
//      let data = try encoder.encode(allForms)
//      try data.write(to: formArchiveURL, options: [.atomic])
//      print("saved data to \(formArchiveURL)")
//      return true
//    } catch let encodingError {
//      print("Error encoding allItems: \(encodingError)")
//      return false
//    }
//  }
//  
//  func formInStore(id: UUID) -> Bool {
//    var matches = allForms.filter { $0.id == id }
//    if matches.count > 0 {
//      return true
//    } else {
//      return false
//    }
//  }
//} // class QuizStore
