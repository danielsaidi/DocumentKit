//
//  UserDefaults+DocumentPresentation.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import Foundation

public extension UserDefaults {
    
    /// Get the state of a certain document presentation.
    func documentPresentationState(
        for id: String
    ) -> Bool {
        bool(forKey: id)
    }

    /// Reset the state of a certain document presentation.
    func resetDocumentPresentationState(
        for id: String
    ) {
        setDocumentPresentationState(to: false, for: id)
    }

    /// Set the state of a certain document presentation.
    func setDocumentPresentationState(
        to value: Bool,
        for id: String
    ) {
        set(value, forKey: id)
    }
}
