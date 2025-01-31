//
//  TemplateViews.swift
//  Books
//
//  Created by Isabella Sulisufi on 31/01/2025.
//

import SwiftUI

struct LogoSection: View {
    var body: some View {
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
        .padding(.leading, 14.0)
    }
}

struct LibraryButton: View {
    let action: () -> Void
    let title: String

    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack(alignment: .center, spacing: 0) {
                Text(title)
                    .font(Font.custom("Iowan Old Style", size: 20))
                    .foregroundColor(Color("background"))
            }
            .padding(.vertical, 12.0)
            .padding(.horizontal, 45.0)
            .background(Color("caramel"))
            .cornerRadius(9)
        })
    }
}

struct BookCategoryView: View {
    let categoryTitle: String
    let books: [String]

    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryTitle)
                .font(Font.custom("Cochin", size: 24))
                .foregroundColor(Color("darkestBrown"))
                .multilineTextAlignment(.leading)

            ScrollView(.horizontal) {
                HStack {
                    if books.isEmpty {
                        Text("Loading...")
                            .font(Font.custom("Cochin", size: 20))
                            .foregroundColor(Color("darkestBrown"))
                            .multilineTextAlignment(.center)
                    } else {
                        ForEach(books.prefix(5), id: \.self) { title in
                            VStack {
                                Rectangle()
                                    .frame(width: 96.0, height: 114.0)
                                    .foregroundColor(Color("caramel"))

                                Text(title)
                                    .font(Font.custom("Cochin", size: 20))
                                    .foregroundColor(Color("darkestBrown"))
                                    .multilineTextAlignment(.center)
                                    .frame(width: 96.0, height: 70.0)
                                    .lineLimit(nil)
                                    .padding(.top, 8.0)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding(.trailing, 10.0)
                        }
                    }
                    Spacer()
                }
            }
        }
        .padding(.bottom, 50.0)
    }
}
