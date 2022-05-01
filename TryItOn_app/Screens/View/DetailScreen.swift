//
//  DetailScreen.swift
//  TryItOn_app
//
//  Created by Leow Wai Chun on 14/2/21.
//

import SwiftUI
import CoreData
import Kingfisher


struct DetailScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    
    @State private var arScene = false
    @State private var isActive = false
    
    
    let sneaker : Sneaker
    var body: some View {
        ZStack {
            Color("Bg")
            detailScreenBody
            bottomRow
        }
        .sheet(isPresented: $arScene){
            arView(arAsset: sneaker.arAsset, arDirectory: sneaker.arDirectory)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: {presentationMode.wrappedValue.dismiss()}))
        
    }
    
}

extension DetailScreen {
    private var sneakerImage : some View {
        KFImage(URL(string: sneaker.imageurl))
            .resizable()
            .aspectRatio(1,contentMode: .fit)
            .edgesIgnoringSafeArea(.top)
        
    }
    
    private var sneakerPrice : some View{
        Text(sneaker.price)
            .font(.title)
            .foregroundColor(.white)
    }
    
    private var detailScreenBody : some View{
        ScrollView  {
            sneakerImage
            DescriptionView(sneakerInfo: sneaker)
            
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    
    private var bottomRow : some View{
        HStack {
            sneakerPrice
            Spacer()
            tryOnButton
            
        }
        .padding()
        .padding(.horizontal)
        .background(Color(red: 36 / 255, green: 42 / 255, blue: 46 / 255))
        .cornerRadius(60.0, corners: .topLeft)
        .frame(maxHeight: .infinity, alignment: .bottom)
        .edgesIgnoringSafeArea(.bottom)
    }
}


struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}


struct DescriptionView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var favSneakerList : FetchedResults<Favourite>
    
    @State private var mapViewisPresent : Bool = false
    @State private var isFav : Bool = false
    private var colorValue : [String] ;
    private var SneakerInfo : Sneaker
    
    
    
    init(sneakerInfo : Sneaker){
        
        self.SneakerInfo = sneakerInfo
        
        
        print(sneakerInfo.color)
        self.colorValue = sneakerInfo.color.components(separatedBy: ",")
        print(colorValue)
    }
    
    private func loadHapticFeedBack(style : UIImpactFeedbackGenerator.FeedbackStyle){
            let impactHeavy = UIImpactFeedbackGenerator(style: style)
                        impactHeavy.impactOccurred()
    }
    
    
    private func saveContext(){
            do{
                try moc.save()
            }catch{
                let error = error as NSError
                fatalError("Unresolved error : \(error)")
            }
    }
    
    
    var body: some View {
        VStack (alignment: .leading) {
            //                Title
            HStack(alignment:.top){
                Text(SneakerInfo.sneakername)
                    .font(.title)
                    .fontWeight(.bold)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 8, y: 0)
                Spacer()
                favouriteButton
            }
            HStack (spacing: 4) {
                ForEach(0 ..< 5) { item in
                    Image("star")
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 0)
                }
                Text("(" + SneakerInfo.rating + ")")
                    .opacity(0.5)
                    .padding(.leading, 5)

                Button(action: {
                    self.mapViewisPresent.toggle()

                        }) {
                            Image(systemName: "location.magnifyingglass")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.black)
                        }
                Spacer()
            }
            
            Text("Description")
                .fontWeight(.semibold)
                .padding(.vertical, 2)
            Text(SneakerInfo.description)
                .lineSpacing(8.0)
                .opacity(0.6)
                .onTapGesture (count:2){
                    if(self.isFav == true){
                        self.isFav = false
                        loadHapticFeedBack(style: .light)
                    }else{
                        self.isFav = true
                        loadHapticFeedBack(style: .heavy)
                    }
                }
            
            HStack (alignment: .top) {
                
                VStack (alignment: .leading) {
                    Text("Color")
                        .fontWeight(.semibold)
                    Circle()
                        .fill(Color(red: Double(self.colorValue[0])! / 255, green: Double(self.colorValue[1])! / 255, blue: Double(self.colorValue[2])! / 255))
                        .frame(width: 20, height: 20)
                        .offset(x:5, y:-10)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                VStack (alignment: .leading) {
                    Text("Size")
                        .fontWeight(.semibold)
                    Text(SneakerInfo.size)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding(.vertical)
            
            
        }
        .sheet(isPresented: $mapViewisPresent) {
                    mapScreen()
        }
        .padding()
        .padding(.top)
        .background(Color("Bg"))
        .cornerRadius(30, corners: [.topLeft, .topRight])
        .offset(x: 0, y: -30.0)
        
    }
}


struct BackButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.backward")
                .foregroundColor(.black)
                .padding(.all, 12)
                .cornerRadius(8.0)
        }
    }
}

extension DetailScreen {
    private var tryOnButton :some View{
        Button {
            self.arScene = true
        } label: {
            Text("Try On")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color("Primary"))
                .padding()
                .background(Color.white)
                .cornerRadius(10.0)
                .shadow(color: Color.blue.opacity(0.2), radius: 5, x: 10, y: 0)
        }
    }
}

extension DescriptionView {
    private func saveSneakerData(){
        loadHapticFeedBack(style: .heavy)
        let fav = Favourite(context: moc)
        fav.sneakerid = SneakerInfo.sneakerid
        fav.sneakername = SneakerInfo.sneakername
        fav.price = SneakerInfo.price
        fav.imageurl = SneakerInfo.imageurl
        fav.rating = SneakerInfo.rating
        fav.size = SneakerInfo.size
        fav.sneakerdescription = SneakerInfo.description
        fav.color = SneakerInfo.color
        fav.savedDate = Date()

        saveContext()
    }
    
    
    private var mapButton : some View {
        Button(action: {
            self.mapViewisPresent.toggle()

                }) {
                    Image(systemName: "location.magnifyingglass")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.black)
                }
    }
    
    private var favouriteButton : some View {
        Button{
            
            if self.isFav{
                loadHapticFeedBack(style: .light)
                let fav = favSneakerList.filter({ $0.sneakerid == self.SneakerInfo.sneakerid }).first
                moc.delete(fav!)
                saveContext()
            }else{
                saveSneakerData()
            }
            self.isFav.toggle()
        }label : {
            Image(systemName: self.isFav == true ? "heart.fill" : "heart")
                .resizable()
                .foregroundColor(self.isFav == true ? Color.red : Color.black)
                .frame(width: 32, height: 28)
                .padding(4)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 10, y: 0)
                
                
        }.onAppear(){
            if favSneakerList.filter({ $0.sneakerid == self.SneakerInfo.sneakerid }).first != nil {
                self.isFav = true
                
            } else {
                self.isFav = false
            }
        }
    }
}
