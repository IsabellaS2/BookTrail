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
            Image(systemName: "book")
                .resizable()
                .frame(width: 67, height: 50)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color("brownbrown"))
            
            
            Text("Booktrail")
                .font(Font.custom("Inknut Antiqua", size: 32))
                .multilineTextAlignment(.leading)
                .foregroundColor(Color("darkestBrown"))
            
            
            Spacer()
            
            Text("Find your favourite books here")
                .font(Font.custom("Cochin", size: 40))
                .foregroundColor(Color("darkestBrown"))
                .multilineTextAlignment(.center)
            
            TextField("Search...", text: $viewModel.bookEntered)
                .foregroundColor(/*@START_MENU_TOKEN@*/Color("brownbrown")/*@END_MENU_TOKEN@*/)
                .background(Color("caramel"))

            
            
            Button {
                viewModel.searchButtonFunctionality()
                
            } label: {
                Text("Go")
            }
            //display sorted list of books to screen
            
            Spacer()
            
            Text("Most Downloaded")
                .font(Font.custom("Cochin", size: 24))
                .foregroundColor(Color("darkestBrown"))

            
            Text(viewModel.message)
            
            HStack() {
                
                
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
        .background(Color("background"))
        .onAppear {
            viewModel.present()
        }
    }
}

#Preview {
    ContentView()
}
