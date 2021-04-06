//
//  ChatListRouter.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import UIKit

protocol IChatListRouter {
    func showChatVC(delegate: IChatListInteractorDelegate, chatIndex: Int)
    func showChatVC(_ chat: Chat, delegate: IChatListInteractorDelegate, chatIndex: Int)
}

final class ChatListRouter {

    // MARK: - Properties

    weak var vc: UIViewController?
}

// MARK: - IChatListRouter

extension ChatListRouter: IChatListRouter {
    func showChatVC(delegate: IChatListInteractorDelegate, chatIndex: Int) {
        let chat = Chat()
        self.presentChatVC(forChat: chat, delegate: delegate, chatIndex: chatIndex)
    }

    func showChatVC(_ chat: Chat, delegate: IChatListInteractorDelegate, chatIndex: Int) {
        self.presentChatVC(forChat: chat, delegate: delegate, chatIndex: chatIndex)
    }

    private func presentChatVC(forChat chat: Chat, delegate: IChatListInteractorDelegate, chatIndex: Int) {
        let viewController = ChatVCAssembly.createVC(chat: chat, delegate: delegate, chatIndex: chatIndex)
        self.vc?.navigationController?.pushViewController(viewController, animated: true)
    }
}
