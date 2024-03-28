//
//  NetworkService.swift
//  ProfileTask
//
//  Created by Danil Komarov on 28.03.2024.
//

import Foundation

final class NetworkService {
    
    // MARK: - Constants

    private enum Constants {
        static let scheme = "https"
        static let host = "publicstorage.hb.bizmrg.com"
        static let path = "/sirius/result.json"
    }
    
    private let decoder = JSONDecoder()
    private let session = URLSession.shared
    
    // MARK: - Internal Methods
    
    func getServices(complition: @escaping (Result<[Service], NetworkError>) -> Void) {
        let request = URLRequest(url: getURL(Constants.path), cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: Double.infinity)
        
        session.dataTask(with: request) { [weak self] data, _, error in
            
            if error != nil {
                complition(.failure(.urlError))
            }
            else if let data = data {
                do {
                    let result = try self?.decoder.decode(ServicesModel.self, from: data)
                    complition(.success(result?.body?.services ?? []))
                } catch {
                    complition(.failure(.canNotParseData))
                }
            }
        } .resume()
    }
    
    // MARK: - Private Methods
    
    private func getURL(_ path: String) -> URL {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = path
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        debugPrint(url)
        return url
    }
}
