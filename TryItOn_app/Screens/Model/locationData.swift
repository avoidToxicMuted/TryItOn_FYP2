//
//  locationData.swift
//  TryItOn
//
//  Created by snoopy on 15/04/2022.
//

import Foundation

struct Location : Codable , Identifiable{
    let id = UUID()
    var locationName : String
    var storeLocationCity : String
    var latitude : Double
    var longitude : Double
    var imageUrl : String
}
