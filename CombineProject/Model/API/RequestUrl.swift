//
//  RequestUrl.swift
//  CombineProject
//
//  Created by 노건호 on 2022/08/19.
//

import Foundation

enum RequestUrl: String {
    case repository = "search/repositories"
}

extension RequestUrl {
    var baseUrl: String {
        "https://api.github.com/"
    }
    
    func getUrl() -> URL {
        return URL(string: baseUrl + self.rawValue)!
    }
}
