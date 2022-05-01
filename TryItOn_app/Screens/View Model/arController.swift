//
//  ViewController.swift
//  arDetector
//
//  Created by snoopy on 20/07/2021.
//

import UIKit
import ARKit
import Photos
import SwiftUI
import SceneKit
import AVFoundation


class ViewController: UIViewController, ARSCNViewDelegate , AVCapturePhotoCaptureDelegate {

    var arAsset : String = ""
    var arDirectory : String = ""
    
    var scalingForSneaker :Float = 0.0;
    
    private var detectingView : MBProgressHUD!
    
    private var isAutoDetect : Bool = false
    
    private var numberOfShoe : Int = 0
    
    private let capture : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        button.layer.cornerRadius = 40
        button.layer.borderWidth = 7
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    
    private var opStateSubView : UIView = {
       let switchView = UIView(frame: CGRect(x: 190, y: 30, width: 170, height: 80))
        switchView.backgroundColor = .clear
        switchView.layer.cornerRadius = 10
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = switchView.bounds
        blurEffectView.layer.cornerRadius = 10
        blurEffectView.layer.masksToBounds = true
        
        switchView.addSubview(blurEffectView)
        return switchView
    }()
    
    private var operationState : UILabel = {
       let stateLabel = UILabel(frame: CGRect(x: 210, y: 30, width: 200, height: 80))
        stateLabel.text = "Manual"
        stateLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        stateLabel.font = stateLabel.font.withSize(19)
        stateLabel.textColor = UIColor(Color("Primary"))
        
        stateLabel.layer.shadowColor = UIColor.black.cgColor
        stateLabel.layer.shadowRadius = 3.0
        stateLabel.layer.shadowOpacity = 1.0
        stateLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        stateLabel.layer.masksToBounds = false
        
        return stateLabel
    }()
    
    private let stateButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 280, y: 35, width: 75, height: 70))
        button.setImage(UIImage(systemName :"plus.viewfinder"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 10 , left: 10, bottom: 10, right: 10)
        return button
    }()
    
    
    var sceneView: ARSCNView {
            return self.view as! ARSCNView
    }
    
    
    private func registerGestureRecognizers() {
            
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
//        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
            
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinched))
        self.sceneView.addGestureRecognizer(pinchGestureRecognizer)
        
//        let dragGestureReconginizer = UIPanGestureRecognizer(target: self, action: #selector(draged))
//        self.sceneView.addGestureRecognizer(dragGestureReconginizer)
//
    }
    
    private func changeState(isAuto : Bool) {
        if(isAuto){
            isAutoDetect = true
            operationState.text = "Auto"
            self.detectingView = MBProgressHUD.showAdded(to: self.sceneView, animated: true)
            self.detectingView.label.text = "Finding user foot"
            
            // Create a session configuration
            let configuration = ARWorldTrackingConfiguration()
            
            //Object detection
            configuration.detectionObjects = ARReferenceObject.referenceObjects(inGroupNamed: "footObject", bundle: Bundle.main)!
            
            // Run the view's session
            sceneView.session.run(configuration)
        }else {
            operationState.text = "Manual"
            
            // Create a session configuration
            let configuration = ARWorldTrackingConfiguration()
            
            
            registerGestureRecognizers()
            
            // Run the view's session
            sceneView.session.run(configuration)
        }
    }
        
    @objc func capturePhoto() {

        var image = sceneView.snapshot()

        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    
    @objc func stetaChange(sender: UIButton!) {
        if(isAutoDetect){
            changeState(isAuto: false)
        }else{
            changeState(isAuto: true)
        }
    }
    
        
    @objc func pinched(recognizer :UIPinchGestureRecognizer) {
            
            if recognizer.state == .changed {
                
                guard let sceneView = recognizer.view as? ARSCNView else {
                    return
                }
                
                let touch = recognizer.location(in: sceneView)
                
                let hitTestResults = self.sceneView.hitTest(touch, options: nil)
                
                if let hitTest = hitTestResults.first {
                    
                    let shoeNode = hitTest.node
                    
                    let pinchScaleX = Float(recognizer.scale) * shoeNode.scale.x
                    let pinchScaleY = Float(recognizer.scale) * shoeNode.scale.y
                    let pinchScaleZ = Float(recognizer.scale) * shoeNode.scale.z
                    
                    shoeNode.scale = SCNVector3(pinchScaleX,pinchScaleY,pinchScaleZ)
                    
                    recognizer.scale = 1
                    
                }
            }
            
        }
        
//        @objc func tapped(recognizer :UITapGestureRecognizer) {
//
//            guard let sceneView = recognizer.view as? ARSCNView else {
//                return
//            }
//
//            if(numberOfShoe >= 1) { return }
//
//            let touch = recognizer.location(in: sceneView)
//            
//            let hitTestResults = sceneView.hitTest(touch, types: [ARHitTestResult.ResultType.featurePoint])
//
//            if let hitTest = hitTestResults.first {
//
//                let shoeScene = SCNScene(named: arAsset)!
//                guard let shoeNode = shoeScene.rootNode.childNode(withName: arDirectory, recursively: true) else {
//                    return
//                }
//
//                shoeNode.transform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1), 0, 1, 0)
//
//                let ScaleX = scalingForSneaker
//
//                let ScaleY = scalingForSneaker
//
//                let Scalez = scalingForSneaker
//
//                shoeNode.scale = SCNVector3(ScaleX,ScaleY,Scalez)
//
//                shoeNode.position  = SCNVector3(hitTest.worldTransform.columns.3.x,hitTest.worldTransform.columns.3.y,hitTest.worldTransform.columns.3.z + 0.35)
//
//                self.sceneView.scene.rootNode.addChildNode(shoeNode)
//
//                numberOfShoe += 1
//
//                print("added")
//            }
//
//
//        }

//    @objc func draged(_ gesture: UIPanGestureRecognizer) {
//
//        if gesture.state == .changed {
//
//            guard let sceneView = gesture.view as? ARSCNView else {
//                return
//            }
//
//            let touch = gesture.location(in: sceneView)
//
//            let hitTestResults = self.sceneView.hitTest(touch, options: nil)
//
//            if let hitTest = hitTestResults.first {
//
//                let shoeNode = hitTest.node
//
//                guard let hitTestPosition = self.sceneView.hitTest(touch, types: .existingPlane).first else { return }
//
//                let worldTransform = hitTestPosition.worldTransform
//
//                //4. Set The New Position
//                let newPosition = SCNVector3(worldTransform.columns.3.x, worldTransform.columns.3.y, worldTransform.columns.3.z)
//
//                //5. Apply To The Node
//                shoeNode.simdPosition = float3(newPosition.x, newPosition.y, newPosition.z)
//            }
//        }
//
//
//    }


    
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        capture.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height - 80)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.addSubview(capture)
        view.addSubview(opStateSubView)
        view.addSubview(operationState)
        view.addSubview(stateButton)
        capture.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
        stateButton.addTarget(self, action: #selector(stetaChange), for: .touchUpInside)
        
        sceneView.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        changeState(isAuto: isAutoDetect)
        
    
    }
    
    override func loadView() {
            self.view = ARSCNView(frame: .zero)
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    
    

    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let objectAnchor = anchor as? ARObjectAnchor{
            
            DispatchQueue.main.async {
                self.detectingView.label.text = "Found"
                self.detectingView.hide(animated : true , afterDelay : 1.0)
            }
            
            let shoeScene = SCNScene(named: arAsset)!
            let shoeNode = shoeScene.rootNode.childNode(withName: arDirectory, recursively: true)
            shoeNode?.transform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1), 0, 1, 0)
            
            let ScaleX = objectAnchor.referenceObject.extent.x * 7
            
            let ScaleY = objectAnchor.referenceObject.extent.y * 7
            
            let Scalez = objectAnchor.referenceObject.extent.z * 7
            
            shoeNode?.scale = SCNVector3(ScaleX,ScaleY,Scalez)
            
            shoeNode?.position = SCNVector3(x: objectAnchor.referenceObject.center.x , y: objectAnchor.referenceObject.center.y - 0.35, z: objectAnchor.referenceObject.center.z - 0.35)
            
            self.sceneView.scene.rootNode.addChildNode(shoeNode!)
            
            numberOfShoe += 1
        }
        return node
    }
    
    
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}


