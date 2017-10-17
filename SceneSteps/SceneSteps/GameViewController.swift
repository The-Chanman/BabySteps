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

let experiment = "Cone"

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch experiment {
        case "Cone":
            print("Cone Experiment")
            // create a new scene
            let scene = SCNScene(named: "scene.scnassets/scene.scn")!
            
            // lets get the cone node
            let cone = scene.rootNode.childNode(withName: "cone", recursively: false)!
            cone.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape.init(geometry: SCNCone(topRadius: 0, bottomRadius: 0.5, height: 1), options: nil))
            let plane = scene.rootNode.childNode(withName: "plane", recursively: false)!
            plane.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape.init(geometry: SCNPlane(width: 10, height: 10), options: nil))
            plane.eulerAngles = SCNVector3Make(.pi * 1.5, 0, 0)
            plane.geometry?.firstMaterial?.diffuse.contents = "floor"
            plane.geometry?.firstMaterial?.diffuse.contentsTransform = SCNMatrix4MakeScale(2, 2, 1)
            plane.geometry?.firstMaterial?.diffuse.wrapT = .mirror
            plane.geometry?.firstMaterial?.diffuse.wrapS = .mirror
            cone.geometry?.firstMaterial?.diffuse.contents = "Aluminium"
            
            //create a camera
            let cameraNode = SCNNode()
            cameraNode.camera = SCNCamera()
            scene.rootNode.addChildNode(cameraNode)
            
            // animate the 3d object
            cone.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0.2, z: 0, duration: 1)))
            
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
            
            // retrieve the SCNView
            let scnView = self.view as! SCNView
            
            // set the scene to the view
            scnView.scene = scene
            
            scnView.allowsCameraControl = true
            scnView.showsStatistics = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(whenTapped(_:)))
            scnView.addGestureRecognizer(tap)
            
        case "Honor":
            print("Honor Experiment")
            let scene = SCNScene(named: "scene.scnassets/honor.dae")!
            
            // create and add a light to the scene
            let lightNode = SCNNode()
            lightNode.light = SCNLight()
            lightNode.light!.type = .omni
            lightNode.position = SCNVector3(x: 2, y: 10, z: -100)
            scene.rootNode.addChildNode(lightNode)
            
            // create and add an ambient light to the scene
            let ambientLightNode = SCNNode()
            ambientLightNode.light = SCNLight()
            ambientLightNode.light!.type = .ambient
            ambientLightNode.light!.color = UIColor.darkGray
            scene.rootNode.addChildNode(ambientLightNode)
            
            // retrieve the SCNView
            let scnView = self.view as! SCNView
            
            // set the scene to the view
            scnView.scene = scene
            
            scnView.allowsCameraControl = true
            scnView.showsStatistics = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(whenTapped(_:)))
            scnView.addGestureRecognizer(tap)
  
        default:
            fatalError("You didn't choose a valid experiment")
        }
    }
    
    @objc func whenTapped(_ gestureRecognize: UITapGestureRecognizer){
        let scnView = self.view as! SCNView
        let position = gestureRecognize.location(in: scnView)
        
        switch experiment {
        case "Cone":
            
            let checkTouch = scnView.hitTest(position, options: [SCNHitTestOption.firstFoundOnly: true])
            print("\(checkTouch.count)")
            if checkTouch.count > 0 && checkTouch[0].node.name != nil{
                if  checkTouch[0].node.name! == "cone" {
                    let touchedNode = checkTouch[0]
                    let sphereTouch = SCNNode(geometry: SCNSphere(radius: 0.1))
                    sphereTouch.geometry?.firstMaterial?.diffuse.contents = "NewTennisBallColor"
                    sphereTouch.geometry?.firstMaterial?.roughness.contents = "TennisBallBump"
                    sphereTouch.geometry?.firstMaterial?.lightingModel = .physicallyBased
                    sphereTouch.position = touchedNode.localCoordinates
                    sphereTouch.physicsBody = SCNPhysicsBody(type: .dynamic,shape: SCNPhysicsShape.init(geometry: SCNSphere(radius: 0.1), options: nil))
                    let randomDirection:Float = arc4random_uniform(2) == 0 ? -1.0 : 1.0
                    let force = SCNVector3(x: randomDirection, y: 0.5, z: 0)
                    sphereTouch.physicsBody?.applyForce(force, at: SCNVector3(x: 0.05, y: 0.05, z: 0.05), asImpulse: true)
                    
                    scnView.scene?.rootNode.childNode(withName: "cone", recursively: false)!.addChildNode(sphereTouch)
                    
                    /*****************************************************************************************************
                                                             Daisy Test
                     ****************************************************************************************************/
                    //            let daisyScene = SCNScene(named: "scene.scnassets/daisycentered.dae")!
                    //            let daisyNode = daisyScene.rootNode.childNode(withName: "daisy", recursively: false)
                    //            daisyNode?.position = touchedNode.localCoordinates
                    //            daisyNode?.eulerAngles.y = Float(drand48() * .pi)
                    //            daisyNode?.constraints = [SCNLookAtConstraint(target: scnView.scene?.rootNode.childNode(withName: "camera", recursively: false))]
                    //            print("\(daisyNode!.rotation)")
                    //            daisyNode?.scale  = SCNVector3Make(0.1, 0.1, 0.1)
                    //            daisyNode?.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0.2, z: 0, duration: 1)))
                    //            scnView.scene?.rootNode.childNode(withName: "cone", recursively: false)!.addChildNode(daisyNode!)
                }
            }
        
        case "Honor":
            let checkTouch = scnView.hitTest(position, options: nil)
            print("\(checkTouch.count)")
            if checkTouch.count > 0 && checkTouch[0].node.name != nil{
                let arm = scnView.scene?.rootNode.childNode(withName: "leftArm", recursively: false)
                SCNTransaction.animationDuration = 1
                arm?.eulerAngles = SCNVector3(1.1,0,0)
                arm?.position = SCNVector3 (0,0.5,0.1)
                
            }
        default:
            fatalError("You didn't choose a valid experiment")
        }
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
