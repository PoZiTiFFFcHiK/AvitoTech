//
//  ServiceModulePresenter.swift
//  Avito
//
//  Created by Владимир on 18.01.2021.
//  
//

import Foundation
import UIKit

final class ServiceModulePresenter {
	weak var view: ServiceModuleViewInput?
    weak var moduleOutput: ServiceModuleModuleOutput?
    
	private let router: ServiceModuleRouterInput
	private let interactor: ServiceModuleInteractorInput
    
    init(router: ServiceModuleRouterInput, interactor: ServiceModuleInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension ServiceModulePresenter: ServiceModuleModuleInput {
}

extension ServiceModulePresenter: ServiceModuleViewOutput {
    func loadData() {
        self.interactor.fetchData()
    }
    
    func getImage(url: String, button: UIButton) {
        let stringURL = url
        self.interactor.getImageFromURL(url: url, button: button)
    }
    
    func didSelectButtonPressed(title: String) {
        self.router.showTitleAlert(title: title)
    }
}

extension ServiceModulePresenter: ServiceModuleInteractorOutput {
    func didLoad(servicesData: Services) {
        let title = servicesData.result.title
        let actionTitle = servicesData.result.actionTitle
        let selectedActionTitle = servicesData.result.selectedActionTitle
        var serviceArray = [ServiceInfo]()
        for service in servicesData.result.list {
            serviceArray.append(ServiceInfo(serviceData: service))
        }
        self.view?.getData(firstTitle: title, actionTitle: actionTitle, selectedActionTitle: selectedActionTitle, servicesInfo: serviceArray)
    }
    
    func getImageData(imageData: Data, button: UIButton) {
        self.view?.getImageDataToView(imageData: imageData, button: button)
    }
}
