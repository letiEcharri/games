//
//  DataSource.swift
//  games
//
//  Created by Leticia Personal on 19/03/2021.
//

import Foundation

typealias SuccessCompletionBlock = (_ object: AnyObject) -> Void
typealias FailureCompletionBlock = (_ error: Error) -> Void

protocol DataSource {
    func executeRequest(url: URL, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock)
    func readLocalFile(forName name: String) -> Data? 
}

extension DataSource {
    
    func executeRequest(url: URL, success: @escaping (SuccessCompletionBlock), failure: @escaping FailureCompletionBlock) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10.0
        config.timeoutIntervalForResource = 20.0
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    failure(error)
                } else if let jsonData = responseData {
                    success(jsonData as AnyObject)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                    failure(error)
                }
            }
        }
        
        task.resume()
    }
    
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }

        return nil
    }
}
