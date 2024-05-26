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
}

public extension DocumentGroupModal {

    
}
