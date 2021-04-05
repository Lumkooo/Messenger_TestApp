//
//  ChatCollectionViewDelegate.swift
//  Messenger_TestApp
//
//  Created by Андрей Шамин on 4/5/21.
//

import UIKit

final class ChatCollectionViewDelegate: NSObject {

}

// MARK: - UICollectionViewDelegate

extension ChatCollectionViewDelegate: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDelegateFlowLayout

extension ChatCollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
        let referenceHeight: CGFloat = 0
        let referenceWidth: CGFloat = collectionView.safeAreaLayoutGuide.layoutFrame.width
            - sectionInset.left
            - sectionInset.right
            - collectionView.contentInset.left
            - collectionView.contentInset.right
        return CGSize(width: referenceWidth, height: referenceHeight)
    }
}
