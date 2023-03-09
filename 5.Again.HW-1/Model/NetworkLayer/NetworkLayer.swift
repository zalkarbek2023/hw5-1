//
//  NetworkLayer.swift
//  5.Again.HW-1
//
//  Created by zalkarbek on 8/3/23.
//

import UIKit
import Alamofire

final class NetworkLayer {
    
    static let shared = NetworkLayer()
    private init() { }
    
    var baseURL = URL(string: "https://dummyjson.com/products")!
    
    func fetchingAPIData() async throws -> MainProductModel {
        let request = URLRequest(url: baseURL)
            let (data, _) = try await URLSession.shared.data(for: request)
            let model: MainProductModel = self.decode(with: data)
            return model
    }
    func decode<T: Decodable>(with data: Data) -> T {
        try! JSONDecoder().decode(T.self, from: data)
    }
}


//func fetchingAPIData() async throws -> ProductModel {
//    let request = URLRequest(url: baseURL)
//    let (data, _) = try await URLSession.shared.data(for: request)
//    let model: ProductModel = self.decode(with: data)
//    return model
//}
//
//func decode<T: Decodable>(with data: Data) -> T {
//    try! JSONDecoder().decode(T.self, from: data)
//}




//func fetchingAPIData() async throws -> ProductModel {
//    let apiRequest = await withCheckedContinuation { continuation in
//        AF.request(baseURL, method: .get).validate().responseData { apiRequest in
//            continuation.resume(returning: apiRequest)
//        }
//    }
//
//    let (data, _) = try await URLSession.shared.data(for: apiRequest.request!)
//    return await decodeData(data: data)
//}
//
//func decodeData<T: Decodable>(data: Data) async -> T {
//    let decoder = JSONDecoder()
//    return try! decoder.decode(T.self, from: data)
//}
