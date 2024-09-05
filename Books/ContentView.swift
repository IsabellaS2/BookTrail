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
            
            TextField("Enter a book", text: $viewModel.bookEntered)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            
            
            Button {
                viewModel.sortBooksAlphabetically()
                
            } label: {
                Text("Go")
            }

            Spacer()
            
            VStack(alignment: .leading) {
                Text("Most Downloaded")
                    .font(.system(size: 28))

                Text(viewModel.viewData?.mostDownloadedBook ?? "No Data")
                    .font(.system(size: 18))
                
                Text(viewModel.viewData?.downloadTotal ?? "No Data")
                    .font(.system(size: 18))
                
//                if viewModel.status == true {
//                    Text(viewModel.successMessage)
//                } else {
//                    Text(viewModel.failMessage)
//                }
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.present()
        }
    }
}

#Preview {
    ContentView()
}
