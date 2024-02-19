import UIKit

class BookmarksModel {
    var bookmarks: [String] = []
    
    static var shared: BookmarksModel = {
        let instance = BookmarksModel()
        return instance
    }()

    private init() {}
    
    func add(url: String, vc: UIViewController) {
        if(bookmarks.contains(url)) {
            showAlert(title: "Error", message: "This url - \(url) - has been already added", vc: vc, successAction: nil)
        } else {
            bookmarks.append(url)
        }
    }
}
