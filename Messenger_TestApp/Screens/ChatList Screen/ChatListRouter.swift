//
//  ChatListRouter.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import UIKit

protocol IChatListRouter {
    func showAlert(message: String)
    func showChatVC(delegate: IChatListInteractorDelegate)
    func showChatVC(_ chat: Chat, delegate: IChatListInteractorDelegate)
}

final class ChatListRouter {

    // MARK: - Properties

    weak var vc: UIViewController?
}

// MARK: - IChatListRouter

extension ChatListRouter: IChatListRouter {
    func showChatVC(delegate: IChatListInteractorDelegate) {
        let chat = Chat()
        self.presentChatVC(forChat: chat, delegate: delegate)
    }

    func showChatVC(_ chat: Chat, delegate: IChatListInteractorDelegate) {
        self.presentChatVC(forChat: chat, delegate: delegate)
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка!",
                                      message: message,
                                      preferredStyle: .alert)
        let alertYesAction = UIAlertAction(title: "Ok",
                                           style: .default)
        alert.addAction(alertYesAction)
        self.vc?.present(alert, animated: true)
    }

    private func presentChatVC(forChat chat: Chat,
                               delegate: IChatListInteractorDelegate) {
        let viewController = ChatVCAssembly.createVC(chat: chat, delegate: delegate)
        self.vc?.navigationController?.pushViewController(viewController, animated: true)
    }
}
