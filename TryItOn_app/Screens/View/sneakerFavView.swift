//
//  sneakerFavView.swift
//  TryItOn
//
//  Created by snoopy on 26/04/2022.
//

import SwiftUI
import Kingfisher
struct sneakerFavView: View {
    var namespace : Namespace.ID
    @Binding var present : Bool
    
    @State var favSneaker : Favourite
    
    var body: some View {
            ZStack {
                ScrollView {
                    cover
                }
                .background(Color("bg"))
                .ignoresSafeArea()
                Button{
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)){
                        present.toggle()
                    }
                }label :{
                    Image(systemName: "xmark")
                        .font(.body.weight(.bold))
                        .foregroundColor(.secondary)
                        .padding(8)
                        .background(.ultraThinMaterial , in : Circle())
                        .frame(maxWidth : .infinity , maxHeight: .infinity , alignment: .topTrailing)
                        .padding(20)
                }
            }
        
    }
    
    var cover: some View{
        VStack{
            Spacer()
            
            
        }
        .frame(maxWidth:.infinity)
        
        .frame(height : 440)
        .padding(20)
        .foregroundStyle(.black)
        .background(
            KFImage(URL(string: favSneaker.imageurl!))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .matchedGeometryEffect(id: "image", in: namespace)
                .offset(y: -100)
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
        .overlay(
            VStack(alignment: .leading, spacing: 12){
                Text(favSneaker.sneakername!)
                    .font(.largeTitle.weight(.bold))
                    .frame(maxWidth : .infinity , alignment: .leading)
                    .matchedGeometryEffect(id: "title", in: namespace)
                Text(favSneaker.sneakerdescription!)
                    .font(.footnote)
                    .matchedGeometryEffect(id: "test", in: namespace)
                Divider()
                HStack{
                    Image(systemName: "arrow.right.doc.on.clipboard")
                        .resizable()
                        .frame(width: 26, height: 26)
                        .cornerRadius(5)
                        .padding(8)
                        .background(.ultraThinMaterial , in : RoundedRectangle(cornerRadius: 18, style: .continuous))
                    Text("Go to the detail page")
                        .font(.footnote)
                }
            }
                .padding(20)
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .mask(
                            RoundedRectangle(cornerRadius: 30, style: .continuous)
                        )
                        .matchedGeometryEffect(id: "blur", in: namespace)
                )
                .offset(y: 129)
        )
    }
}

//struct sneakerFavView_Previews: PreviewProvider {
//    @Namespace static var namespace
//    
//    
//    static var previews: some View {
//        sneakerFavView(namespace: namespace, present: .constant(true))
//    }
//}
