import UIKit


class SearchBar: UIView {
    
    weak var delegate: SearchBarDelegate?
    
    let bookmarButton = {
        let btn = UIButton()
        btn.setTitle("", for: .normal)
        btn.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let searchTextField = {
        let tf = UITextField()
        tf.backgroundColor = .white
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .URL
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.cornerRadius = 4
        tf.font = UIFont.systemFont(ofSize: 18)
        tf.returnKeyType = .search
        return tf
    }()
    
    let searchButton = {
        let btn = UIButton()
        btn.setTitle("Search", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        translatesAutoresizingMaskIntoConstraints = false
        
        setupBookmarkButton()
        setupTextField()
        setupSearchButton()
        
        
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
            searchTextField.text = url as? String
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField() {
        addSubview(searchTextField)
        NSLayoutConstraint.activate([
            searchTextField.leftAnchor.constraint(equalTo: bookmarButton.rightAnchor, constant: 8),
            searchTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.65),
            searchTextField.heightAnchor.constraint(equalToConstant: 35),
            searchTextField.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupSearchButton() {
        addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            searchButton.leftAnchor.constraint(equalTo: searchTextField.rightAnchor, constant: 12),
            searchButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.2),
            searchButton.heightAnchor.constraint(equalToConstant: 35),
            searchButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        let action = UIAction { _ in
            if let searchStr = self.searchTextField.text {
                self.delegate?.didSearchTapped(searchString: searchStr)
            }
        }
        
        searchButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupBookmarkButton() {
        addSubview(bookmarButton)
        
        NSLayoutConstraint.activate([
            bookmarButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            bookmarButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.07),
            bookmarButton.heightAnchor.constraint(equalToConstant: 35),
            bookmarButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        bookmarButton.tintColor = .white
        let action = UIAction { _ in
            if let url = self.searchTextField.text, url.count > 0 {
                self.delegate?.didBookmarkTapped(url: self.searchTextField.text ?? "")
            }
        }
        
        bookmarButton.addAction(action, for: .touchUpInside)
    }
}
