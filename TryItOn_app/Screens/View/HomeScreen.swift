import SwiftUI
import Kingfisher

struct HomeScreen: View {
    @State private var posts : [Sneaker] = []
    @State private var search: String = ""
    @State private var selectedIndex: Int = 1
    
    @State var selected = 0
    
    @State private var isActive = false
    
    
    @ObservedObject private var nikeListVM = SneakerListViewModel(jsonUrl: "https://sneaker-json-api.herokuapp.com/nike")
    @ObservedObject private var pumaListVM = SneakerListViewModel(jsonUrl: "https://sneaker-json-api.herokuapp.com/puma")
    @ObservedObject private var adidasListVM = SneakerListViewModel(jsonUrl: "https://sneaker-json-api.herokuapp.com/adidas")
    @ObservedObject private var hermesListVM = SneakerListViewModel(jsonUrl: "https://sneaker-json-api.herokuapp.com/hermes")

    private let categories = ["Adidas", "Nike", "Puma", "HERMĒS"]
    
    
    var body: some View {
        if isActive{
            NavigationView {
                ZStack {
                    Color(#colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1))
                        .ignoresSafeArea()
                        if self.selectedIndex == 0{
                            ScrollView (showsIndicators: false) {
                                VStack (alignment: .leading) {

                                    TagLineView()
                                        .padding()
                                            
                                    categoryView
                                            
                                            
                                    homeBodyView(sneakerListVM: self.adidasListVM)
                                }
                            }
                        }else if self.selectedIndex == 1{
                            ScrollView (showsIndicators: false) {
                                VStack (alignment: .leading) {
                                    TagLineView()
                                        .padding()
                                    categoryView
                                    homeBodyView(sneakerListVM: self.nikeListVM)
                                            
                                }
                        }
                        }else if self.selectedIndex == 2{
                            ScrollView (showsIndicators: false) {
                                VStack (alignment: .leading) {
                                    TagLineView()
                                        .padding()
                                    categoryView
                                            
                                    homeBodyView(sneakerListVM: self.pumaListVM)
                                }
                            }
                        }else if self.selectedIndex == 3{
                            ScrollView (showsIndicators: false) {
                                VStack (alignment: .leading) {
                                    TagLineView()
                                        .padding()
                                    hermesCategory
                                    homeBodyView(sneakerListVM: self.hermesListVM)
                                }
                            }
                        }
                        favouriteButtonView
                                
                    }
                }
            }else{
                SlpashScreen()
                    .onAppear(){
                        DispatchQueue.main.asyncAfter(deadline:.now() + 3.5){self.isActive = true}
                    }
            }
    }
}

extension HomeScreen {
    private var categoryView : some View{
        HStack {
            ForEach(0 ..< categories.count) { i in
                Button(action: {selectedIndex = i}) {

                    CategoryView(isActive: selectedIndex == i, hermes: false, text: categories[i])
                }
            }
        }
        .frame(width: 355, height: 60)
        .background(Color.black)
        .clipShape(Capsule())
        .shadow(color: Color.blue.opacity(0.15), radius: 8, x: 2, y: 6)
        .padding(10)
    }
    
    
    private var hermesCategory : some View {
        HStack {
            ForEach(0 ..< categories.count) { i in
                Button(action: {selectedIndex = i}) {

                    CategoryView(isActive: selectedIndex == i, hermes: true, text: categories[i])
                }
            }
        }
        .frame(width: 355, height: 60)
        .background(Color.black)
        .clipShape(Capsule())
        .shadow(color: Color.blue.opacity(0.15), radius: 8, x: 2, y: 6)
        .padding(10)
    }
    
    private var favouriteButtonView : some View {
        HStack{
            Spacer()
            VStack{
                Spacer()
                BottomNavBarView()
            }
        }
    }
}

// MARK: - Tag line
struct TagLineView: View {
    var body: some View {
        HStack{
            Text("Collection \nAthletic Shoes ")
                .font(.system(size: 38, weight: .bold, design: .default))
                .foregroundColor(Color.black)
        }
    }
}

// MARK: - Category
struct CategoryView: View {
    let isActive: Bool
    let hermes : Bool
    let text: String
    private let color = "hermes"
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            
            if (hermes){
                Text(text)
                    .font(.system(size: 19))
                    .fontWeight(.medium)
                    .foregroundColor(isActive ? Color("hermes") : Color.white.opacity(0.5))
            }else{
                Text(text)
                    .font(.system(size: 19))
                    .fontWeight(.medium)
                    .foregroundColor(isActive ? Color("Primary") : Color.white.opacity(0.5))
            }
            
            
                
            if (isActive && hermes) { Color.white
                .frame(width: 15, height: 2)
                .clipShape(Capsule())
            }else if(isActive){ Color("Primary")
                    .frame(width: 15, height: 2)
                    .clipShape(Capsule())
                
            }
        }
        .padding(10)
    }
}

// MARK: - body
struct homeBodyView : View{
    
    @State var sneakerListVM = SneakerListViewModel(jsonUrl: "")
    
    var body : some View{
        
        Text("Popular")
            .font(.system(size: 26, weight: .bold, design: .default))
            .padding(.horizontal)
        
        ScrollView (.horizontal, showsIndicators: false) {
            HStack (spacing: 0) {
                ForEach(sneakerListVM.posts ,id: \.sneakername){ sneakerData in
                    NavigationLink(
                        destination: DetailScreen(sneaker:  sneakerData.sneaker),
                        label: {
                            ProductCardView(size: 190, post: sneakerData.sneaker)
                        })
                        .navigationBarHidden(true)
                        .foregroundColor(.black)
                }

                .padding(.leading)
            }
        }
        .padding(.bottom)

        
        Text("New Released")
            .font(.system(size: 26, weight: .bold, design: .default))
            .padding(.horizontal)
        
        ScrollView (.horizontal, showsIndicators: false) {
            HStack (spacing: 0) {
                ForEach(sneakerListVM.posts ,id: \.sneakername){ sneakerData in
                    ProductCardView(size: 180, post: sneakerData.sneaker)
                    
                }.padding(.leading)
                
            }
        }
    }
}

struct ProductCardView: View {
    let size: CGFloat
    let post : Sneaker
    
    var body: some View {
        
        VStack {
            KFImage(URL(string: post.imageurl))
                .resizable()
                .frame(width: size, height: 225 * (size/210))
                .cornerRadius(20.0)

            
            Text(post.sneakername).font(.title3).fontWeight(.bold)
            
            HStack (spacing: 2) {
                Image("star")
                Text(post.rating)
                    .foregroundColor(.gray)
                Spacer()
                Text(post.price)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                
            }
        }
        .frame(width: size)
        .padding()
        .background(Color.white)
        .cornerRadius(20.0)
        
    }
}


struct BottomNavBarView: View {

    var body: some View {
        
        
        
        NavigationLink(
            destination:  FavScreen(),
            label: {
                HStack {
                    
                    Image(systemName: "heart.fill")
                        .frame(width: 18, height: 14)
                        .foregroundColor(Color("FavBg"))
                    

                }
                .padding(.vertical, 20 )
                .padding(.horizontal, 35)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.30), radius: 10, x: 2, y: 6)

                
            })
            .navigationBarHidden(true)
            .foregroundColor(.black)
    }
}


struct slpashScreen : View{
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body : some View{
        VStack{
            VStack{
                Image("TryItOnIcon")
                    .resizable()
                    .frame(width: 180, height: 180)
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear(){
                withAnimation(.easeIn(duration: 2.2)){
                    self.size = 3
                    self.opacity = 10
                }
            }
        }
    }
}
