import UIKit
extension BookmarksController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = bookmarks[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.tabBarController?.selectedIndex = 0
        NotificationCenter.default
            .post(name: NSNotification.Name("bookmark_taped"),
                  object: nil, userInfo: ["url": bookmarks[indexPath.row]])
    }
}
