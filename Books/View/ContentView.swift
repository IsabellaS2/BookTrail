//
//  ContentView.swift
//  Books
//
//  Created by Isabella Sulisufi on 16/08/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @EnvironmentObject var router: Router

    
    var body: some View {
        VStack {
            Image(systemName: "book")
                .resizable()
                .frame(width: 67, height: 50)
                .foregroundColor(Color("brownbrown"))
            
            Text("Booktrail")
                .font(Font.custom("Inknut Antiqua", size: 32))
                .foregroundColor(Color("darkestBrown"))
            
            Spacer()
            
            //Search Section
            Text("Find your favourite books here")
                .font(Font.custom("Cochin", size: 40))
                .foregroundColor(Color("darkestBrown"))
            
            
            TextField("Search...", text: $viewModel.bookEntered)
                .padding(10.0)
                .frame(height: 40.0)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("caramel")/*@END_MENU_TOKEN@*/)
                .onSubmit {
                }
            
            Button(action: {
                viewModel.getBooksOrderedByDownloads()
                router.navigate(to: .searchedPage("123"))

            }) {
                Text("Go")
                    .font(Font.custom("Cochin", size: 24))
                    .foregroundColor(Color("darkestBrown"))
            }
            
            
            
            
            Spacer()
            
            //Most downloaded
            VStack(alignment: .leading) {
                Text("Most Downloaded")
                    .font(Font.custom("Cochin", size: 24))
                    .foregroundColor(Color("darkestBrown"))
                    .multilineTextAlignment(.leading)
                
                ScrollView(.horizontal) {
                    
                    HStack {
                        ForEach(0..<3) { _ in
                            VStack {
                                Rectangle()
                                    .frame(width: 96.0, height: 114.0)
                                    .foregroundColor(Color("caramel"))
                                
                                Text(viewModel.mostDownloadedBookText)
                                    .font(Font.custom("Cochin", size: 20))
                                    .foregroundColor(Color("darkestBrown"))
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                            }
                            .padding(.trailing, 10.0)
                        }
                        Spacer()
                    }
                }
            }
            
            
            
            
            //            Text(viewModel.mostDownloadedBookText)
            //                .font(Font.custom("Cochin", size: 20))
            //                .foregroundColor(Color("darkestBrown"))
            //
            //            Text(viewModel.downloadTotalText)
            //                .font(Font.custom("Cochin", size: 20))
            //                .foregroundColor(Color("darkestBrown"))
            
            Spacer()
        }
        .padding()
        .background(Color("background"))
        .task {
            await viewModel.fetchBookRepo()
        }
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
        .environmentObject(Router())
}
