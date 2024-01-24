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

class ViewController: UIViewController {
    
//    var users: [Users] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
        let users = try! JSONDecoder().decode([Users].self, from: data!)
            
            print (users)

        } .resume()
                
        print(users)
        
        
        
    }


}

