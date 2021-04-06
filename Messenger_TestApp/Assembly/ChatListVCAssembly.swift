//
//  ChatListVCAssembly.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import UIKit

enum ChatListVCAssembly {
    static func createVC() -> UIViewController {
        let interactor = ChatListInteractor()
        let router = ChatListRouter()
        let presenter = ChatListPresenter(interactor: interactor, router: router)
        let viewController = ChatListViewController(presenter: presenter)

        interactor.presenter = presenter
        router.vc = viewController

        return viewController
    }
}
