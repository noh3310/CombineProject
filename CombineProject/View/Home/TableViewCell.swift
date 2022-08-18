//
//  TableViewCell.swift
//  CombineProject
//
//  Created by 노건호 on 2022/08/18.
//

import SwiftUI

struct TableViewCell: View {
    let title: String
    let bodyText: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.largeTitle)
                    .lineLimit(1)
                Spacer()
            }
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 1, trailing: 8))
            HStack {
                Text(bodyText)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 8, trailing: 8))
                Spacer()
            }
        }
    }
}

struct TableViewCell_Previews: PreviewProvider {
    static var previews: some View {
        TableViewCell(title: "title", bodyText: "bodyText")
    }
}
