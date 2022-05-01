//
//  FavoriteScreen.swift
//  TryItOn
//
//  Created by snoopy on 13/04/2022.
//

import SwiftUI
import Kingfisher

struct FavoriteScreen: View {
    @FetchRequest(sortDescriptors: []) var favSneakerList : FetchedResults<Favourite>
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    private func deleteItem(offsets : IndexSet){
        print(offsets)
        print(offsets.map{favSneakerList[$0]})
        offsets.map {favSneakerList[$0]}.forEach(moc.delete)
        saveContext()
            
    }
    
    private func saveContext(){
            do{
                try moc.save()
            }catch{
                let error = error as NSError
                fatalError("Unresolved error : \(error)")
            }
        }
    
    @Namespace private var animation
    @State var show = false
    
    
    var body: some View {
        
            ZStack{
                Color(#colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1))
                    .ignoresSafeArea()

                ScrollView (.vertical, showsIndicators: false) {
                    VStack{
                        ForEach(favSneakerList) { sneaker in
                            favCardView(size: 300, post: sneaker)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 1, y: 10)
                        }
                    }
                }
            }
            .navigationBarTitle("Favourite" , displayMode : .inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(action: {presentationMode.wrappedValue.dismiss()}))
        
        
    }
}

struct favCardView: View {
    let size: CGFloat
    @State var post : Favourite
    @State var isPresent : Bool = false
    
    var body: some View {
        
        HStack{
            VStack{
                Text(post.sneakername!).font(.title3).fontWeight(.bold).frame(alignment: .leading)
            }
            Spacer()
            KFImage(URL(string: post.imageurl!))
                .resizable()
                .frame(width: 120, height: 225 * (120/210))
                .cornerRadius(20.0)
        }.frame(width: size)
            .padding()
            .background(Color.white)
            .cornerRadius(20.0)
        
    }
}


extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

