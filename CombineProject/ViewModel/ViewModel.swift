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
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        bind()
    }
}

// MARK: Binding
extension ViewModel {
    func bind() {
        $searchText
            // Debounce 사용해 입력값이 변경될 때마다 호출하는것 방지
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .filter({ $0.isEmpty ? false : true })
            .sink { [weak self] text in
                self?.apiManager.searchRepositorys(p: text, completion: { repositorys in
                    self?.repos = repositorys.items
                })
            }
            .store(in: &cancellable)
        
        $repos
            .sink { repos in
                repos.forEach { repo in
                    print(repo)
                }
            }
            .store(in: &cancellable)
    }
}
