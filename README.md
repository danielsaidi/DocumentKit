<p align="center">
    <img src ="Resources/Logo_GitHub.png" alt="DocumentKit Logo" title="DocumentKit" width=600 />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/DocumentKit?color=%2300550&sort=semver" alt="Version" title="Version" />
    <img src="https://img.shields.io/badge/swift-5.7-orange.svg" alt="Swift 5.7" title="Swift 5.7" />
    <img src="https://img.shields.io/github/license/danielsaidi/DocumentKit" alt="MIT License" title="MIT License" />
    <a href="https://twitter.com/danielsaidi">
        <img src="https://img.shields.io/twitter/url?label=Twitter&style=social&url=https%3A%2F%2Ftwitter.com%2Fdanielsaidi" alt="Twitter: @danielsaidi" title="Twitter: @danielsaidi" />
    </a>
    <a href="https://mastodon.social/@danielsaidi">
        <img src="https://img.shields.io/mastodon/follow/000253346?label=mastodon&style=social" alt="Mastodon: @danielsaidi@mastodon.social" title="Mastodon: @danielsaidi@mastodon.social" />
    </a>
</p>



## About DocumentKit

DocumentKit adds more capabilities to `DocumentGroup`-based iOS apps.

Unlike regular SwiftUI apps, document-based apps have a `DocumentGroup` root scene, into which you can load a custom document view. It's a powerful way for apps to edit documents and store them on device and in the cloud. 

However, document apps are currently very limited when it comes to customizations. For instance, you can't add custom toolbar items to the document browser, and since a `DocumentGroup` doesn't have a view until you open a document, you can't present initial onboarding screens or modals from it. 

DocumentKit lets you do all these things, to let you create a better app experience for your document-based apps.

DocumentKit supports `iOS 14` and later.



## Installation

DocumentKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/DocumentKit.git
```

If you prefer to not have external dependencies, you can also just copy the source code into your app.



## Getting started

The [online documentation][Documentation] has a [getting started][Getting-Started] guide to help you get started with DocumentKit.

DocumentKit extends `DocumentGroup` with more view modifiers, to let you add custom toolbar items, customize the document browser etc.:

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
        .showFileExtensions(true)
    }
}
```

DocumentKit also extends `DocumentGroup` with a modifier that lets you present an onboarding screen when the app starts for the first time:

```swift
@main
struct DemoApp: App {

    var body: some Scene {
        DocumentGroup(newDocument: DemoDocument()) { file in
            ContentView(document: file.$document)
        }
        .onboardingSheet {
            MyOnboardingScreen()
        }
    }
}

struct MyOnboardingScreen: DocumentGroupModal {

    var body: some View {
        Text("Hello, onboarding!")
    }
}
```

Additionally, DocumentKit extends `DocumentGroup` with a modifier that lets you present a splash screen each time the app runs - both with a configurable option to stop presenting it and options to configure when it is presented (delay) and when it is automatically dissmissed (dismiss):

```swift
@main
struct DemoApp: App {

    var body: some Scene {
        DocumentGroup(newDocument: DemoDocument()) { file in
            ContentView(document: file.$document)
        }
        .splashScreenSheet(delay: 0.5, dismiss: 3) {
            MySplashScreen()
        }
    }
}

struct MySplashScreen: DocumentGroupModal {

    var body: some View {
        Text("Hello, Splishy Splash screen!")
    }
}
```
 
DocumentKit also lets the `DocumentGroup` present any `DocumentGroupModal` as a sheet, a full screen cover, or using any UIKit-specific modal presentation type.

For more information, please see the [online documentation][Documentation] and [getting started guide][Getting-Started] guide. 



## Documentation

The [online documentation][Documentation] contains more information, code examples, etc., and makes it easy to overview the various parts of the library.



## Demo Application

The demo app lets you explore the library. To try it out, just open and run the `Demo` project.



## Support this library

I manage my various open-source projects in my free time and am really thankful for any help I can get from the community. 

You can sponsor this project on [GitHub Sponsors][Sponsors] or get in touch for paid support.



## Contact

Feel free to reach out if you have questions or if you want to contribute in any way:

* Website: [danielsaidi.com][Website]
* Mastodon: [@danielsaidi@mastodon.social][Mastodon]
* Twitter: [@danielsaidi][Twitter]
* E-mail: [daniel.saidi@gmail.com][Email]



## License

DocumentKit is available under the MIT license. See the [LICENSE][License] file for more info.



[Email]: mailto:daniel.saidi@gmail.com
[Website]: https://www.danielsaidi.com
[Twitter]: https://www.twitter.com/danielsaidi
[Mastodon]: https://mastodon.social/@danielsaidi
[Sponsors]: https://github.com/sponsors/danielsaidi

[Documentation]: https://danielsaidi.github.io/DocumentKit/documentation/documentkit/
[Getting-Started]: https://danielsaidi.github.io/DocumentKit/documentation/documentkit/getting-started
[License]: https://github.com/danielsaidi/DocumentKit/blob/master/LICENSE
