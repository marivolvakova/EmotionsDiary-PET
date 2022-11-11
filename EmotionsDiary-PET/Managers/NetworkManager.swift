//
//  NetworkManager.swift
//  EmotionsDiary-PET
//
//  Created by Мария Вольвакова on 09.11.2022.
//

import UIKit
import Alamofire


final class NetworkManager {
    
    static let shared = NetworkManager()
    
    var randomQuote: [RandomQuote]?
    
    func fetchData() {
        if let fileLocation = Bundle.main.url(forResource: "quotes", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let decoder = JSONDecoder()
                let dataFromeJson = try decoder.decode([RandomQuote].self, from: data)
                self.randomQuote = dataFromeJson
            } catch {
                print(error)
            }
        }
    }
}

struct RandomQuote: Codable {
    let text: String
    let author: String?
}

struct RandomQuotes: Codable {
    let quote: RandomQuote
}
/*
 https://type.fit/api/quotes
 https://api.quotable.io/random
 */

//    extension NetworkManager {
//        func alert(title: String, message: String) {
//            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//            let alertButton = UIAlertAction(title: "Ok", style: .default)
//            alert.addAction(alertButton)
//            present(alert, animated: true, completion: nil)
//        }
//    }



