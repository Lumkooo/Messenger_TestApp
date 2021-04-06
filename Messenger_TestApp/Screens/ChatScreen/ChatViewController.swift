//
//  ChatViewController.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import UIKit

final class ChatViewController: UIViewController {

    // MARK: - Properties

    private let presenter: IChatPresenter
    private let ui = ChatView()

    // MARK: - Init

    init(presenter: IChatPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        let chats = NSLocalizedString("chat", comment: "")
        self.title = chats
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.viewDidAppear()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.presenter.viewDidDissapear()
    }
}
