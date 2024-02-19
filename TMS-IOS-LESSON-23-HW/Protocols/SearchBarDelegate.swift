protocol SearchBarDelegate: AnyObject {
    func didSearchTapped(searchString: String)
    func didBookmarkTapped(url: String)
}
