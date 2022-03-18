//
//  APIManager.swift
//  WeatherApp
//
//  Created by Raj Kadam on 18/03/22.
//

import Foundation
import Alamofire

final class APIManager {
    static let manager = APIManager()
    private init(){}
    
    typealias APIResponse<T> = (Result<T?, CustomError>) -> Void
    private var additionalHeaders: [AnyHashable: Any] = [:]
    
    
    private var dataRequest: DataRequest?
    
    typealias ResponseCompletion<T: Decodable> = (T?, _ error: Error?, _ data: Data?) -> Void
    
    final func loadDataFromUrl<T: Decodable>(type model: T.Type,
                                             url: URL,
                                             method: HTTPMethod,
                                             parameters: [String: Any]?,
                                             headers: HTTPHeaders? = nil,
                                             completion:@escaping APIResponse<T>)
    {
        dataRequest = AF.request(url, method: method, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: T.self) { (response) in
                debugPrint(response.request ?? "API request default value")
                debugPrint(response.result)
                let stausCode = response.response?.statusCode ?? 400
               
               
                if let data = response.data {
                    let json = String(data: data, encoding: String.Encoding.utf8)
                    debugPrint("Failure Response: \(String(describing: json))")
                }
                switch response.result
                {
                case .success(let value):
                    
                    completion(.success(value))
                    
                case .failure(let error):
                    if stausCode == 404 {
                        completion(.failure(CustomError.init(description: "City Not Found")))
                    }else {
                        completion(.failure(CustomError.init(description: error.localizedDescription)))
                    }
                }
            }
    }
 
}
