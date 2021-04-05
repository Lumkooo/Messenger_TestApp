//
//  ChatListRouter.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import UIKit

protocol IChatListRouter {
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

    private func presentChatVC(forChat chat: Chat, delegate: IChatListInteractorDelegate) {
        let viewController = ChatVCAssembly.createVC(chat: chat, delegate: delegate)
        self.vc?.navigationController?.pushViewController(viewController, animated: true)
    }
}
