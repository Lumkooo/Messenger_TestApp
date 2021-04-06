//
//  StartVCAssembly.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/3/21.
//

import UIKit

enum StartVCAssembly {
    static func createVC() -> UIViewController {
        let router = StartRouter()
        let interactor = StartInteractor()
        let presenter = StartPresenter(interactor: interactor, router: router)
        let viewController = StartViewController(presenter: presenter)

        interactor.presenter = presenter
        router.vc = viewController

        return viewController
    }
}
