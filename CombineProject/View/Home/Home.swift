//
//  ContentView.swift
//  CombineProject
//
//  Created by 노건호 on 2022/08/18.
//

import SwiftUI

struct Home: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        if #available(iOS 15.0, *) {
            NavigationView {
                HomeView(viewModel: viewModel)
                    .navigationTitle("Search")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .searchable(text: $viewModel.searchText)
        } else {
            NavigationView {
                HomeView(viewModel: viewModel)
                    .navigationTitle("Search")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct HomeView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            if #unavailable(iOS 15.0) {
                SearchBar(text: $viewModel.searchText)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
            List(viewModel.repos, id: \.url) { repo in
                TableViewCell(title: repo.fullName, bodyText: repo.url)
            }.listStyle(.plain)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
