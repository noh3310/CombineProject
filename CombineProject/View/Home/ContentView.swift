//
//  ContentView.swift
//  CombineProject
//
//  Created by 노건호 on 2022/08/18.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            Text("Hello, world!")
                .navigationTitle("Search")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
