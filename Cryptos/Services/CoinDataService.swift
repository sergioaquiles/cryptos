//
//  CoinDataService.swift
//  CoinDataService
//
//  Created by Sergio Cardoso on 22/08/21.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allcoins = [CoinModel]()
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24") else { return }
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoins in
                self?.allcoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
     }
    
}
