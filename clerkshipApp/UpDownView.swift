//
//  ContentView.swift
//  UpDown
//
//  Created by user285542 on 10/5/25.
//

import SwiftUI

struct ContentView: View {
    @State private var chars = "ABCDEF"
    @State private var index = 0
    @State private var color: Color = .black
    
    func upButton(){
        if index + 1 < chars.count{
            index += 1
            color = .black
        }else{
            color = .red
        }
    }
    
    func downButton(){
        if index - 1 >= 0{
            index -= 1
            color = .black
        }else{
            color = .red
        }
    }

    var body: some View {
        VStack {
            Spacer()
            Text("UpDown")
            Spacer()
            HStack{
                Button(action:
                        upButton) {Text("\u{2191}")}
                Button(action: downButton) {Text("\u{2193}")}
            }
            Spacer()
            Text("\(chars[index])").font(.system(size: 96)).foregroundStyle(color)
            Spacer()
        }
        .padding()
        .environment(\.font, .largeTitle)
    }
        
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
    
#Preview{
    ContentView()
}
