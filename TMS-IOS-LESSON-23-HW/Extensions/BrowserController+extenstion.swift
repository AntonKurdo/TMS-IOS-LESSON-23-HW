import WebKit

extension BrowserController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}

extension BrowserController: SearchBarDelegate {
    func didBookmarkTapped(url: String) {
        BookmarksModel.shared.add(url: url, vc: self)
    }
    
    func didSearchTapped(searchString: String) {
        guard verifyUrl(urlString: searchString) != false else {
            showAlert(title: "Error", message: "Incorrect URL", vc: self, successAction: nil)
            return
        }
        webView.load(URLRequest(url: URL(string: searchString)!))
    }
}
