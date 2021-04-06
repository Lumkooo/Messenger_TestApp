//
//  ChatListPresenter.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import Foundation

protocol IChatListPresenter {
    func viewDidLoad(ui: IChatListView)
    func goToChat()
}

final class ChatListPresenter {

    // MARK: - Properties

    private let interactor: IChatListInteractor
    private let router: IChatListRouter
    private weak var ui: IChatListView?

    // MARK: - Init

    init(interactor: IChatListInteractor, router: IChatListRouter) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - IChatListPresenter

extension ChatListPresenter: IChatListPresenter {
    func viewDidLoad(ui: IChatListView) {
        self.ui = ui
        self.ui?.didSelectCellAt = { [weak self] (indexPath) in
            self?.interactor.didSelectCellAt(indexPath: indexPath)
        }
        self.ui?.removeRowAt = { [weak self] (indexPath) in
            self?.interactor.removeChatAt(indexPath)
        }
        self.interactor.loadInitData()
    }

    func goToChat() {
        self.interactor.addChatTapped()
    }
}

extension ChatListPresenter: IChatListInteractorOuter {
    func goToChat(delegate: IChatListInteractorDelegate, chatIndex: Int) {
        self.router.showChatVC(delegate: delegate, chatIndex: chatIndex)
    }

    func goToChat(_ chat: Chat, delegate: IChatListInteractorDelegate, chatIndex: Int) {
        self.router.showChatVC(chat, delegate: delegate, chatIndex: chatIndex)
    }

    func showChats(_ chats: [Chat]) {
        self.ui?.showChats(chats)
    }

    func appendChat(_ chat: Chat) {
        self.ui?.appendChat(chat)
    }

    func removeChatFrom(index: Int) {
        self.ui?.removeChatFrom(index)
    }

}
