//
//  CardError.swift
//  DeckOfOneCard
//
//  Created by Cynthia Nikolai on 5/4/21.
//

import Foundation

enum CardError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return "Unable to reach the server!"
            case .thrownError(let error):
                print(error.localizedDescription)
                return "Card does not exist\nPlease check your syntax!"
            case .noData:
                return "The server responded with no data!"
            case .unableToDecode:
                return "The server responded with bad data. Blame the back end team, not the front end team!"
        }
    }
}
