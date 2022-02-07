//
//  CoinImageViewModel.swift
//  CoinImageViewModel
//
//  Created by Sergio Cardoso on 23/08/21.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isloading = false
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    private var calcellables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscribers()
        self.isloading = true
    }
    
    private func addSubscribers() {
        
        dataService.$image
            .sink { [weak self] (_) in
                self?.isloading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image =  returnedImage
            }
            .store(in: &calcellables)

    }
    
}
