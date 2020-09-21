//
//  APIService.swift
//  MVVMPlayground
//
//  Created by Neo on 01/10/2017.
//  Copyright © 2017 ST.Huang. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case permissionDenied = "You don't have permission"
}

protocol APIServiceProtocol {
    typealias  Closure = ( _ success: Bool, _ photos: [Photo], _ error: APIError? )->()
    func fetchPopularPhoto( complete: @escaping Closure )
}

class APIService: APIServiceProtocol {
    // MARK: - Simulate a long waiting for fetching
    typealias  Closure = ( _ success: Bool, _ photos: [Photo], _ error: APIError? )->()
    
    
    func fetchPopularPhoto( complete: @escaping Closure ) {
        DispatchQueue.global().async {
            sleep(3)
            let path = Bundle.main.path(forResource: "content", ofType: "json")!
            let data = try! Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let photos = try! decoder.decode(Photos.self, from: data)
            complete( true, photos.photos, nil )
        }
    }
    
    
    
}







