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
    func goToChat(delegate: IChatListInteractorDelegate, chatIndex: Int)
    func goToChat(_ chat: Chat, delegate: IChatListInteractorDelegate, chatIndex: Int)
    func removeChatFrom(index: Int)
}

protocol IChatListInteractorDelegate {
    func saveChat(_ chat: Chat, isChatChaged: Bool)
}

final class ChatListInteractor {

    // MARK: - Properties

    weak var presenter: IChatListInteractorOuter?
//    private var chats: [Chat] = []

}

// MARK: - IChatListInteractor

extension ChatListInteractor: IChatListInteractor {
    func loadInitData() {
        let chats = self.getChats()
        self.presenter?.showChats(chats)
    }

    func didSelectCellAt(indexPath: IndexPath) {
        let chats = self.getChats()
        print("TAPPING")
        if chats.count > indexPath.row {
            let chat = chats[indexPath.row]
            print("SHIT!")
            chat.messages.forEach { print("WOW!:", $0.text)}
            self.presenter?.goToChat(chat, delegate: self, chatIndex: indexPath.row)
        }
    }

    func addChatTapped() {
        let chatCount = CoreDataManager.sharedInstance.getChats().count
        self.presenter?.goToChat(delegate: self, chatIndex: chatCount)
    }

    func removeChatAt(_ indexPath: IndexPath) {
        var chats = self.getChats()
        if chats.count > indexPath.row {
            let _ = CoreDataManager.sharedInstance.removeChat(atIndex: indexPath.row)
            chats.remove(at: indexPath.row)
            if chats.isEmpty {
                // Покажем текст, уведомляющий о том, что нет чатов
                self.presenter?.showChats(chats)
            }
        }
    }
}

// MARK: - IChatListInteractorDelegate

extension ChatListInteractor: IChatListInteractorDelegate {
    func saveChat(_ chat: Chat, isChatChaged: Bool) {

        let chats = self.getChats()
        print("CHAT.COUNT!", chats.count)
        if self.isChatExisted(chat) {
            let indexOfChat = chats.firstIndex { (existingChat) -> Bool in
                existingChat.id == chat.id
            }
            guard let index = indexOfChat else {
                return
            }
            if isChatChaged {
                // Чат был изменен
                if index == 0 {
                    // Чат и так был первый, не надо ничего с ним делать
                    return
                }
                guard let chat = CoreDataManager.sharedInstance.removeChat(atIndex: index) else {
                    assertionFailure("oops... Erorr!")
                    return
                }
                print("WTF!")
                self.presenter?.removeChatFrom(index: index)
                self.insertChatAtFirstPosition(chat)
            }
        } else {
            print("WTF!")
            self.insertChatAtFirstPosition(chat)
        }
    }
}

private extension ChatListInteractor {
    func isChatExisted(_ chat: Chat) -> Bool {
        let chats = self.getChats()
        return chats.contains(where: { (existingChat) -> Bool in
            existingChat.id == chat.id
        })
    }

    func insertChatAtFirstPosition(_ chat: Chat) {
        if self.getChats().isEmpty {
            self.createChatAtFirstPosition(chat)
        } else {
            CoreDataManager.sharedInstance.insertChat(chat, atPosition: 0)
            CoreDataManager.sharedInstance.removeChat(atIndex: 2)
            self.presenter?.appendChat(chat)
        }
    }

    func createChatAtFirstPosition(_ chat: Chat) {
        self.presenter?.showChats([chat])
    }

    func getChats() -> [Chat] {
        return CoreDataManager.sharedInstance.getChats()
    }
}
