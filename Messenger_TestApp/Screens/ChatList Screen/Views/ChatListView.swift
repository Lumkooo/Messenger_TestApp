//
//  ChatListView.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import UIKit

protocol IChatListView: AnyObject {
    var didSelectCellAt: ((IndexPath) -> Void)? { get set }
    var removeRowAt: ((IndexPath) -> Void)? { get set }

    func showChats(_ chats: [Chat])
    func appendChat(_ chat: Chat)
    func removeChatFrom(_ index: Int)
}

final class ChatListView: UIView {

    // MARK: - Constants

    private enum Constants {
//        Заливка: FFFFFF
        static let backgroundColor = UIColor(rgb: 0xFFFFFF)
    }

    // MARK: - Views

    private lazy var emptyChatLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "На данный момент чаты отсутствуют.\nМожете создать новый, нажав на \" + \" в правом верхнем углу "
        myLabel.font = .systemFont(ofSize: 18, weight: .bold)
        myLabel.textAlignment = .center
        myLabel.numberOfLines = 0
        return myLabel
    }()

    private lazy var tableView: UITableView = {
        let myTableView = UITableView()
        myTableView.register(ChatListTableViewCell.self,
                             forCellReuseIdentifier: ChatListTableViewCell.reuseIdentifier)
        myTableView.separatorColor = .clear
        return myTableView
    }()

    // MARK: - Properties

    private let chatListTableViewDataSource = ChatListTableViewDataSource()
    private var chatListTableViewDelegate: ChatListTableViewDelegate?
    var didSelectCellAt: ((IndexPath) -> Void)?
    var removeRowAt: ((IndexPath) -> Void)?

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.backgroundColor = Constants.backgroundColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - IChatListView

extension ChatListView: IChatListView {
    func showChats(_ chats: [Chat]) {
        if chats.isEmpty {
            self.tableView.removeFromSuperview()
            self.setupEmtpyChatsLabel()
        } else {
            self.emptyChatLabel.removeFromSuperview()
            self.setupTableView()
            self.chatListTableViewDataSource.setData(chats: chats)
            self.tableView.reloadData()
        }
    }

    func appendChat(_ chat: Chat) {
        // Вставка происходит в начало списка, поэтому row = 0
        let indexPath = IndexPath(row: 0, section: 0)
        self.chatListTableViewDataSource.insertMessage(chat)
        self.tableView.insertRows(at: [indexPath], with: .left)
    }

    func removeChatFrom(_ index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        self.chatListTableViewDataSource.removeMessageAt(indexPath)
        self.tableView.deleteRows(at: [indexPath], with: .left)
    }
}

// MARK: - UISetup

private extension ChatListView {
    func setupEmtpyChatsLabel() {
        self.addSubview(self.emptyChatLabel)
        self.emptyChatLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.emptyChatLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.emptyChatLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                         constant: AppConstants.Constraints.normal),
            self.emptyChatLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                         constant: -AppConstants.Constraints.normal),
        ])
    }

    func setupTableView() {
        self.chatListTableViewDelegate = ChatListTableViewDelegate(delegate: self)
        self.tableView.dataSource = self.chatListTableViewDataSource
        self.tableView.delegate = self.chatListTableViewDelegate

        self.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension ChatListView: IChatListTableViewDelegate {
    func didSelectRowAt(indexPath: IndexPath) {
        self.didSelectCellAt?(indexPath)
        self.tableView.deselectRow(at: indexPath,
                                   animated: true)
    }

    func removeRowAt(at indexPath: IndexPath) {
        self.removeRowAt?(indexPath)
        self.chatListTableViewDataSource.removeMessageAt(indexPath)
    }
}
