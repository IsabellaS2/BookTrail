//
//  ContentView.swift
//  Books
//
//  Created by Isabella Sulisufi on 16/08/2024.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("logoname")
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Text("Find your favourite books here")
                .font(.system(size: 45))
                .multilineTextAlignment(.center)

            Rectangle()
                .padding(.bottom, 15.0)
                .frame(width: 300.0, height: 40.0)
            
            Button("Go") {
                viewModel.searchButtonFunctionality()
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Most Downloaded")
                    .font(.system(size: 28))

                Text("Romeo and Juliet")
                    .font(.system(size: 18))
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
