//
//  UserDefaults+Onboarding.swift
//  DocumentKit
//
//  Created by Daniel Saidi on 2023-05-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension UserDefaults {

    /**
     The default storage key for a document group onboarding.
     */
    var defaultDocumentGroupOnboardingId: String {
        "com.documentkit.isOnboardingPresented"
    }

    /**
     Get the state of a certain document group onboarding.
     */
    func documentGroupOnboardingState(
        for id: String? = nil
    ) -> Bool {
        bool(forKey: id ?? defaultDocumentGroupOnboardingId)
    }

    /**
     Reset the state of a certain document group onboarding.
     */
    func resetDocumentGroupOnboardingState(
        for id: String? = nil
    ) {
        setDocumentGroupOnboardingState(to: false, for: id)
    }

    /**
     Set the state of a certain document group onboarding.
     */
    func setDocumentGroupOnboardingState(
        to value: Bool,
        for id: String? = nil
    ) {
        set(value, forKey: id ?? defaultDocumentGroupOnboardingId)
    }
}
