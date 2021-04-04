//
//  StartRouter.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/3/21.
//

import UIKit


protocol IStartRouter {
    func goToChatListVC()
}

final class StartRouter {
    weak var vc: UIViewController?
}

// MARK: - IStartRouter

extension StartRouter: IStartRouter {
    func goToChatListVC() {
        let chatListViewController = ChatListVCAssembly.createVC()
        self.vc?.navigationController?.pushViewController(chatListViewController, animated: true)
    }
}
