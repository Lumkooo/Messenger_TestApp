//
//  NavigationControllerAssembly.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/3/21.
//

import UIKit

enum NavigationControllerAssembly {
    static func createNavigationController(rootViewController: UIViewController) -> UINavigationController {

        let navigationController = UINavigationController(rootViewController: rootViewController)

        return navigationController
    }
}
