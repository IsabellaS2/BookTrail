//
//  SearchPageView.swift
//  Books
//
//  Created by Isabella Sulisufi on 20/09/2024.
//

import SwiftUI

struct SearchPageView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("I am the search page")
            
        }
        .background(Color("background"))
    }
}

#Preview {
    SearchPageView()
        .environmentObject(Router())
    
}
