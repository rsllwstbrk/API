//
//  ViewController.swift
//  API
//
//  Created by Rsllwstbrk on 23.01.24.
//

import UIKit

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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = users[indexPath.row]
        cell.textLabel?.text = item.name
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
    
    var users: [Users] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
        let users = try! JSONDecoder().decode([Users].self, from: data!)
            self.users = users
            DispatchQueue.main.async {
                self.tableView.reloadData()}

        } .resume()
        
       
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        NSLayoutConstraint.activate([
        tableView.topAnchor.constraint(equalTo: view.topAnchor),
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
                
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        
    }

    

}

