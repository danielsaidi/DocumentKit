# Getting Started

This article explains how to get started with DocumentKit.


## Overview

DocumentKit is a Swift library that adds more capabilities to `DocumentGroup`-based iOS apps.

Document-based SwiftUI apps return a `DocumentGroup` scene, into which you can load your own custom views to edit various document types. It's an easy and very powerful way to create apps that can edit documents and store them on the user's device and in the cloud.

However, document apps are currently very limited when it comes to customizations. For instance, you can't add custom toolbar items to the document browser, and since a `DocumentGroup` (unlike regular SwiftUI apps) doesn't have a view until you open a document, you can't present initial onboarding screens or modals from the document browser.  

DocumentKit aims to solve these problems.



## Presenting modal sheets and full screen covers

DocumentKit has a `DocumentGroupModal` protocol, that lets you present any SwiftUI view as a modal from any `DocumentGroup`. 

All you have to do is to add the protocol to your view:

```swift
struct MyModalView: DocumentGroupModal {

    var body: some View {
        Text("Hello, modal!")
    }
}
```

You can now present the view as a sheet, full screen cover, or using any UIKit presentation style:

```swift
MyModalView()
    .presentAsDocumentGroupSheet()
    // .presentAsDocumentGroupFullScreenCover()
    // .presentAsDocumentGroupModal(.overCurrentContext)
```

This means that any SwiftUI view can be easily presented as a modal over any `DocumentGroup`.



## Presenting an initial app onboarding

We can now use the `DocumentGroupModal` to easily open an app onboarding when a `DocumentGroup`-based app starts.

All you have to do is to add an `onboardingSheet` or `onboardingFullScreenCover` to the `DocumentGroup`:

```swift
@main
struct MyApp: App {

    var body: some Scene {
        DocumentGroup(newDocument: MyDocument()) { file in
            ContentView(document: file.$document)
        }.onboardingSheet {
            MyModalView()
        }
    }
}
```

This will present the onboarding screen *once*, after which it will not be shown again.

If you want to present different onboarding experiences, you can provide a custom `id` for each onboarding. You can also provide a custom delay and your own `UserDefaults` store.

If you want to programmatically get and set the presentation state of a certain onboarding, you can use the `documentGroupOnboardingState(...)`, `resetDocumentGroupOnboardingState(...)` and `setDocumentGroupOnboardingState(...)` `UserDefaults` extensions.
