//
//  ContentView.swift
//  Books
//
//  Created by Isabella Sulisufi on 16/08/2024.
//

import SwiftUI

struct Book {
    var id: Int
    var title: String
    
    var authors: [String] //array of dictionaries
    var authorsName: String
    
    var subjects: [String]
    var downloadCount: Int
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "book")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Books!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}



