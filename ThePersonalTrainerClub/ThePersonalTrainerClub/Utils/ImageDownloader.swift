//
//  ImageDownloader.swift
//  ThePersonalTrainerClub
//
//  Created by David Lopez Rodriguez on 20/11/2018.
//  Copyright © 2018 eXceptionCoders. All rights reserved.
//

import UIKit

typealias ImageDownloaderClousure = ((Bool, IndexPath?, UIImage?, Error?) -> Void)?

class ImageDownloader: Operation {
    let urlString: String
    let completion: ImageDownloaderClousure
    let indexPath: IndexPath?
    
    var end = false
    
    override var isFinished: Bool {
        return end
    }
    
    init(urlString: String, indexPath: IndexPath?, completion: ImageDownloaderClousure) {
        self.urlString = urlString
        self.completion = completion
        self.indexPath = indexPath
        super.init()
    }
    
    override func main() {
        if let completion = completion {
            let url = URL(string: urlString)
            
            let dataTask = URLSession.shared.dataTask(
                with: url!,
                completionHandler: { (data, urlResponse, error) in
                if let realData = data {
                    completion(true, self.indexPath, UIImage(data: realData), nil)
                } else {
                    completion(false, self.indexPath, nil, error!)
                }

                self.willChangeValue(forKey: "isFinished") // KVO.
                self.end = true
                _ = self.isFinished
                self.didChangeValue(forKey: "isFinished")   // KVO
            })
            
            dataTask.resume()
        }
    }
}
