//
//  ServiceModuleProtocols.swift
//  Avito
//
//  Created by Владимир on 18.01.2021.
//  
//

import Foundation
import UIKit

protocol ServiceModuleModuleInput {
	var moduleOutput: ServiceModuleModuleOutput? { get }
}

protocol ServiceModuleModuleOutput: class {
}

protocol ServiceModuleViewInput: class {
    func getData(firstTitle: String, actionTitle: String, selectedActionTitle: String, servicesInfo: [ServiceInfo])
    func getImageDataToView(imageData: Data, button: UIButton)
}

protocol ServiceModuleViewOutput: class {
    func loadData()
    func getImage(url: String, button: UIButton)
    func didSelectButtonPressed(title: String)
}

protocol ServiceModuleInteractorInput: class {
    func fetchData()
    func getImageFromURL(url: String, button: UIButton)
}

protocol ServiceModuleInteractorOutput: class {
    func didLoad(servicesData: Services)
    func getImageData(imageData: Data, button: UIButton)
}

protocol ServiceModuleRouterInput: class {
    func showTitleAlert(title: String)
}
