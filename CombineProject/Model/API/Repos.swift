//
//  Repos.swift
//  CombineProject
//
//  Created by 노건호 on 2022/08/19.
//

import Foundation

// MARK: - Repositorys
struct Repositorys: Codable {
    let incompleteResults: Bool
    let items: [Repo]
    let totalCount: Int

    enum CodingKeys: String, CodingKey {
        case incompleteResults = "incomplete_results"
        case items
        case totalCount = "total_count"
    }
}

// MARK: - Repo
struct Repo: Codable, Equatable {
    let uuid = UUID()
    let fullName: String
    let url: String
    let owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case owner
        case url = "html_url"
    }
    
    static func == (lhs: Repo, rhs: Repo) -> Bool {
        if lhs.fullName == rhs.fullName && lhs.url == rhs.url {
            return true
        }
        return false
    }
}

struct Owner: Codable {
    let avatarURL: String
    let reposURL: String
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case reposURL = "repos_url"
    }
}
