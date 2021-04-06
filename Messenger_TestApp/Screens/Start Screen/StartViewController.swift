//
//  ViewController.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/3/21.
//

import UIKit

class StartViewController: UIViewController {

    // MARK: - Properties

    private let ui = StartView()
    private let presenter: IStartPresenter

    // MARK: - Init

    init(presenter: IStartPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - VC life cycle

    override func loadView() {
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
}

