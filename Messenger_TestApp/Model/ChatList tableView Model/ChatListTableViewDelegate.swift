//
//  ChatListTableViewDelegate.swift
//  Messenger_TestApp
//
//  Created by Андрей Шамин on 4/5/21.
//

import UIKit

protocol IChatListTableViewDelegate {
    func didSelectRowAt(indexPath: IndexPath)
    func removeRowAt(at indexPath: IndexPath)
}

final class ChatListTableViewDelegate: NSObject {

    // MARK: - Properties

    private let delegate: IChatListTableViewDelegate

    // MARK: - Init

    init(delegate: IChatListTableViewDelegate) {
        self.delegate = delegate
    }
}

// MARK: - UITableViewDelegate

extension ChatListTableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        self.delegate.didSelectRowAt(indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: nil) { (_, _, completionHandler) in
            self.delegate.removeRowAt(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
