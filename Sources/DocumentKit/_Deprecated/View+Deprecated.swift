import SwiftUI

@MainActor
public extension View {

    @available(*, deprecated, renamed: "presentAsDocumentGroupModal(_:)")
    func presentAsDocumentGroupSheet() throws {
        try presentAsDocumentGroupModal(.sheet)
    }

    @available(*, deprecated, renamed: "presentAsDocumentGroupModal(_:)")
    func presentAsDocumentGroupFullScreenCover() throws {
        try presentAsDocumentGroupModal(.fullScreenCover)
    }

    @available(*, deprecated, renamed: "presentAsDocumentGroupModal(_:)")
    func presentAsDocumentGroupPopover() throws {
        try presentAsDocumentGroupModal(.popover)
    }
}
