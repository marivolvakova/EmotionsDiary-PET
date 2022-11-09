//
//  NetworkManager.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 09.11.2022.
//

import Foundation


final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let url = "https://type.fit/api/quotes"
    var randomQuote: RandomQuote?
    
    func fetchData() {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                fatalError("ERROR IN URL")
            } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                guard let data = data else { return }
                do {
                    let decodedData = try JSONDecoder().decode(RandomQuotes.self, from: data)
                    self.randomQuote = decodedData.randomQuote
                } catch {
                    print("ERROR IN DECODING DATA")
                }
            }
        }.resume()
    }
}


struct RandomQuotes: Decodable {
    var randomQuote: [RandomQuote]
}

struct RandomQuote: Decodable {
    var text: String
    var author: String
}


/*
 https://type.fit/api/quotes
 https://api.quotable.io/random
 */

