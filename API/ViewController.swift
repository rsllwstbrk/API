//
//  ViewController.swift
//  API
//
//  Created by Rsllwstbrk on 23.01.24.
//

import UIKit

struct Comments: Codable {
    let postID, id: Int
    let name, email, body: String

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case id, name, email, body
    }
}

struct Posts: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}


struct Company: Codable {
    
    let name: String
    let catchPhrase: String
    let bs: String
    
}

struct Geo: Codable {
    
    let lat: String
    let lng: String
    
}

struct Address: Codable {
    
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
    
}

struct Users: Codable {
    
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    
}





class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = comments[indexPath.row]
        cell.textLabel?.text = "\(item.postID), \(item.id), \(item.name), \(item.email), \(item.body)"
        cell.textLabel?.numberOfLines = 0
        return cell
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    

    let tableView: UITableView = {
            let table = UITableView()
            table.translatesAutoresizingMaskIntoConstraints = false
            return table
        }()
    
    var comments: [Comments] = []
    var postID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Comments"
        
        guard let postID = postID else { return }
        
        loadComments(for: postID)

        func loadComments(for postId: Int) {
            let url = URL(string: "https://jsonplaceholder.typicode.com/comments")!
            
            let urlRequest = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                let comments = try! JSONDecoder().decode([Comments].self, from: data!)
                self.comments = comments
                DispatchQueue.main.async {
                    self.tableView.reloadData()}
                
            } .resume()
        }
       
        
        view.addSubview(tableView)
        tableView.estimatedRowHeight = 100000
        tableView.delegate = self
        tableView.dataSource = self
        NSLayoutConstraint.activate([
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
                
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        
    }

    

}







class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = posts[indexPath.row]
        cell.textLabel?.text = "\(item.userID), \(item.id), \(item.title), \(item.body)"
        cell.textLabel?.numberOfLines = 0
        return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPost = posts[indexPath.row]
        let commentsVC = CommentsViewController()
        present(commentsVC, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    

    let tableView: UITableView = {
            let table = UITableView()
            table.translatesAutoresizingMaskIntoConstraints = false
            return table
        }()
    
    var posts: [Posts] = []
    var userID: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Posts"

        guard let userID = userID else { return }
        
        loadPosts(for: userID)
        
        func loadPosts(for userId: Int) {
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
            
            let urlRequest = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                
                let posts = try! JSONDecoder().decode([Posts].self, from: data!)
                self.posts = posts
                DispatchQueue.main.async {
                    self.tableView.reloadData()}
                
            } .resume()
        }
       
        
        view.addSubview(tableView)
        tableView.estimatedRowHeight = 1000
        tableView.delegate = self
        tableView.dataSource = self
        NSLayoutConstraint.activate([
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
                
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        
    }

    

}







class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
        }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = users[indexPath.row]
        cell.textLabel?.text = "\(item.id), \(item.name), \(item.username), \(item.email), \(item.address), \(item.phone), \(item.website), \(item.company)"
        cell.textLabel?.numberOfLines = 0
        return cell
        }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = users[indexPath.row]
        let postsVC = PostsViewController()
        present(postsVC, animated: true, completion: nil)
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
    

        

    let tableView: UITableView = {
            let table = UITableView()
            table.translatesAutoresizingMaskIntoConstraints = false
            return table
        }()
    
    var users: [Users] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        navigationItem.title = "Users"
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
        let users = try! JSONDecoder().decode([Users].self, from: data!)
            self.users = users
            DispatchQueue.main.async {
                self.tableView.reloadData()}

        } .resume()
        
       
        
        view.addSubview(tableView)
        tableView.estimatedRowHeight = 1000
        tableView.delegate = self
        tableView.dataSource = self
        NSLayoutConstraint.activate([
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
                
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        
    }

    

}

