//
//  JsonApiService.swift
//  TryItOn
//
//  Created by snoopy on 10/04/2022.
//

import Foundation

class Api {
    
    var JsonUrl : String = ""
    
    init(JsonUrl : String){
        self.JsonUrl = JsonUrl
    }
    
    func getPosts(completion : @escaping ([Sneaker]) ->  ()){
        guard let url = URL(string: JsonUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, _ , _) in
            
            guard let data = data else {return }
            
            let posts = try! JSONDecoder().decode([Sneaker].self, from: data)
            
            
            DispatchQueue.main.async {
                completion(posts)
            }
            
        }
        .resume()
    }
    
    func getLocation(completion : @escaping ([Location]) ->  ()){
        guard let url = URL(string: JsonUrl) else {return}
        URLSession.shared.dataTask(with: url) { (data, _ , _) in
            
            guard let data = data else {return }
            
            let posts = try! JSONDecoder().decode([Location].self, from: data)
            
            
            DispatchQueue.main.async {
                completion(posts)
            }
            
        }
        .resume()
    }
}
