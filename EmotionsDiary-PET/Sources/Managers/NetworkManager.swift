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
        let category = "happiness".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/quotes?category="+category!)!
        var request = URLRequest(url: url)
        request.setValue("ZOAJKXqOeAnnNbArG8Ln8A==9X3D6JGQ3QKcoSlA", forHTTPHeaderField: "X-Api-Key")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                fatalError("ERROR IN URL")
            } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                guard let data = data else { return }
                do {
                    let decodedData = try JSONDecoder().decode([RandomQuote].self, from: data)
                    self.randomQuote = decodedData
                } catch {
                    print("ERROR IN DECODING DATA")
                }
            }
        }.resume()
    }
}
        
//let res: [String : String] = [""]

struct RandomQuote: Codable {
    let quote: String
    let author: String
let category: String
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



