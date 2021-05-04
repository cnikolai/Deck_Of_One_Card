//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Cynthia Nikolai on 5/4/21.
//

import UIKit

class CardViewController: UIViewController {
    
    // MARK:-Outlets
    @IBOutlet weak var cardSuitLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    // MARK:-Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK:-Actions
    @IBAction func drawCardButtonTapped(_ sender: Any) {
        CardController.fetchCard { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async { [self] in
            switch result {
                case .success(let card):
                    self.fetchImageAndUpdateViews(for: card)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
            }
            }
        }
    }
    
    // MARK:-Functions
    func fetchImageAndUpdateViews(for card: Card) {
        CardController.fetchImage(for: card) { [weak self] result in
            //UI has to be updated on the main thread
            DispatchQueue.main.async { [self] in
                guard let self = self else { return }
                switch result {
                    case .success(let image):
                        self.cardImageView.image = image
                        self.cardSuitLabel.text = "\(card.value) of \(card.suit)"
                    case .failure(let error):
                        self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}
