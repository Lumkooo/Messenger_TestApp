//
//  StartInteractor.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/3/21.
//

import Foundation

protocol IStartInteractor {

}

protocol IStartInteractorOuter: AnyObject {

}

final class StartInteractor {

    weak var presenter: IStartInteractorOuter?

}

// MARK: - IStartInteractor

extension StartInteractor: IStartInteractor {

}
