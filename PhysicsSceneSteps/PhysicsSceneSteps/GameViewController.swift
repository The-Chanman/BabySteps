//
//  GameViewController.swift
//  PhysicsSceneSteps
//
//  Created by Eric Chan on 10/16/17.
//  Copyright © 2017 Eric Chan. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // create a new scene
        let scene = SCNScene()
        //let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
         // set the speed of the world
        scene.physicsWorld.speed = 1
        
        // create and add a floor to the world
        let floor = SCNNode(geometry: SCNFloor())
        floor.name = "floor"
        floor.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        // other physics body options
//        floor.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(node: floor, options: [SCNPhysicsShape.Option.type : SCNPhysicsShape.ShapeType.concavePolyhedron]))
//        floor.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape(geometry: SCNFloor(), options: nil))
        scene.rootNode.addChildNode(floor)
        

        
        // create and add a plane to the scene
        let plane = SCNCylinder(radius: 5, height: 0.2)
        let plane1 = SCNNode(geometry: plane)
        // other physics body options
                plane1.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
//        plane.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: plane, options:  [SCNPhysicsShape.Option.type : SCNPhysicsShape.ShapeType.concavePolyhedron]))
//        plane1.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: plane1, options:  nil))
        plane1.position = SCNVector3Make(0, -2, 0)
        plane1.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        plane1.geometry?.firstMaterial?.isDoubleSided = true
        scene.rootNode.addChildNode(plane1)
       
        
        // create and add a plane to the scene
        let container = SCNNode(geometry: SCNTube(innerRadius: 4.9, outerRadius: 5.1, height: 4))
        //        container.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: container, options:  nil))
        container.physicsBody = SCNPhysicsBody(type: .kinematic, shape: SCNPhysicsShape(node: container, options:  [SCNPhysicsShape.Option.type : SCNPhysicsShape.ShapeType.concavePolyhedron]))
        container.position = SCNVector3Make(0, 2.15, 0)
        container.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
        container.geometry?.firstMaterial?.isDoubleSided = true
        plane1.addChildNode(container)
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera at a location
        cameraNode.position = SCNVector3(x: 0, y: 4, z: 15)
        
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
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // add the default lightning for now so we don't have to worry
//        scnView.autoenablesDefaultLighting = true
        
        // background color of the scene
        scnView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        
      
        // create and add a sphere object to the scene
        let sphere = SCNNode(geometry: SCNSphere(radius: 0.5))
        sphere.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: sphere, options:  nil))
        sphere.position = SCNVector3Make(0, 10, 0)
        sphere.geometry?.firstMaterial?.diffuse.contents = UIColor(red: 0, green: 0, blue: 1, alpha: 1)
        scene.rootNode.addChildNode(sphere)
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            // get its material
            let material = result.node.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.red
            
            SCNTransaction.commit()
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
