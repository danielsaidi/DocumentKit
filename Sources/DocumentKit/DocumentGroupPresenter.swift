//
//  DocumentGroupPresenter.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This protocol can be implemented by any SwiftUI `View` that
 can use the underlying native views of a `DocumentGroup` to
 present and dismiss documents and views.
 */
public protocol DocumentGroupPresenter {}

public extension DocumentGroupPresenter {

    /**
     Get the current key window's root view controller.
     */
    var rootViewController: UIViewController? {
        keyWindow?.rootViewController
    }

    /**
     Dismiss the currently opened document, if any.
     */
    func dismissCurrentDocument(
        completion: @escaping () -> Void = {}
    ) {
        rootViewController?.dismiss(
            animated: true,
            completion: completion
        )
    }
}

/**
 This enum defines errors that can be thrown when handling a
 ``DocumentGroupPresenter``.
 */
public enum DocumentGroupPresenterError: Error, Equatable {

    /// There was no requires parent window.
    case noParentWindow
}

private extension DocumentGroupPresenter {

    var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .filter { $0.isKeyWindow }
            .first
    }
}
