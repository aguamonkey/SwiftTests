//
//  NewMockDataService.swift
//  Protocols+Dependency+Testing
//
//  Created by Gobias LTD on 17/01/2023.
//

import Foundation
import SwiftUI
import Combine

protocol NewDataServiceProtocol {
    
    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> ())
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error>
}

class NewMockDataService: NewDataServiceProtocol {
    
    // We be testing asynchronus code
    
    let items: [String]
    
    init(items: [String]?) {
        self.items = items ?? [
        "One", "Two", "Three"
        ]
    }
    
    func downloadItemsWithEscaping(completion: @escaping (_ items: [String]) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion(self.items)
        }
        
    }
    
    func downloadItemsWithCombine() -> AnyPublisher<[String], Error> {
        Just(items)
            .tryMap({ publishedItems in
                guard !publishedItems.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return publishedItems
            })
            .eraseToAnyPublisher()
        
    }
}

