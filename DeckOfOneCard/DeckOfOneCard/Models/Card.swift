//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Cynthia Nikolai on 5/4/21.
//

import Foundation

struct TopLevelObject:Decodable {
    let cards: [Card]
}

struct Card:Decodable {
    let image: URL?
    let value: String
    let suit: String
}
