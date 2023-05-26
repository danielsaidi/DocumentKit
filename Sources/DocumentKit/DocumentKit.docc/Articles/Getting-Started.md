# Getting Started

This article explains how to get started with DocumentKit.


## Overview

DocumentKit is a Swift library that adds more capabilities to `DocumentGroup`-based iOS apps.

A document-based SwiftUI app returns a `DocumentGroup` scene from its body property, which you can customize to load various document types into your own custom views. It's an easy and powerful way to create apps that can be used to edit documents that can be stored on the user's device and in the cloud.

However, `DocumentGroup`-based apps are currently very limited when it comes to customizations. For instance, you can't add custom toolbar items to the document browser. Also, since a `DocumentGroup`-based app (unlike regular SwiftUI apps) doesn't have a view until you open a document, you can't present initial onboarding screens or modals from the document browser.  

DocumentKit aims to solve these problems.



## Presenting modal sheets and full screen covers

DocumentKit has a `DocumentGroupModal` protocol, that lets us present modal sheets and full screen covers from any `DocumentGroup`. 

All you have to do is to add this protocol to your SwiftUI view:

```swift
struct MyModalView: DocumentGroupModal {

    var body: some View {
        Text("Hello, modal!")
    }
}
```

You can now present the view as a sheet, full screen cover, or using any UIKit-specific presentation style:

```swift
@main
struct MyApp: App {

    init() {
        MyModalView()
            .presentAsDocumentGroupSheet()
            // .presentAsDocumentGroupFullScreenCover()
            // .presentAsDocumentGroupModal(.overCurrentContext)
    }

    var body: some Scene {
        DocumentGroup(newDocument: DemoDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
```

This means that any SwiftUI view can be easily presented as a modal over any `DocumentGroup`. 



## Presenting an initial app onboarding

The `DocumentGroupModal` protocol gives us a lot of flexibility.

We can use the capabilities it brings, to easily open an app onboarding when a `DocumentGroup`-based app starts.

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

If you want to present different onboarding experiences, you can provide a custom `id` for each onboarding. You can also provide your own `UserDefaults` store use the `documentGroupOnboardingState(...)`, `resetDocumentGroupOnboardingState(...)` and `setDocumentGroupOnboardingState(...)` `UserDefaults` extensions to get and set the state of a certain onboarding.
