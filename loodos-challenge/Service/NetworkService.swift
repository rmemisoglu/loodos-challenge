//
//  NetworkService.swift
//  loodos-challenge
//
//  Created by Ramazan Memişoğlu on 20.11.2020.
//

import Foundation
import Alamofire

// MARK: - Protocols
protocol APIService {
    func getFilms(with title: String, completion: @escaping (Result<SearchResponse, AFError>) -> ())
}

class NetworkService: APIService {
    
    static let shared = NetworkService()
    
    enum HttpMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
    }
    
    var headers: [String : String] {
        return ["Content-Type": "application/json"]
    }
    
    var baseUrl: URL {
        let baseUrlString = "https://omdbapi.com/"
        return URL(string: baseUrlString)!
    }
    
    private func requestServiceWithAlamofire<T: Codable>(urlRequest: URLRequest, completion: @escaping (Result<T, AFError>) -> ()) {

        print("\(#function) start")
        print("url: \(String(describing: urlRequest.url))")
        
        AF.request(urlRequest).validate(statusCode: 200..<299).responseDecodable(of: T.self) { response in
            let statusCode = response.response?.statusCode
            print(statusCode)
            switch response.result {
            case .success(let results):
                completion(.success(results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func getFilms(with title: String, completion: @escaping (Result<SearchResponse, AFError>) -> ()) {
        let serviceUrl = baseUrl
        
        guard var urlComponents = URLComponents(string: serviceUrl.absoluteString) else {
            return
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "apiKey", value: PersistentManager.shared.apiKey),
            //URLQueryItem(name: "t", value: title),
            URLQueryItem(name: "s", value: title),
            URLQueryItem(name: "plot", value: "full")
        ]
        
        guard let url = urlComponents.url else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HttpMethod.get.rawValue
        
        urlRequest.allHTTPHeaderFields = headers
        
        requestServiceWithAlamofire(urlRequest: urlRequest, completion: completion)
    }
}
