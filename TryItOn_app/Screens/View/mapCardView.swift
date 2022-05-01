//
//  testmapCardView.swift
//  TryItOn
//
//  Created by snoopy on 16/04/2022.
//

import SwiftUI
import Kingfisher

struct mapCardView : View {
    
    let location : Location
    
    var body: some View {
        HStack(alignment : .bottom , spacing : 0) {
            VStack(alignment: .leading, spacing : 16){
                imageSection
                titleSection
                
            }
            nextButton
        }.padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
                .offset(y:65)
        )
        .cornerRadius(20)
    }
}

extension mapCardView {
    private var imageSection : some View {
        ZStack{
            KFImage(URL(string: location.imageUrl))
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
        }.padding(6)
        .background(Color.white)
        .cornerRadius(20)
    }
    
    private var titleSection  : some View {
        VStack (alignment:.leading , spacing : 4){
            Text(location.locationName)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(location.storeLocationCity)
                .font(.subheadline)
        }.frame(maxWidth : .infinity , alignment: .leading)
    }
    
    private var learnMore : some View {
        Button{
            
        }label: {
            Text("next")
                .font(.headline)
                .frame(width: 50, height: 35)
        }.buttonStyle(.borderedProminent)
    }
    
    private var nextButton : some View {
        Button{
            guard let url = URL(string:"http://maps.apple.com/?daddr=\(location.latitude),\(location.longitude)") else { return }
            UIApplication.shared.open(url)
        }label: {

            Image(systemName: "location.circle.fill")
                .resizable()
                .foregroundColor(.white)
                .frame(width: 35, height: 35)
        }.frame(width: 85  , height: 65)
            .background(Color.green)
            .cornerRadius(10)
    }
}
