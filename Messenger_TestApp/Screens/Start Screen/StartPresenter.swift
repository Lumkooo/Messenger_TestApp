//
//  StartPresenter.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/3/21.
//

import Foundation


protocol IStartPresenter {
    func viewDidLoad(ui: IStartView)
    func viewDidAppear()
}

final class StartPresenter {

    // MARK: - Properties

    private let interactor: IStartInteractor
    private let router: IStartRouter
    private weak var ui: IStartView?

    // MARK: - Init

    init(interactor: IStartInteractor, router: IStartRouter) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - IStartPresenter

extension StartPresenter: IStartPresenter {
    func viewDidLoad(ui: IStartView) {
        self.ui = ui
        self.ui?.loginButtonTapped = { [weak self] in
            self?.router.goToChatListVC()
        }
    }

    func viewDidAppear() {
        self.ui?.viewDidAppear()
    }
}

// MARK: - IStartInteractorOuter

extension StartPresenter: IStartInteractorOuter {

}
