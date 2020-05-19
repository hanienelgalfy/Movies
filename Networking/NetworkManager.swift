//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by Hanien ElGalfy on 5/17/20.
//  Copyright © 2020 Hanien ElGalfy. All rights reserved.
//

import Foundation
struct Movie{
    var title: String
    var overview: String
    var release_date: Date
    var poster_path: URL
}
class NetworkManager{
    static let shared = NetworkManager()
    func getMovies(completion: @escaping (Movie?) -> ()){
        var movie = Movie(title: "", overview: "", release_date: Date() , poster_path: URL(string: "https://www.apple.com")!)
        var request = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/550?api_key=13deb0efdaafbd410c2d8d1a3e1579c3")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print(data)
            if let d = data {
                if let value = String(data: d, encoding: String.Encoding.ascii) {
                    
                    if let jsonData = value.data(using: String.Encoding.utf8) {
                        do {
                            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
                            
                            if let title = json["title"] as? String {
                                movie.title = title
                                // print(movie.title)
                            }
                            
                        } catch {
                            completion(nil)
                            NSLog("ERROR \(error.localizedDescription)")
                        }
                    }
                }
            }
            
            
            
        }
        task.resume()
    }
}
