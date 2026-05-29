import UIKit

var greeting = "Hello, playground"


//Single Responsibility Principle (SRP)
protocol APIService{
    func requestData() -> Data
}

protocol DataParser{
    func parse(data: Data) -> [String]
}

protocol DatabaseService{
    func save(data: [String])
}

class Handler {
    private let apiService: APIService
    private let parser: DataParser
    private let database: DatabaseService
    
    init(apiService: APIService, parser: DataParser, database: DatabaseService) {
        self.apiService = apiService
        self.parser = parser
        self.database = database
    }
    
    func handle() {
        let data = apiService.requestData()
        let arr = parser.parse(data: data)
        database.save(data: arr)
    }
}


//Open-C;osed Principle (OCP) & Single Responsibility Principle (SRP)
protocol NetworkSession {
    func loadData(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func loadData(from url: URL, completionHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) { data, _, error in
            completionHandler(data, error)
        }
        task.resume()
    }
}
class UserFetcher {
    private let session: NetworkSession
    private let decoder: JSONDecoder
    
    init(session: NetworkSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func fetchUsers(onComplete: @escaping ([User]) -> Void) {
        guard let url = URL(string: "https://api.example.com/users") else {
            onComplete([])
            return
        }
        
        session.loadData(from: url) { [weak self] (data, error) in
            guard let self = self, let data = data, error == nil else {
                print(error?.localizedDescription ?? "Unknown error")
                onComplete([])
                return
            }
            
            let decoded = try? self.decoder.decode([User].self, from: data)
            onComplete(decoded ?? [])
        }
    }
}


//Interface Segregation Principle (ISP)
protocol TapGestureProtocol {
    func didTap()
}

protocol DoubleTapGestureProtocol {
    func didDoubleTap()
}

protocol LongPressGestureProtocol {
    func didLongPress()
}

class SuperButton: TapGestureProtocol, DoubleTapGestureProtocol, LongPressGestureProtocol {
    func didTap() {
        // send tap action
    }
    
    func didDoubleTap() {
        // send double tap action
    }
    
    func didLongPress() {
        // send long press action
    }
}

class PoorButton: TapGestureProtocol {
    func didTap() {
        // send tap action
    }
}
