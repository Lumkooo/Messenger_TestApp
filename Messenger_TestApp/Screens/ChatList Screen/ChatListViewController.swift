//
//  ChatListViewController.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import UIKit

final class ChatListViewController: UIViewController {

    // MARK: - Properties

    private let presenter: IChatListPresenter
    private let ui = ChatListView()

    // MARK: - Init

    init(presenter: IChatListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        let chats = NSLocalizedString("chats", comment: "")
        self.title = chats
        self.setupAddButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - VC life cycle

    override func loadView() {
        super.loadView()
        self.view = self.ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad(ui: self.ui)

    }

    // MARK: - Добавление

    private func setupAddButton() {
        let add = UIBarButtonItem(barButtonSystemItem: .add,
                                  target: self,
                                  action: #selector(addTapped))
        self.navigationItem.setRightBarButton(add, animated: true)
    }

    @objc private func addTapped() {
        self.presenter.goToChat()
    }
}
