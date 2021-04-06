//
//  ChatListInteractor.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import Foundation

protocol IChatListInteractor {
    func loadInitData()
    func didSelectCellAt(indexPath: IndexPath)
    func addChatTapped()
    func removeChatAt(_ indexPath: IndexPath)
}

protocol IChatListInteractorOuter: AnyObject {
    func showChats(_ chats: [Chat])
    func appendChat(_ chat: Chat)
    func goToChat(delegate: IChatListInteractorDelegate)
    func goToChat(_ chat: Chat, delegate: IChatListInteractorDelegate)
    func removeChatFrom(index: Int)
}

protocol IChatListInteractorDelegate {
    func saveChat(_ chat: Chat)
}

final class ChatListInteractor {

    // MARK: - Properties

    weak var presenter: IChatListInteractorOuter?
    private var chats: [Chat] = []

}

// MARK: - IChatListInteractor

extension ChatListInteractor: IChatListInteractor {
    func loadInitData() {
        JsonLoader.loadJSON { chats in
            self.chats = chats
            self.presenter?.showChats(self.chats)
        } errorCompletion: { (string) in
            print(string)
        }

    }

    func didSelectCellAt(indexPath: IndexPath) {
        if self.chats.count > indexPath.row {
            let chat = self.chats[indexPath.row]
            self.presenter?.goToChat(chat, delegate: self)
        }
    }

    func addChatTapped() {
        self.presenter?.goToChat(delegate: self)
    }

    func removeChatAt(_ indexPath: IndexPath) {
        if self.chats.count > indexPath.row {
            self.chats.remove(at: indexPath.row)
            self.saveChats()
            if self.chats.isEmpty {
                // Покажем текст, уведомляющий о том, что нет чатов
                self.presenter?.showChats(self.chats)
            }
        }
    }
}

// MARK: - IChatListInteractorDelegate

extension ChatListInteractor: IChatListInteractorDelegate {
    func saveChat(_ chat: Chat) {

        if self.isChatExisted(chat) {
            let indexOfChat = self.chats.firstIndex { (existingChat) -> Bool in
                existingChat.id == chat.id
            }
            guard let index = indexOfChat else {
                return
            }
                if index == 0 {
                    // Чат и так был первый, не надо ничего с ним делать
                    self.saveChats()
                    return
                }
                let chat = self.chats.remove(at: index)
                self.presenter?.removeChatFrom(index: index)
                self.insertChatAtFirstPosition(chat)
        } else {
            if self.chats.isEmpty {
                // Если в данный момент чатов нет
                // то надо добавить текущий и убрать с экрана текст,
                // уведомляющий о том
                // что текстов не было
                self.chats.append(chat)
                self.presenter?.showChats(self.chats)
            } else {
                self.insertChatAtFirstPosition(chat)
            }
        }
        self.saveChats()
    }
}

private extension ChatListInteractor {
    func isChatExisted(_ chat: Chat) -> Bool {
        self.chats.contains(where: { (existingChat) -> Bool in
            existingChat.id == chat.id
        })
    }

    func insertChatAtFirstPosition(_ chat: Chat) {
        self.chats.insert(chat, at: 0)
        self.presenter?.appendChat(chat)
    }

    func saveChats() {
        JsonLoader.saveJSON(chats: self.chats)
    }
}
