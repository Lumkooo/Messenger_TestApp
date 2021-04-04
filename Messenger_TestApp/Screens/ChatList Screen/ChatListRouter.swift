//
//  ChatListRouter.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import UIKit

protocol IChatListRouter {
    func showChatVC()
    func showChatVC(_ chat: Chat)
}

final class ChatListRouter {

    // MARK: - Properties

    weak var vc: UIViewController?
}

// MARK: - IChatListRouter

extension ChatListRouter: IChatListRouter {
    func showChatVC() {
        let chat = Chat()
        self.presentChatVC(forChat: chat)
    }

    func showChatVC(_ chat: Chat) {
        self.presentChatVC(forChat: chat)
    }

    private func presentChatVC(forChat chat: Chat) {
        let viewController = ChatVCAssembly.createVC(chat: chat)
        self.vc?.navigationController?.pushViewController(viewController, animated: true)
    }
}
