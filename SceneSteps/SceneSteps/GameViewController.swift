//
//  GameViewController.swift
//  SceneSteps
//
//  Created by Eric Chan on 10/3/17.
//  Copyright © 2017 Eric Chan. All rights reserved.
//

import UIKit
//import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene(named: "scene.scnassets/scene.scn")!
        
        // lets get the cone node
//        let object = scene.rootNode.childNode(withName: "group118488578", recursively: true)!
        let cone = scene.rootNode.childNode(withName: "cone", recursively: false)!
        cone.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape.init(node: cone, options: nil))
        let plane = scene.rootNode.childNode(withName: "plane", recursively: false)!
        plane.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape.init(geometry: SCNPlane(width: 10, height: 10), options: nil))
        plane.eulerAngles = SCNVector3Make(.pi * 0.5, 0, 0)
//        cone.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        //create a camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        // animate the 3d object
        cone.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0.2, z: 0, duration: 1)))
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        scnView.allowsCameraControl = true
        scnView.showsStatistics = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(whenTapped(_:)))
        scnView.addGestureRecognizer(tap)
    }
    
    @objc func whenTapped(_ gestureRecognize: UITapGestureRecognizer){
        let scnView = self.view as! SCNView
        
        let position = gestureRecognize.location(in: scnView)
        let checkTouch = scnView.hitTest(position, options: [SCNHitTestOption.firstFoundOnly: true])
        if checkTouch.count > 0 && checkTouch[0].node.name != nil{
            if  checkTouch[0].node.name! == "cone" {
                let touchedNode = checkTouch[0]
                let sphereTouch = SCNNode(geometry: SCNSphere(radius: 0.05))
                sphereTouch.geometry?.firstMaterial?.emission.contents = UIColor.green
                sphereTouch.position = touchedNode.localCoordinates
                sphereTouch.physicsBody = SCNPhysicsBody(type: .dynamic,shape: SCNPhysicsShape.init(node: sphereTouch, options: nil))
                
                
                
    //            let daisyScene = SCNScene(named: "scene.scnassets/daisycentered.dae")!
    //            let daisyNode = daisyScene.rootNode.childNode(withName: "daisy", recursively: false)
    //            daisyNode?.position = touchedNode.localCoordinates
                
    //            daisyNode?.eulerAngles.y = Float(drand48() * .pi)
    //            daisyNode?.constraints = [SCNLookAtConstraint(target: scnView.scene?.rootNode.childNode(withName: "camera", recursively: false))]
                
    //            print("\(daisyNode!.rotation)")
    //            daisyNode?.scale  = SCNVector3Make(0.1, 0.1, 0.1)
    //            daisyNode?.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0.2, z: 0, duration: 1)))
                
    //            scnView.scene?.rootNode.childNode(withName: "cone", recursively: false)!.addChildNode(daisyNode!)
                 scnView.scene?.rootNode.childNode(withName: "cone", recursively: false)!.addChildNode(sphereTouch)
            }
        }
        print("\(checkTouch.count)")
        
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
