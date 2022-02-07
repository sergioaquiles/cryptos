//
//  HomeViewModel.swift
//  HomeViewModel
//
//  Created by Sergio Cardoso on 22/08/21.
//

import Foundation
import Combine
import SwiftUI


class HomeViewModel: ObservableObject {
    
    @Published var statistics: [StatisticModel] = []
    
    @Published var allCoins = [CoinModel]()
    @Published var portfolioCoins = [CoinModel]()
    @Published var searchText = ""
    @Published var sortOption: SortOptions = .holdings
    
    @Published var isLoading: Bool = false
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    
    enum SortOptions {
        case rank, rankReversed, holdings, holdingsReversed, price, PriceReversed
    }
    
    
    init() {
        addSubscribers()
    }
    
    
    func addSubscribers() {
        
        //updates allcoins
        $searchText
            .combineLatest(coinDataService.$allcoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { (returnedCoins) in
                self.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
        // updates the portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink{ [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        // updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
        
    }
    
    func updatePortfolio(coin: CoinModel, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getCoins()
        HapticManager.notification(type: .success)
        
    }
    
    private func filterAndSortCoins(text: String, coins: [CoinModel], sort: SortOptions) -> [CoinModel] {
        var updatedCoins = filtereCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &updatedCoins)
        return updatedCoins
    }
    
    private func filtereCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        let lowercaseText = text.lowercased()
        return coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowercaseText) || coin.symbol.lowercased().contains(lowercaseText) || coin.id.lowercased().contains(lowercaseText)
        }
    }
    
    private func sortCoins(sort: SortOptions, coins: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: {$0.rank <  $1.rank})
        case .rankReversed, .holdingsReversed:
            coins.sort(by: {$0.rank > $1.rank})
        case .price:
            coins.sort(by: {$0.currentPrice > $1.currentPrice})
        case .PriceReversed:
            coins.sort(by: {$0.currentPrice < $1.currentPrice})
        }

    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        
        switch sortOption {
        case .holdings:
            return coins.sorted(by:{$0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingsReversed:
            return coins.sorted(by:{$0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
        }
        
    }
    
    
    
    private func mapAllCoinsToPortfolioCoins(allcoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
        allcoins
            .compactMap { (coin) -> CoinModel? in
                guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id}) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    
    private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let data = marketDataModel else {
            return stats
        }
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = portfolioCoins.map { $0.currentHoldingsValue }.reduce(0, +)
        
        let previousValue = portfolioCoins.map { (coin) -> Double in
            let currentValue = coin.currentHoldingsValue
            let percentChange = coin.priceChangePercentage24H ?? 0 / 100
            let previousValue = currentValue / (1 + percentChange)
            return previousValue
        }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue)
        
        let portifolio = StatisticModel(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portifolio
        ])
        return stats
      }
    
    
}
