//
//  seankerData.swift
//  TryItOn
//
//  Created by snoopy on 08/04/2022.
//

import Foundation

struct Sneaker : Codable , Identifiable{
    let id = UUID();
    var sneakerid : String
    var sneakername : String
    var description :  String
    var price : String
    var imageurl : String
    var rating : String
    var size : String
    var color : String
    var arAsset : String
    var arDirectory : String
    
}
