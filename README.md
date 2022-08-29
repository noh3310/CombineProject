# CombineProject
SwiftUI + Combine을 사용해 Github Repository 검색 리포지토리 구현

## Feature
- 최소 버전: 14.0

## Issue
- Combine + Almofire
  - 기존 코드
    ```Swift
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
    ```
  - Combine 적용 코드(Alamofire 5부터 Combine 지원)
    ```Swift
    func searchRepositorysCombine(p: String, page: Int) -> AnyPublisher<Repositorys, AFError> {
        let parameters = parameters(p, page)

        return AF.request(RequestUrl.repository.getUrl(), method: .get, parameters: parameters, headers: headers)
            .publishDecodable(type: Repositorys.self)
            .value()
            .eraseToAnyPublisher()
    }
    ```
   - map, mapError 사용해서 return값 변경
      ```Swift
      // Error 타입 선언
      struct NetworkError: Error {
        let initialError: AFError
      }
      
     func searchRepositorysCombineRepo(p: String, page: Int) -> AnyPublisher<[Repo], NetworkError> {
        let parameters = parameters(p, page)

        return AF.request(RequestUrl.repository.getUrl(), method: .get, parameters: parameters, headers: headers)
            .publishDecodable(type: Repositorys.self)
            .value()
            .map({ $0.items })  // Output [Repo]로 변경
            .mapError({ error in  // Failure 타입 
                return NetworkError(initialError: error)
            })
            .eraseToAnyPublisher()
      }
      ```
