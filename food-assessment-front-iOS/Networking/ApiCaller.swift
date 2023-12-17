//
//  ApiCaller.swift
//  food-assessment-front-iOS
//
//  Created by Sergio Eduardo Zorilla Arellano on 16/12/23.
//

import Foundation

struct ApiCaller {
    private let mainURL = "http://localhost:6060"
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()

    func fetch<T: Decodable>(type: T.Type, from urlString: String) async -> T? {
        let completeURL = mainURL + urlString
        guard let url = URL(string: completeURL) else { return nil }
        do {
            let (data, _) = try await URLSession
                .shared
                .data(from: url)
            return try decoder.decode(type, from: data)
        } catch {
            print("Info could not be decoded: \(error)")
            return nil
        }
    }
}

enum PathsUrl {
    case categories
    case categoryFoods(category: String)
    case food(category: String, id: String)
    
    var pathId: String {
        switch self {
        case .categories:
            return "/categories"
        case .categoryFoods(let category):
            return "/category/foods/\(category)"
        case .food(let category, let id):
            return "/\(category)/food/\(id)"
        }
    }
}
