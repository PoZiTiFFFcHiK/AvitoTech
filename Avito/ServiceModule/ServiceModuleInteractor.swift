//
//  ServiceModuleInteractor.swift
//  Avito
//
//  Created by Владимир on 18.01.2021.
//  
//

import Foundation
import UIKit

final class ServiceModuleInteractor {
	weak var output: ServiceModuleInteractorOutput?
}

extension ServiceModuleInteractor: ServiceModuleInteractorInput {
    func fetchData() {
        let jsonData = JSON(fileName: "result")
        jsonData.getJsonFromFile() { data in data
            self.output?.didLoad(servicesData: data)
        }
    }
    
    func getImageFromURL(url: String, button: UIButton) {
        let urlConnect = URLConnection(urlString: url)
        urlConnect.getImageData() { data in data
            self.output?.getImageData(imageData: data, button: button)
        }
    }
}
