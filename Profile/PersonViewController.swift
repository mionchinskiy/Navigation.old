

import UIKit

class PersonViewController: UIViewController {
    
    struct Post {
        let author: String
        let description: String
        let image: String
        let likes: Int
        let views: Int
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: -22, left: .zero, bottom: .zero, right: .zero)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        tableView.register(PersonHeaderView.self, forHeaderFooterViewReuseIdentifier: "PersonHeaderView")
        return tableView
    }()
    
    let postsArray: [Post] = {
        var postsArray = [Post]()
        var firstPost = Post(author: "Антон Павлович Чехов",
                             description: "Вот чего видывал",
                             image: "cat1",
                             likes: 7,
                             views: 123)
        let secondPost = Post(author: "Лев Николаевич Толстой - он не Волк Николаевич Толстой",
                              description: "А значит в цирке мог бы выступать",
                              image: "cat2",
                              likes: 3,
                              views: 233)
        let thirdPost = Post(author: "У, Тютчев",
                             description: "Эх тучка, где ты ночевала...",
                             image: "cat3",
                             likes: 8,
                             views: 456)
        let fourthPost = Post(author: "Барт Симпсон",
                              description: "Люблю грозу в начале мая. И покушать люблю тоже. Люблю грозу в начале мая. Всякое люблю. И покушать люблю. Люблю грозу в начале мая. И покушать люблю. Люблю грозу в начале мая. И покушать люблю. Люблю грозу в начале мая. И покушать люблю. Вот бы прямо сейчас. Люблю грозу в начале мая. И покушать люблю. Люблю грозу в начале мая. И покушать люблю. Люблю грозу в начале мая. И покушать люблю. ",
                              image: "cat4",
                              likes: 2,
                              views: 346)
        postsArray.append(firstPost)
        postsArray.append(secondPost)
        postsArray.append(thirdPost)
        postsArray.append(fourthPost)
        return postsArray
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    func layout() {
        view.backgroundColor = .systemGray5
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
    
    
    
    
}

extension PersonViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postsArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        let galleryCell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as! PhotosTableViewCell
        switch indexPath.row {
        case 0 :
            return galleryCell
        default:
            cell.postAuthor.text = postsArray[indexPath.row - 1].author
            cell.postImage.image = UIImage(named: postsArray[indexPath.row - 1].image)
            cell.postDescription.text = postsArray[indexPath.row - 1].description
            cell.postLikes.text = "Likes: \(String(postsArray[indexPath.row - 1].likes))"
            cell.postViews.text = "Views: \(String(postsArray[indexPath.row - 1].views))"
            return cell
        }

    }
    
    
}

extension PersonViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "PersonHeaderView") as! PersonHeaderView
        viewHeader.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: .zero)

        viewHeader.addAllSubviews()
        viewHeader.setupConstraint()

        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let galleryController = PhotosViewController()
            navigationController?.pushViewController(galleryController, animated: true)
        default:
            let _: Int
        }
    }
    
}
