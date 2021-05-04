//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Cynthia Nikolai on 5/4/21.
//

import UIKit

class CardController {
    
    // MARK:-String Constants
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/")
    static let newDeckPathComponent = "new/draw"
    
    static func fetchCard(completion: @escaping (Result<Card, CardError>) -> Void) {
        // 1 - Prepare the URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        let newDeckURL = baseURL.appendingPathComponent(newDeckPathComponent)
        var components = URLComponents(url: newDeckURL, resolvingAgainstBaseURL: true)
        let cardQuery = URLQueryItem(name: "count", value: "1")
        components?.queryItems = [cardQuery]
        guard let finalURL = components?.url else { return completion(.failure(.invalidURL)) }
        print("FinalURL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("CARD STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else { return completion(.failure(.noData))}
            
            do {
                let card = try JSONDecoder().decode(TopLevelObject.self, from: data)
                completion(.success(card.cards[0]))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void) {
        guard let url = card.image else { return completion(.failure(.noData))}
       
            URLSession.shared.dataTask(with: url) { data, response, error in
          
                if let error = error {
                    return completion(.failure(.thrownError(error)))
                }
                
                if let response = response as? HTTPURLResponse {
                    print("IMAGE STATUS CODE: \(response.statusCode)")
                }
                
                guard let data = data else { return completion(.failure(.noData))}
                
                guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
                completion(.success(image))
        }.resume()
    }
}
