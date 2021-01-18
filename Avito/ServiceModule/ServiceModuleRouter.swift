//
//  ServiceModuleRouter.swift
//  Avito
//
//  Created by Владимир on 18.01.2021.
//  
//

import UIKit

final class ServiceModuleRouter {
    weak var viewController: ServiceModuleViewController?
}

extension ServiceModuleRouter: ServiceModuleRouterInput {
    func showTitleAlert(title: String) {
        let alertController = UIAlertController(title: "Вы выбрали", message: title, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.viewController?.present(alertController, animated: true, completion: nil)
    }
}
