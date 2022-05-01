//
//  mapView.swift
//  TryItOn
//
//  Created by snoopy on 15/04/2022.
//

import SwiftUI
import MapKit
import Kingfisher

struct mapScreen: View {
    
    @State private var hud : MBProgressHUD!
    @ObservedObject private var locationListVM = LocationListViewModel(jsonUrl: "https://sneaker-json-api.herokuapp.com/location")
    @State private var mapRegion : MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 3.1390, longitude: 101.6869) , span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    var body: some View {
        
        ZStack{
            Map(coordinateRegion: $mapRegion, annotationItems: locationListVM.storeLocation, annotationContent: { location in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude) , tint: .blue)
            })
                .ignoresSafeArea()
            VStack(spacing : 0){
                Spacer()
                ZStack(){
                    ForEach(locationListVM.storeLocation , id: \.locationName) { store in
                        mapCardView(location: store.location)
                            .shadow(color: Color.black.opacity(0.8), radius: 8)
                            .padding(10)
                    }
                }
            }
            
        }.overlay(closeButton , alignment: .topLeading)
            
    }
}

extension mapScreen {
    private var closeButton : some View {
        
        Button{
            
        }label: {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundColor(.white)
                .background(Color.black)
                .cornerRadius(10)
                .shadow(color: Color.white, radius: 4)
                .padding()
            
        }
    }
}
