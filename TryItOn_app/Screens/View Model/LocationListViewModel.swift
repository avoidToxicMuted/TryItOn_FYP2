//
//  LocationListViewModel.swift
//  TryItOn
//
//  Created by snoopy on 15/04/2022.
//

import Foundation

class LocationListViewModel : ObservableObject{
    var jsonUrl : String = ""
    @Published var storeLocation = [LocationViewModel]()
    
    init(jsonUrl : String){
        print(jsonUrl)
        Api(JsonUrl: jsonUrl).getLocation{ locationData in
            self.storeLocation = locationData.map(LocationViewModel.init)
        }
    }
}


struct LocationViewModel : Identifiable{
    let id = UUID()
    
    var location : Location
    
    init(location : Location){
        self.location = location
    }
    
    var locationName : String {
        return self.location.locationName
    }
    
    var longitude : Double {
        return self.location.longitude
    }
    
    var latitude : Double {
        return self.location.latitude
    }
    
    var imageUrl : String {
        return self.location.imageUrl
    }

}
