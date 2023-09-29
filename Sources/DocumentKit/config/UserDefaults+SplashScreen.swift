import Foundation

public extension UserDefaults {

    /**
     The default storage key for a document group splash screen.
     */
    var defaultDocumentGroupSplashScreenId: String {
        "com.documentkit.isSplashScreenPresented"
    }

    /**
     Get the state of a certain document group splash screen.
     */
    func documentGroupSplashScreenState(
        for id: String? = nil
    ) -> Bool {
        bool(forKey: id ?? defaultDocumentGroupSplashScreenId)
    }

    /**
     Reset the state of a certain document group splash screen.
     */
    func resetDocumentGroupSplashScreenState(
        for id: String? = nil
    ) {
        setDocumentGroupSplashScreenState(to: false, for: id)
    }

    /**
     Set the state of a certain document group splash screen.
     */
    func setDocumentGroupSplashScreenState(
        to value: Bool,
        for id: String? = nil
    ) {
        set(value, forKey: id ?? defaultDocumentGroupSplashScreenId)
    }
}