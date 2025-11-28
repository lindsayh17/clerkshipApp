//
//  TextDataStore.swift
//  clerkshipApp
//
//  Convenience class for future developers to read from app resources
//
import SwiftUI

struct Info: Codable {
    let data: [ViewData]
}

struct ViewData : Codable {
    let view: String
    let description: String
}

class TextDataStore: ObservableObject {
    @Published var textInfo: [ViewData] = []
    
    func loadJson() {
        let decoder = JSONDecoder()
        
        guard
            let url = Bundle.main.url(forResource: "text", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let viewInfo = try? decoder.decode(Info.self, from: data)
        
        else {
           print("Could not find text.json")
           return
        }
        self.textInfo = viewInfo.data

    }
    
    func viewDescription(for viewName: String) -> ViewData? {
        return textInfo.first { $0.view == viewName }
    }
}
