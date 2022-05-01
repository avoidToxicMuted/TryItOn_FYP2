//
//  arView.swift
//  TryItOn
//
//  Created by snoopy on 22/02/2022.
//

import SwiftUI
import ARKit

struct arView : UIViewControllerRepresentable {

    @State var arAsset : String = ""
    @State var arDirectory : String = ""
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = ViewController()
        vc.arAsset = self.arAsset
        vc.arDirectory = self.arDirectory
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        return
    }
   

}
