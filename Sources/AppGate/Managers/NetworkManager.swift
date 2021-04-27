//
//  File.swift
//  
//
//  Created by Diego Giraldo Gómez on 25/04/21.
//

import Foundation

struct NetworkManager {
    
    typealias CompletionHandler =  (_ date: DateResponse?) -> Void
    
    func getDate(latitude: Double, longitude: Double, completion: @escaping CompletionHandler) {
        let session = URLSession.shared
        let url = URL(string: "\(Constants.dateAPIURL)&lat=\(String(latitude))&lng=\(String(longitude))")!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            if let data = data, let decodedResponse = try? JSONDecoder().decode(DateResponse.self, from: data) {
                completion(decodedResponse)
            }
            completion(nil)
        })
        task.resume()
    }
}
