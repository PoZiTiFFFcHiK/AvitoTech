//
//  URLService.swift
//  Avito
//
//  Created by Владимир on 18.01.2021.
//

import Foundation

class URLConnection {
    let url: URL?
    
    init(urlString: String) {
        self.url = URL(string: urlString)
    }
    
    func getImageData(result: @escaping (Data) -> (Void)) {
        DispatchQueue.main.async {
            if let data = try? Data(contentsOf: self.url!) {
                result(data)
            }
        }
    }
}

