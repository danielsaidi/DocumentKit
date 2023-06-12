# ``DocumentKit``

DocumentKit adds more capabilities to `DocumentGroup`-based iOS apps.


## Overview

![Library logotype](Logo.png)

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

The <doc:Getting-Started> article has a guide to help you get started with RichTextKit.



## Repository

For more information, source code, an if you want to report issues, sponsor the project etc., visit the [project repository](https://github.com/danielsaidi/DocumentKit).



## About this documentation

The online documentation is currently iOS only. To generate documentation for other platforms, open the package in Xcode, select a simulator then run `Product/Build Documentation`.



## License

DocumentKit is available under the MIT license. See the [LICENSE][License] file for more info.



## Topics

### Articles

- <doc:Getting-Started>

### Foundation

- ``DocumentGroupInspector``
- ``DocumentGroupModal``
- ``DocumentGroupToolbarItem``

### Errors

- ``DocumentGroupError``
