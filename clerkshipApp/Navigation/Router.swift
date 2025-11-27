//  Router.swift
//  clerkshipApp

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
        print("path: \(path)")
    }
    
    func push(_ destination: Destination) {
        path.append(destination)
        print("path: \(path)")
    }
    
    
    func pop() {
        path.removeLast()
        print("path: \(path)")
    }
    
    func popTo(_ destination: Destination) {
        guard let index = path.lastIndex(where: { $0 == destination }) else { return }
        path.popItem(to: index)
        print("path: \(path)")
    }
    
    func popToRoot() {
        path.removeAll()
        print("path: \(path)")
    }
    
    func sheet(_ destination: Destination) {
        sheet = destination
        print("path: \(path)")
    }

    func fullScreenCover(_ destination: Destination) {
        fullScreenCover = destination
        print("path: \(path)")
    }
    
    // get the current view
    func currView() -> Destination {
        if let latest = path.last {
            return latest
        }
        return self.root
    }

    func dismiss() {
        if sheet != nil {
            sheet = nil
        } else if fullScreenCover != nil {
            fullScreenCover = nil
        }
        print("path: \(path)")
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
