//
//  ChatVCAssembly.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import UIKit

enum ChatVCAssembly {
    static func createVC(chat: Chat) -> UIViewController {
        let interactor = ChatInteractor(chat: chat)
        let router = ChatRouter()
        let presenter = ChatPresenter(interactor: interactor, router: router)
        let viewController = ChatViewController(presenter: presenter)

        interactor.presenter = presenter
        router.vc = viewController

        return viewController
    }
}
