//
//  SlpashScreen.swift
//  TryItOn
//
//  Created by snoopy on 11/04/2022.
//

import SwiftUI

struct SlpashScreen: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    
    var body: some View {
        if isActive{
            HomeScreen()
        }else{
            loadingScreen
        }

        
    }
}


extension SlpashScreen {
    private var loadingScreen : some View {
        VStack{
            VStack{
                Image("TryItOnIcon")
                    .resizable()
                    .frame(width: 150, height: 150)
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear(){
                withAnimation(.easeIn(duration: 1.2)){
                    self.size = 0.9
                    self.opacity = 10
                }
            }
        }.onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.5){
                self.isActive = true
            }
        }
    }
}

struct SlpashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SlpashScreen()
    }
}
