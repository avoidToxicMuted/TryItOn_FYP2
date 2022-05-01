//
//  SneakerListViewModel.swift
//  TryItOn
//
//  Created by snoopy on 10/04/2022.
//

import Foundation

class SneakerListViewModel : ObservableObject{
    var jsonUrl : String = ""
    @Published var posts = [SneakerViewModel]()
    
    init(jsonUrl : String){
        print(jsonUrl)
        Api(JsonUrl: jsonUrl).getPosts{ sneakerData in
            self.posts = sneakerData.map(SneakerViewModel.init)
            
        }
    }
}


struct SneakerViewModel{
    var sneaker : Sneaker
    
    init(sneaker : Sneaker){
        self.sneaker = sneaker
    }
    
    var sneakername : String{
        return self.sneaker.sneakername
    }
    
    var description : String{
        return self.sneaker.description
    }
    
    var price : String{
        return self.sneaker.price
    }
    
    var imageurl : String{
        return self.sneaker.imageurl
    }
    
    var rating : String{
        return self.sneaker.rating
    }
    var size : String{
        return self.sneaker.size
    }
    
    var color : String{
        return self.sneaker.color
    }
    

}
