//
//  SearchPageView.swift
//  Books
//
//  Created by Isabella Sulisufi on 20/09/2024.
//

import SwiftUI

struct SearchPageView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        ScrollView {
            VStack {

                // Logo Icon Section
                HStack {
                    Image(systemName: "book")
                        .resizable()
                        .frame(width: 24, height: 20)
                        .foregroundColor(Color("brownbrown"))

                    Text("Booktrail")
                        .font(Font.custom("Inknut Antiqua", size: 15))
                        .foregroundColor(Color("darkestBrown"))
                    Spacer()
                }
                .padding(.leading, 18.0)

                // Searched box
                TextField("Search...", text: $viewModel.emptySearch)
                    .padding(12.0)
                    .frame(width: 360.0, height: 40.0)
                    .font(Font.custom("Cochin", size: 24))
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("caramel")/*@END_MENU_TOKEN@*/)

                Text(viewModel.bookEntered)

                // Sort and Filter Section
                HStack {
                    HStack {
                        Image(systemName: "arrow.up.arrow.down")
                            .foregroundColor(Color("darkestBrown"))

                        Text("Sort")
                            .font(Font.custom("Cochin", size: 24))
                            .foregroundColor(Color("darkestBrown"))
                    }
                    Spacer()

                    HStack {
                        Image(systemName: "square.and.arrow.down.fill")
                            .foregroundColor(Color("darkestBrown"))

                        Text("Filter")
                            .font(Font.custom("Cochin", size: 24))
                            .foregroundColor(Color("darkestBrown"))
                    }
                }
                .padding(.horizontal, 20.0)

                // Book Information
                HStack {
                    Rectangle()
                        .frame(width: 130.0, height: 155.0)
                        .foregroundColor(Color("caramel"))

                    VStack(alignment: .leading) {
                        Text("Title")
                            .font(Font.custom("Cochin", size: 25))
                            .foregroundColor(Color("brownbrown"))

                        Text("Authors Name")
                            .font(Font.custom("Cochin", size: 18))
                            .foregroundColor(Color("brownbrown"))

                        Text("Birth - Death")
                            .font(Font.custom("Cochin", size: 12))
                            .foregroundColor(Color("brownbrown"))
                            .padding(.bottom, 4.0)

                        Text("Subjects")
                            .font(Font.custom("Cochin", size: 18))
                            .foregroundColor(Color("brownbrown"))

                        Text("\u{2022} subjectone")
                            .font(Font.custom("Cochin", size: 16))
                            .foregroundColor(Color("brownbrown"))

                        Text("\u{2022} subjecttwo")
                            .font(Font.custom("Cochin", size: 16))
                            .foregroundColor(Color("brownbrown"))
                    }
                    .padding(.leading, 20.0)

                    Spacer()
                }
                .padding(25.0)

                // Other books by authors name
                VStack(alignment: .leading) {
                    // Text("Other books by \(viewModel.$authorsName)")
                    Text("Other books by authors name")
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

                                    Text("title")
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
                .padding(.leading, 20)
                .padding(.bottom, 30)

                // Other books in that genre
                VStack(alignment: .leading) {

                    // Text("Other books in \(viewModel.$genre)")
                    Text("Other books in that genre")
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

                                    Text("title")
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
                .padding(.leading, 20)
            }
        }
        //        .navigationBarBackButtonHidden()
        .background(Color("background"))

    }

}

// #Preview {
//    SearchPageView()
//        .environmentObject(Router())
//
// }
