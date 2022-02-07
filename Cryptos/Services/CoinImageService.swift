//
//  CoinImageService.swift
//  CoinImageService
//
//  Created by Sergio Cardoso on 23/08/21.
//

import Foundation
import SwiftUI
import Combine


class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    
    init(coin: CoinModel ) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: coin.id, folderName: folderName) {
            image = savedImage
            //print("Retrieved image from File Manager!")
        } else {
            downloadCoinImage()
            //print("Downloading image...")
        }
    }
   
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImages(image: downloadedImage, imageName: self.coin.id, folderName: self.folderName)
            })
    }
    
}
