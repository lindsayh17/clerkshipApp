//
//  Router.swift
//  clerkshipApp
//
//  Created by Hannah Deyst on 11/22/25.
//

import SwiftUI

class Router: ObservableObject {
    @Published var root: Destination
    @Published var path: [Destination] = []
    @Published var sheet: Destination?
    @Published var fullScreenCover: Destination?
    
    init(root: Destination) {
        self.root = root
    }
    
    func switchRoot(_ root: Destination) {
        path.removeAll()
        self.root = root
    }
    
    func push(_ destination: Destination) {
        path.append(destination)
    }
    
    func pop() {
            path.removeLast()
    }
    
    func popTo(_ destination: Destination) {
        guard let index = path.lastIndex(where: { $0 == destination }) else { return }
        path.popItem(to: index)
    }
    
    func popToRoot() {
        path.removeAll()
    }
    
    func sheet(_ destination: Destination) {
        sheet = destination
    }

    func fullScreenCover(_ destination: Destination) {
        fullScreenCover = destination
    }

    func dismiss() {
        if sheet != nil {
            sheet = nil
        } else if fullScreenCover != nil {
            fullScreenCover = nil
        }
    }
    
}

extension Array {
    mutating func popItem(to index: Int) {
        guard index < self.count && index >= 0 else {
            return
        }
        self = Array(self[..<Swift.min(index + 1, self.count)])
    }
}
