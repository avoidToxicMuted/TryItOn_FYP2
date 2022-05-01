//
//  FavScreen.swift
//  TryItOn
//
//  Created by snoopy on 26/04/2022.
//

import SwiftUI

struct FavScreen: View {
    @FetchRequest(sortDescriptors: []) var favSneakerList : FetchedResults<Favourite>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Namespace var namapsace
    @State var show = false

    var body: some View {        
        ZStack{
            ScrollView (.vertical, showsIndicators: false) {
                    ForEach(favSneakerList) { sneaker in
                        if !show{
                            sneakerFavItem(namespace: namapsace, present: $show, favSneaker: sneaker)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                        show.toggle()
                                    }
                                }
                        }else{
                            sneakerFavView(namespace: namapsace, present: $show , favSneaker: sneaker)
                        }
                    }

                
            }
            
        }
        .navigationBarTitle("Favourite" , displayMode : .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: {presentationMode.wrappedValue.dismiss()}))
        
    }
}
