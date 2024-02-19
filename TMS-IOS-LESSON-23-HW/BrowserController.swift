import UIKit
import WebKit

class BrowserController: UIViewController {
    
    struct Constants {
        static let defaultUrl = "https://www.google.com"
    }
    
    let webView = WKWebView()
    let searchBar = SearchBar()
    let bottomToolbar = UIToolbar()
    
    let backButton = UIBarButtonItem(systemItem: .rewind)
    let forwardButton = UIBarButtonItem(systemItem: .fastForward)
    let spacer = UIBarButtonItem(systemItem: .flexibleSpace)
    let reloadButton = UIBarButtonItem(systemItem: .refresh)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        searchBar.delegate = self
        
        setupSearchBar()
        setupBottomToolbar()
        setupWebView()
        NotificationCenter.default
            .addObserver(self, selector:#selector(didBookmarkTaped), name: NSNotification.Name ("bookmark_taped"), object: nil)
    }
    
    deinit {
        NotificationCenter.default
            .removeObserver(self, name: NSNotification.Name("bookmark_taped"), object: nil)
    }
    
    @objc func didBookmarkTaped(_ notification: Notification) {
        
        let userInfo = notification.userInfo as? [String: Any] ?? [:]
        
        if let url = userInfo.values.first {
            webView.load(URLRequest(url: URL(string: url as! String)!))
        }
    }
    
    private func setupSearchBar() {
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 60),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        let url = URL(string: Constants.defaultUrl)!
        searchBar.searchTextField.text = Constants.defaultUrl
        
        webView.load(URLRequest(url: url))
        
        webView.navigationDelegate = self
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomToolbar.topAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func setupBottomToolbar() {
        view.addSubview(bottomToolbar)
        
        bottomToolbar.items = [backButton, forwardButton, spacer, reloadButton]
        
        bottomToolbar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomToolbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            bottomToolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomToolbar.leftAnchor.constraint(equalTo: view.leftAnchor),
            bottomToolbar.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        backButton.action = #selector(backAction)
        forwardButton.action = #selector(forwardAction)
        reloadButton.action = #selector(reloadAction)
    }
    
    
    @objc private func backAction() {
        guard webView.canGoBack else {return}
        webView.goBack()
    }
    
    @objc private func forwardAction() {
        guard webView.canGoForward else {return}
        webView.goForward()
    }
    
    @objc private func reloadAction() {
        webView.reload()
    }
}


