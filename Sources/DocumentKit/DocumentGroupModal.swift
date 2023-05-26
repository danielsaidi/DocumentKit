//
//  DocumentGroupModal.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This protocol can be implemented by any view, that you have
 to be able to open from a document group.
 */
public protocol DocumentGroupModal: View, DocumentGroupPresenter {}

public extension DocumentGroupModal {

    /**
     Present the view as a document group sheet.
     */
    func presentAsDocumentGroupSheet() throws {
        try presentAsDocumentGroupModal()
    }

    /**
     Present the view as a document group full screen cover.
     */
    func presentAsDocumentGroupFullScreenCover() throws {
        try presentAsDocumentGroupModal(.fullScreen)
    }

    /**
     Present the view as a document group modal.
     */
    func presentAsDocumentGroupModal(
        _ presentationStyle: UIModalPresentationStyle = .automatic
    ) throws {
        guard let parent = rootViewController else { throw DocumentGroupPresenterError.noParentWindow }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let controller = UIHostingController(rootView: self)
            controller.modalPresentationStyle = presentationStyle
            parent.present(controller, animated: true, completion: nil)
        }
    }
}
