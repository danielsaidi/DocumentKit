# Getting Started

This article explains how to get started with DocumentKit.



## The basics

DocumentKit extends ``SwiftUI/DocumentGroup`` with modifiers that let you add custom toolbar items, customize the document browser, etc.:

```swift
@main
struct MyApp: App {

    var body: some Scene {
        DocumentGroup(newDocument: DemoDocument()) { file in
            ContentView(document: file.$document)
        }
        .additionalNavigationBarButtonItems(
            leading: [...],
            trailing: [...]
        )
        .allowsDocumentCreation(true)
        .allowsPickingMultipleItems(true)
        .showFileExtensions(true)
        .onboardingSheet {
            MyOnboardingScreen()
        }
        .splashSheet {
            MySplashScreen()
        }
    }
}
```

DocumentKit also extends ``SwiftUI/DocumentGroup`` with view modifiers that let you present onboarding modals and splash screens when the app starts for the first time, as described further down.



## How to inspect the document group

DocumentKit has a ``DocumentGroupInspector`` protocol that can be implemented by any type that should be able to inspect the current document group and its document browser, dismiss the current document, etc.:

```swift
struct MyView: View, DocumentGroupInspector {

    var body: some View {
        Button("Dismiss current document", action: dismissCurrentDocument)
    }
    
    var allowsDocumentCreation: Bool {
        documentBrowser?.allowsDocumentCreation ?? false
    }
}
```

The protocol provides you with the underlying UIKit views, which means that you have access to the full capabilities of the platform.



## How to customize the document browser

DocumentKit has ``SwiftUI/DocumentGroup`` view modifiers that let you add custom toolbar items and modify the wrapped document browser:

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
        .tryCustomizeDocumentBrowser { 
            $0.allowsDocumentCreation = true  // Same as using the modifier above
        }
    }
}
```

You can also use ``SwiftUI/DocumentGroup/tryCustomizeDocumentBrowser(delay:_:)`` to configure the browser in ways that are not supported by the view modifiers that are provided by the SDK.



## How to present modal screens from a document group

DocumentKit has a ``DocumentGroupModal`` protocol that can be used to present any SwiftUI view from any `DocumentGroup`.

```swift
struct MyModalView: DocumentGroupModal {

    var body: some View {
        Text("Hello, modal!")
    }
}
```

Just implement the protocol as above, to get access to a  presentation function that lets you present the view in many different ways:

```swift
MyModalView()
    .presentAsDocumentGroupModal(.sheet)
    // or .presentAsDocumentGroupModal(.fullScreenCover)
    // or .presentAsDocumentGroupModal(.popover)
    // or any native presentation style
```

These capabilities are used to power DocumentKit's onboarding and splash screen capabilities, as described further down.



## How to present an initial onboarding screen

We can use the modal capabilities to open an initial onboarding when a ``SwiftUI/DocumentGroup``-based app is launched for the first time.

You just have to add an ``SwiftUI/DocumentGroup/onboardingModal(id:type:store:delay:dismissAfter:content:)`` modifier to the group, to make it present the onboarding modal when the app launches:

```swift
@main
struct MyApp: App {

    var body: some Scene {
        DocumentGroup(newDocument: MyDocument()) { file in
            ContentView(document: file.$document)
        }
        .onboardingModal(id: "my-onboarding") {
            MyModalView()
        }
    }
}
```

This will present the onboarding id *once*, after which it will never be shown again. You can use the ``Foundation/UserDefaults`` extensions that are provided by DocumentKit, to get and set the presentation state of an onboarding.

This lets you control whether or not the next presentation attempt for a certain onboarding will actually present the content or not.



## How to present a splash screen

We can use the modal capabilities to open an initial onboarding when a ``SwiftUI/DocumentGroup``-based app is launched.

You just have to add an ``SwiftUI/DocumentGroup/splashScreen(if:type:store:delay:dismissAfter:content:)`` modifier to the group, to make it present the splash screen when the app launches:

```swift
@main
struct MyApp: App {

    var body: some Scene {
        DocumentGroup(newDocument: MyDocument()) { file in
            ContentView(document: file.$document)
        }
        .splashScreenSheet {
            MyModalView()
        }
    }
}
```

Unlike the onboarding modifier, this view modifier will present the splash screen at any time. You can use the view builder to return an `EmptyView` whenever you want no splash screen, or use the `if` condition parameter.  
