//
//  ChatListInteractor.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import Foundation

protocol IChatListInteractor {
    func loadInitData()
}

protocol IChatListInteractorOuter: AnyObject {

}


final class ChatListInteractor {

    // MARK: - Properties

    weak var presenter: IChatListInteractorOuter?
}

// MARK: - IChatListInteractor

extension ChatListInteractor: IChatListInteractor {
    func loadInitData() {

    }
}
