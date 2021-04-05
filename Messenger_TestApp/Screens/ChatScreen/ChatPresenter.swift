//
//  ChatPresenter.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import Foundation

protocol IChatPresenter {
    func viewDidLoad(ui: IChatView)
    func viewDidAppear()
    func viewDidDissapear()
}

final class ChatPresenter {

    // MARK: - Properties

    private let interactor: IChatInteractor
    private let router: IChatRouter
    private weak var ui: IChatView?

    // MARK: - Init

    init(interactor: IChatInteractor, router: IChatRouter) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - IChatPresenter

extension ChatPresenter: IChatPresenter {
    func viewDidLoad(ui: IChatView) {
        self.ui = ui
        self.ui?.sendButtonTapedWith = { [weak self] (messageText) in
            self?.interactor.appendTextToChat(messageText)
        }
        self.interactor.loadInitData()
    }

    func viewDidAppear() {
        let messagesCount = self.interactor.getMessagesCont()
        self.ui?.scrollCollectionView(toRow: messagesCount)
    }

    func viewDidDissapear() {
        self.interactor.saveChat()
    }
}

extension ChatPresenter: IChatInteractorOuter {
    func showMessages(_ messages: [Message]) {
        self.ui?.showMessages(messages)
    }

    func appendMessage(_ message: Message, atRow row: Int) {
        self.ui?.appendMessage(message, atRow: row)
    }
}
