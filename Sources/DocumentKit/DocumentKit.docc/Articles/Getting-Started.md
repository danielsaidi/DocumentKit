# Getting Started

This article explains how to get started with DocumentKit.


## Overview

DocumentKit is a Swift library that adds more capabilities to `DocumentGroup`-based iOS apps.

Document-based SwiftUI apps use a `DocumentGroup` scene, into which you can load custom views to edit various document types. It's an easy and powerful way to create apps that can edit documents and store them on the user's device and in the cloud.

However, document apps are currently very limited when it comes to customizations. 

For instance, you can't add custom toolbar items to the document browser, and since a `DocumentGroup` (unlike regular SwiftUI apps) doesn't have a view until you open a document, you can't present initial onboarding screens or modals from the document browser.  

DocumentKit aims to solve these problems.



## How to inspect the document group

DocumentKit has a ``DocumentGroupInspector`` protocol, that lets you inspect the current document group.

All you have to do is to add the protocol to any type, to let it access the underlying document browser:

```swift
struct MyView: View, DocumentGroupInspector {

    var body: some View {
        Text("Hello, modal!")
    }
    
    var allowsDocumentCreation: Bool {
        documentBrowser?.allowsDocumentCreation ?? false
    }
}
```

You can also use the protocol to dismiss the currently presented document:

```swift
struct MyButton: View, DocumentGroupInspector {

    var body: some View {
        Button("Dismiss", action: dismissCurrentDocument)
    }
}
```

> Important: Note that the `DocumentGroup` must have been presented for this to work. The internal functionality adds a security delay whenever needed, to ensure that the browser is available.



## How to present modal screens

DocumentKit has a ``DocumentGroupModal`` protocol, that lets you present any SwiftUI view as a modal from any `DocumentGroup`. 

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



## How to present an initial onboarding screen

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



## How to customize the document browser

DocumentKit adds `DocumentGroup` extensions to let you modify the underlying document browser.

For instance, you can add additional bar button items, configure some predefined properties and use `tryCustomizeBrowser` to perform any customization you want:

```swift
@main
struct MyApp: App {

    var body: some Scene {
        DocumentGroup(newDocument: DemoDocument()) { file in
            ContentView(document: file.$document)
        }
        .onboardingSheet {
            MyModalView()
        }
        .additionalNavigationBarButtonItems(
            leading: [...],
            trailing: [...]
        )
        .allowsDocumentCreation(true)
        .allowsPickingMultipleItems(true)
        .showFileExtensions(true)
        .tryCustomizeBrowser { $0.allowsDocumentCreation = false }
    }
}
```

Since `tryCustomizeBrowser` is not as nice as using the other extensions, more extensions may be added in the future.  
