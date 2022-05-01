//
//  sneakerFavItem.swift
//  TryItOn
//
//  Created by snoopy on 26/04/2022.
//

import SwiftUI
import Kingfisher
struct sneakerFavItem: View {
    var namespace : Namespace.ID
    @Binding var present : Bool
    
    @State var favSneaker : Favourite
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text(favSneaker.sneakername!)
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(Color.black)
                    .frame(maxWidth : .infinity , alignment: .leading)
                    .matchedGeometryEffect(id: "title", in: namespace)
                Text(favSneaker.sneakerdescription!)
                    .font(.footnote)
                    .foregroundColor(Color.black)
                    .fixedSize(horizontal: false, vertical: false)
                    .frame(width: 300 , height: 50)
                    .matchedGeometryEffect(id: "subTitle", in: namespace)
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                    )
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur", in: namespace)
            )
        }
        
        .foregroundStyle(.white)
        .background(
            KFImage(URL(string: favSneaker.imageurl!))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .offset(y:-30)
                .matchedGeometryEffect(id: "image", in: namespace)
        )
//        .background(
//            Image("bg123")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .matchedGeometryEffect(id: "background", in: namespace)
//        )
        .mask {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "mask", in: namespace)
        }
        .frame(height : 300)
        .padding(20)
    }
}

//struct sneakerFavItem_Previews: PreviewProvider {
//    @Namespace static var namespace
//    
//    static var previews: some View {
//        sneakerFavItem(namespace : namespace , present : .constant(true))
//    }
//}
