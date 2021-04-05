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

    // MARK: - Constants

    private enum Constants {
//            Кнопка удалить:
//                Заливка: FFFFFF
        static let deleteButtonColor = UIColor(rgb: 0xFFFFFF)
        static let messageBackgroundColor = UIColor(rgb: 0x000000).cgColor
        static let messageCornerRadius: CGFloat = 8
    }

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
        deleteAction.image?.withTintColor(Constants.deleteButtonColor)
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }

    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {

        let maskLayer = CALayer()
        maskLayer.cornerRadius = Constants.messageCornerRadius
        maskLayer.backgroundColor = Constants.messageBackgroundColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x,
                                 y: cell.bounds.origin.y,
                                 width: cell.bounds.width,
                                 height: cell.bounds.height).insetBy(dx: 0, dy: AppConstants.Constraints.quarter)
        cell.layer.mask = maskLayer
    }

}
