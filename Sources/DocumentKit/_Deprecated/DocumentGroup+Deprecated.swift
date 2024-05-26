import SwiftUI

@MainActor
public extension DocumentGroup {

    @available(*, deprecated, renamed: "tryCustomizeDocumentBrowser(delay:_:)")
    func tryCustomizeBrowser(
        delay: TimeInterval = .defaultDocumentModalDelay,
        _ action: @escaping DocumentGroupCustomization
    ) -> DocumentGroup {
        tryCustomizeDocumentBrowser(delay: delay, action)
    }

    @available(*, deprecated, renamed: "onboardingModal")
    func onboardingSheet<Contents: DocumentGroupModal>(
        id: String,
        store: UserDefaults? = nil,
        delay: TimeInterval? = .defaultDocumentModalDelay,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        onboardingModal(
            id: id,
            type: .sheet,
            store: store,
            delay: delay,
            content: content
        )
    }

    @available(*, deprecated, renamed: "onboardingModal")
    func onboardingFullScreenCover<Contents: DocumentGroupModal>(
        id: String,
        store: UserDefaults? = nil,
        delay: TimeInterval? = .defaultDocumentModalDelay,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        onboardingModal(
            id: id,
            type: .fullScreenCover,
            store: store,
            delay: delay,
            content: content
        )
    }

    @available(*, deprecated, renamed: "splashScreen")
    func splashScreenSheet<Contents: DocumentGroupModal>(
        id: String? = nil,
        store: UserDefaults? = nil,
        delay: TimeInterval? = .defaultDocumentModalDelay,
        dismissAfter: TimeInterval? = .defaultDocumentModalDelay + 1,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        modal(
            type: .sheet,
            delay: delay,
            dismissAfter: dismissAfter,
            content: content
        )
    }

    @available(*, deprecated, renamed: "splashScreen")
    func splashScreenFullScreenCover<Contents: DocumentGroupModal>(
        id: String? = nil,
        store: UserDefaults? = nil,
        delay: TimeInterval? = .defaultDocumentModalDelay,
        dismissAfter: TimeInterval? = .defaultDocumentModalDelay + 1,
        @ViewBuilder content: @escaping () -> Contents
    ) -> DocumentGroup {
        modal(
            type: .fullScreenCover,
            delay: delay,
            dismissAfter: dismissAfter,
            content: content
        )
    }
}
