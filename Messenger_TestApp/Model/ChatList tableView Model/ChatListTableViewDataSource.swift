//
//  ChatListTableViewDataSource.swift
//  Messenger_TestApp
//
//  Created by Андрей Шамин on 4/5/21.
//

import UIKit

final class ChatListTableViewDataSource: NSObject {

    // MARK: Properties

    private(set) var chats: [Chat] = []

    // MARK: - Методы для работы с чатами

    func setData(chats: [Chat]) {
        self.chats = chats
    }

    func insertMessage( _ chat: Chat) {
        self.chats.insert(chat, at: 0)
    }

    func removeMessageAt(_ indexPath: IndexPath) {
        if self.chats.count > indexPath.row {
            self.chats.remove(at: indexPath.row)
        }
    }
}

extension ChatListTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.chats.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ChatListTableViewCell.reuseIdentifier,
                for: indexPath) as? ChatListTableViewCell else {
            assertionFailure("oops, error...")
            return UITableViewCell()
        }
        cell.setupCell(messages: self.chats[indexPath.row].messages)
        return cell
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.chats.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

