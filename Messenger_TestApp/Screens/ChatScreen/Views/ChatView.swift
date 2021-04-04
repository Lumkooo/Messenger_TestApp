//
//  ChatView.swift
//  Messenger_Test
//
//  Created by Андрей Шамин on 4/4/21.
//

import UIKit

protocol IChatView: AnyObject {

}

final class ChatView: UIView {
    
    // MARK: - Views
    
    
    
    // MARK: - Properties
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        self.setupElements()
        self.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - IChatView

extension ChatView: IChatView {

}

// MARK: - UISetup

private extension ChatView {
    func setupElements() {
        
    }
}
