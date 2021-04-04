//
//  ChatInteractor.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import Foundation

protocol IChatInteractor {
    func loadInitData()
}

protocol IChatInteractorOuter: AnyObject {

}


final class ChatInteractor {

    // MARK: - Properties

    private var chat: Chat
    weak var presenter: IChatInteractorOuter?

    // MARK: - Init

    init(chat: Chat) {
        self.chat = chat
    }
}

// MARK: - IChatInteractor

extension ChatInteractor: IChatInteractor {
    func loadInitData() {
        
    }
}
