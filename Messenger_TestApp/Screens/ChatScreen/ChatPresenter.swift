//
//  ChatPresenter.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import Foundation

protocol IChatPresenter {
    func viewDidLoad(ui: IChatView)
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
        self.interactor.loadInitData()
    }
}

extension ChatPresenter: IChatInteractorOuter {
    func showMessages(_ messages: [Message]) {
        self.ui?.showMessages(messages)
    }
}
