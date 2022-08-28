//
//  ViewModel.swift
//  CombineProject
//
//  Created by 노건호 on 2022/08/19.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    
    let apiManager = APIManager()
    
    @Published var searchText = ""
    @Published var repos: [Repo] = []
    @Published var page = 1
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        bind()
    }
}

// MARK: Process Page
extension ViewModel {
    func addPage() {
        page += 1
    }
}

// MARK: Binding
extension ViewModel {
    func bind() {
        $searchText
        // Debounce 사용해 입력값이 변경될 때마다 호출하는것 방지
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .filter({ !$0.isEmpty })
            .flatMap({ self.apiManager.searchRepositorysCombineRepo(p: $0, page: 1) })
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.failureReason ?? "unknown-error")
                    break
                }
            } receiveValue: { [weak self] repo in
                self?.repos = repo
            }
            .store(in: &cancellable)
        
        $page
            .filter({ $0 != 1 })
            .flatMap({ self.apiManager.searchRepositorysCombineRepo(p: self.searchText, page: $0) })
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.initialError.localizedDescription)
                    break
                }
            } receiveValue: { [weak self] repo in
                self?.repos = repo
            }
            .store(in: &cancellable)

    }
}
