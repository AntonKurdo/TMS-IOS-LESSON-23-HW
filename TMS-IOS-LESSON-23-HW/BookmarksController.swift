import UIKit

class BookmarksController: UIViewController {
    
    var bookmarks: [String] = []
    
    let table = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTable()

        navigationItem.title = "Bookmarks"
    }
    
    private func updateTable() {
        bookmarks = BookmarksModel.shared.bookmarks
        table.reloadData()
    }
    
    private func setupTable() {
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        
        
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            table.leftAnchor.constraint(equalTo: view.leftAnchor),
            table.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}
