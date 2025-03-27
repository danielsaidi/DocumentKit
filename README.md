<p align="center">
    <img src ="Resources/Logo_Rounded.png" alt="DocumentKit Logo" title="DocumentKit" />
</p>

<p align="center">
    <img src="https://img.shields.io/github/v/release/danielsaidi/DocumentKit?color=%2300550&sort=semver" alt="Version" title="Version" />
    <img src="https://img.shields.io/badge/swift-6.0-orange.svg" alt="Swift 6.0" />
    <img src="https://img.shields.io/badge/platform-SwiftUI-blue.svg" alt="Swift UI" title="Swift UI" />
    <img src="https://img.shields.io/github/license/danielsaidi/DocumentKit" alt="MIT License" title="MIT License" />
</p>


# DocumentKit

DocumentKit is a SwiftUI SDK that adds more capabilities to `DocumentGroup`-based apps and lets you create better user experiences around your `DocumentGroup`-based apps.



## ‼️ Important Information

iOS 18 changed how `DocumentGroup` looks and behaves, by completely changing the underlying types. You can now do a lot more things than before, which makes this SDK less useful. 

While this version fixes a few things, and for instance makes the modal screens work, the `UIDocumentBrowserViewController` customizations no longer work, since the `DocumentGroup` uses a new underlying type.

Since you can now do more with the native `DocumentGroup`, this verison will remain as is until iOS 19 is released, then removed...unless anyone comes up with another way to use it in iOS 18.


## Installation

DocumentKit can be installed with the Swift Package Manager:

```
https://github.com/danielsaidi/DocumentKit.git
```


## Documentation

The online [documentation][Documentation] has more information, articles, code examples, etc.


## Contact

Feel free to reach out if you have questions or want to contribute in any way:

* Website: [danielsaidi.com][Website]
* E-mail: [daniel.saidi@gmail.com][Email]
* Bluesky: [@danielsaidi@bsky.social][Bluesky]
* Mastodon: [@danielsaidi@mastodon.social][Mastodon]


## License

DocumentKit is available under the MIT license. See the [LICENSE][License] file for more info.


[Email]: mailto:daniel.saidi@gmail.com

[Website]: https://danielsaidi.com
[GitHub]: https://github.com/danielsaidi
[Bluesky]: https://bsky.app/profile/danielsaidi.bsky.social
[Twitter]: https://twitter.com/danielsaidi
[Mastodon]: https://mastodon.social/@danielsaidi
[Sponsors]: https://github.com/sponsors/danielsaidi

[Documentation]: https://danielsaidi.github.io/DocumentKit
[Getting-Started]: https://danielsaidi.github.io/DocumentKit/documentation/documentkit/getting-started

[License]: https://github.com/danielsaidi/DocumentKit/blob/master/LICENSE
