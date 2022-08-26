//
//  APIManager.swift
//  CombineProject
//
//  Created by 노건호 on 2022/08/19.
//

import Foundation
import Alamofire
import Combine

class APIManager {
    
    private func parameters(_ p: String, _ page: Int) -> [String: String] {
        return [
            "q": p,
            "per_page": "30",
            "page": String(page)
        ]
    }
    
    private var headers: HTTPHeaders {
        [
            "Accept": "application/vnd.github+json",
            "Authorization": "token \(APIToken.token)"
        ]
    }
    
    func searchRepositorys(p: String, page: Int, completion: @escaping (Repositorys) -> Void) {
        let parameters = parameters(p, page)

        AF.request(RequestUrl.repository.getUrl(), method: .get, parameters: parameters, headers: headers).responseData { (response) in
            switch response.result {
            case .success:
                do {
                    if let data = response.data {
                        let repoData = try JSONDecoder().decode(Repositorys.self, from: data)
                        
                        print(repoData)
                        completion(repoData)
                    } else {
                        print("no data")
                    }
                } catch {
                    print("catch error")
                }
            case .failure:
                print("failure")
            }
        }
    }
    
    func searchRepositorysCombine(p: String, page: Int) -> AnyPublisher<Repositorys, AFError> {
        let parameters = parameters(p, page)
        
        return AF.request(RequestUrl.repository.getUrl(), method: .get, parameters: parameters, headers: headers)
            .publishDecodable(type: Repositorys.self)
            .value()
            .eraseToAnyPublisher()
    }
}
