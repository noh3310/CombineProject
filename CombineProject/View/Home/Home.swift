//
//  ContentView.swift
//  CombineProject
//
//  Created by 노건호 on 2022/08/18.
//

import SwiftUI

struct Home: View {
    
    @State var searchText = ""
    let apiManager = APIManager()
    
    var body: some View {
        if #available(iOS 15.0, *) {
            NavigationView {
                HomeView()
                    .navigationTitle("Search")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        Button("검색") {
                            apiManager.searchRepositorys(p: "hihi")
                        }
                    }
            }
            .searchable(text: $searchText)
        } else {
            NavigationView {
                HomeView()
                    .navigationTitle("Search")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct HomeView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            if #unavailable(iOS 15.0) {
                SearchBar(text: $searchText)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
            Spacer()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
