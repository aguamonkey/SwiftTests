//
//  DependencyInjectionBootcamp.swift
//  Protocols+Dependency+Testing
//
//  Created by Gobias LTD on 16/01/2023.
//

import SwiftUI
import Combine

struct PostsModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

protocol DataServiceProtocol {
    
    func getData() -> AnyPublisher<[PostsModel], Error>
}

// Class that is incharge of fetching all of the data
class ProductionDataService: DataServiceProtocol {
    
   // static let instance = ProductionDataService() // Singleton
    
    // We know its a url
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}

class MockDataService: DataServiceProtocol {
    
    let testData: [PostsModel] /* = [
        PostsModel(userId: 1, id: 1, title: "One", body: "one"),
        PostsModel(userId: 2, id: 2, title: "Two", body: "two"),
        PostsModel(userId: 3, id: 3, title: "Three", body: "three")
        ] */
    
    init(data: [PostsModel]?) {
        self.testData = data ?? [
            PostsModel(userId: 1, id: 1, title: "One", body: "one"),
            PostsModel(userId: 2, id: 2, title: "Two", body: "two"),
            PostsModel(userId: 3, id: 3, title: "Three", body: "three")
            ]
    }
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
     //If you jyust want to return one publisher then you use the Just command
        Just(testData)
        //try map is because a Just can't return an error and our protocol requires we deal with one
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
    
    // It's good to create mock examples so you can clarify if your code is working
    
    
    
}

// Say you had loads of dependencies you wanted to pass around instead of passing them all into the init you could add them to a parent master class:

class Dependencies {
    let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }
    
}



class DependencyInjectionViewModel: ObservableObject {
    
    @Published var dataArray: [PostsModel] = []
    var cancellables = Set<AnyCancellable>()
    
    let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        loadPosts()
    }
    
    private func loadPosts() {
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedPosts in
                self?.dataArray = returnedPosts
            }
            .store(in: &cancellables)
        
    }
    
}

struct DependencyInjectionBootcamp: View {
    
    @StateObject private var vm: DependencyInjectionViewModel
    
    init(dataService: DataServiceProtocol) {
        _vm = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.dataArray) { post in
                    Text(post.title)
                }
            }
        }
    }
}

struct DependencyInjectionBootcamp_Previews: PreviewProvider {
    //static let dataService = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!) // would initialise this earlier
    static let dataService = MockDataService(data: nil)
// For unit tests the below will be the structure we require:
    static let dataServiceTwo = MockDataService(data: [
    PostsModel(userId: 1343, id: 421421, title: "What up>", body: "Pussy cat woah woah")])
    
    static var previews: some View {
        
        DependencyInjectionBootcamp(dataService: dataServiceTwo)
    }
}
