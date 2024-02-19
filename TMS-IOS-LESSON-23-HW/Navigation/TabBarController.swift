import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .gray
   
        setupTabs()
    }
    
    // MARK: Tab Setup
    private func setupTabs() {
        let browser = self.createNav(with: "Browser", and: UIImage(systemName: "globe"), vc: BrowserController())
        let bookmarks = self.createNav(with: "Bookmarks", and: UIImage(systemName: "bookmark.fill"), vc: BookmarksController())
        
        self.setViewControllers([browser, bookmarks], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image

        return nav
    }
}
