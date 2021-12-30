# WebView

**WebView** is a lightweight library to present web content in your SwiftUI app with the help of `WebKit`.

## 💻 Installation
### 📦 Swift Package Manager
Using <a href="https://swift.org/package-manager/" rel="nofollow">Swift Package Manager</a>, add it as a Swift Package in Xcode 11.0 or later, `select File > Swift Packages > Add Package Dependency...` and add the repository URL:
```
https://github.com/asielcabrera/WebView.git
```
### ✊ Manual Installation
Download and include the `WebView` folder and files in your codebase.

### 📲 Requirements
- iOS 14+
- Swift 5

## 👉 Import

Import `WebView` into your `View`

```
import WebView
```

## 🛠 How to use

The simplest way to use `WebView` is to call `WebView` with a `URL String`. 
IMPORTANT: `WebView` must be presented inside a `NavigationView`.

```
import SwiftUI
import WebView

struct ContentView: View {
    var body: some View {
        NavigationView {
            WebView(url: "https://example.com", hidesBackButton: true)
        }
    }
}
```

Note: Here we are hiding the **Back button** of the web view by setting `hidesBackButton` to `false` because the `ContentView` is the root view of our app.

## 🧳 Features

In the example below you can see one pushed and two presented `WebView`s. Take a look at the cool ways you may customize the `WebView` style.

```
import SwiftUI
import WebView

struct ContentView: View {
    
    @State var isSheetPresented = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                Divider()
                
                // 1. Push a WebView with a url
                NavigationLink("Push WebView", destination: WebView(url: "https://example.com"))
                
                Button(action: {
                    isSheetPresented.toggle()
                }, label: {
                    Text("Present WebView")
                }).sheet(isPresented: $isSheetPresented, content: {
                    NavigationView {
                        // 2. Present WebView in a modal with hiding the back button
//                        WebView(url: "https://example.com", hidesBackButton: true)
                        
                        // 3. Present a customized WebView in a modal
//                        WebView(url: "https://example.com",
//                                tintColor: .red,
//                                titleColor: .yellow,
//                                backText: Text("Cancel").italic(),
//                                reloadImage: Image(system"figure.wave"),
//                                goForwardImage: Image(system"forward.frame.fill"),
//                                goBackImage: Image(system"backward.frame.fill"))

                        // 4. Present WebView in a modal with a constant title
//                        WebView(url: "https://example.com", title: "WebView")
                        
                        // 5. Present a webview with onNavigationAction and optional: allowedHosts, forbiddenHosts and credential
                        WebView(url: "https://example.com"//,
//                                allowedHosts: ["github", ".com"],
//                                forbiddenHosts: [".org", "google"],
//                                credential: URLCredential(user: "user", password: "password", persistence: .none)
                        ){ (onNavigationAction) in
                            switch onNavigationAction {
                            case .decidePolicy(let webView, let navigationAction, let policy):
                                print("WebView -> \(String(describing: webView.url)) -> decidePolicy navigationAction: \(navigationAction)")
                                switch policy {
                                case .cancel:
                                    print("WebView -> \(String(describing: webView.url)) -> decidePolicy: .cancel")
                                    isSheetPresented = false
                                case .allow:
                                    print("WebView -> \(String(describing: webView.url)) -> decidePolicy: .allow")
                                @unknown default:
                                    print("WebView -> \(String(describing: webView.url)) -> decidePolicy: @unknown default")
                                }
                                
                            case .didRecieveAuthChallenge(let webView, let challenge, let disposition, let credential):
                                print("WebView -> \(String(describing: webView.url)) -> didRecieveAuthChallange challenge: \(challenge.protectionSpace.host)")
                                print("WebView -> \(String(describing: webView.url)) -> didRecieveAuthChallange disposition: \(disposition.rawValue)")
                                if let credential = credential {
                                    print("WebView -> \(String(describing: webView.url)) -> didRecieveAuthChallange credential: \(credential)")
                                }
                                
                            case .didStartProvisionalNavigation(let webView, let navigation):
                                print("WebView -> \(String(describing: webView.url)) -> didStartProvisionalNavigation: \(navigation)")
                            case .didReceiveServerRedirectForProvisionalNavigation(let webView, let navigation):
                                print("WebView -> \(String(describing: webView.url)) -> didReceiveServerRedirectForProvisionalNavigation: \(navigation)")
                            case .didCommit(let webView, let navigation):
                                print("WebView -> \(String(describing: webView.url)) -> didCommit: \(navigation)")
                            case .didFinish(let webView, let navigation):
                                print("WebView -> \(String(describing: webView.url)) -> didFinish: \(navigation)")
                            case .didFailProvisionalNavigation(let webView, let navigation, let error):
                                print("WebView -> \(String(describing: webView.url)) -> didFailProvisionalNavigation: \(navigation)")
                                print("WebView -> \(String(describing: webView.url)) -> didFailProvisionalNavigation: \(error)")
                            case .didFail(let webView, let navigation, let error):
                                print("WebView -> \(String(describing: webView.url)) -> didFail: \(navigation)")
                                print("WebView -> \(String(describing: webView.url)) -> didFail: \(error)")
                            }
                        }
                        
                    }
                })
                Spacer()
            }
            .navigationBarTitle("WebView")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}
```
