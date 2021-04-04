//
//  ChatListPresenter.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import Foundation

protocol IChatListPresenter {
    func viewDidLoad(ui: IChatListView)
    func goToChat(_ chat: Chat)
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
        self.interactor.loadInitData()
    }

    func goToChat(_ chat: Chat) {
        self.router.showChatVC(chat)
    }

    func goToChat() {
        self.router.showChatVC()
    }
}

extension ChatListPresenter: IChatListInteractorOuter {

}
