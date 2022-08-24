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
            .filter({ $0.isEmpty ? false : true })
            .sink { [weak self] text in
                self?.page = 1
                self?.apiManager.searchRepositorys(p: text, page: 1, completion: { repositorys in
                    self?.repos = repositorys.items
                })
            }
            .store(in: &cancellable)
        
        $page
            .filter({ $0 != 1 })
            .sink { [weak self] page in
                self?.apiManager.searchRepositorys(p: self?.searchText ?? "", page: self?.page ?? 1, completion: { repositorys in
                    if page == 1 {
                        self?.repos = repositorys.items
                    } else {
                        var newRepo = self?.repos
                        repositorys.items.forEach { repo in
                            newRepo?.append(repo)
                        }
                        self?.repos = newRepo!

                    }
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
