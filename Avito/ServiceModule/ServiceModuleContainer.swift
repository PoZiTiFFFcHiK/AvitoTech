//
//  ServiceModuleContainer.swift
//  Avito
//
//  Created by Владимир on 18.01.2021.
//  
//

import UIKit

final class ServiceModuleContainer {
    let input: ServiceModuleModuleInput
	let viewController: UIViewController
	private(set) weak var router: ServiceModuleRouterInput!

	static func assemble(with context: ServiceModuleContext) -> ServiceModuleContainer {
        let router = ServiceModuleRouter()
        let interactor = ServiceModuleInteractor()
        let presenter = ServiceModulePresenter(router: router, interactor: interactor)
		let viewController = ServiceModuleViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
        
        router.viewController = viewController

		interactor.output = presenter

        return ServiceModuleContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: ServiceModuleModuleInput, router: ServiceModuleRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct ServiceModuleContext {
	weak var moduleOutput: ServiceModuleModuleOutput?
}
