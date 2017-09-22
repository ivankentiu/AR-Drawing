//
//  ViewController.swift
//  AR Drawing
//
//  Created by Ivan Ken Tiu on 22/09/2017.
//  Copyright © 2017 Ivan Ken Tiu. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var draw: UIButton!
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        
        // for the delegate function to be called when a scene is rendered, declare sceneView delegate to be self
        self.sceneView.delegate = self
        
        // show statistics (frames per sec , scene rendering performance)
        self.sceneView.showsStatistics = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // from ARSCNViewDelegate, this delegate function gets called everytime the view is about to render a scene (loop like update in unity)
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        
        // point of view(current orientation and location) = current position of the sceneView(cameraview)
        guard let pointOfView = sceneView.pointOfView else { return }
        
        // transform matrix
        let transform = pointOfView.transform
        
        // extract the current orientation of camera (default is reversed so negative)
        let orientation = SCNVector3(-transform.m31, -transform.m32, -transform.m33)
        
        // extract the current location of camera
        let location = SCNVector3(transform.m41, transform.m42, transform.m43)
        
        // get the current position
        let currentPositionOfCamera = orientation + location
        DispatchQueue.main.async {
            // add self else error
            if self.draw.isHighlighted  {
                let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.02))
                
                // put the sphere is the current position of the camera (starting position draw)
                sphereNode.position = currentPositionOfCamera
                self.sceneView.scene.rootNode.addChildNode(sphereNode)
                sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
                print("draw button is being pressed")
            } else {
                // change from sphere to box (to distinguish) illusion that it is a sphere
                let pointer = SCNNode(geometry: SCNSphere(radius: 0.01))
                
                // give it a name to differentiate instead of using the circle box tech
                pointer.name = "pointer"
                
                // place pointer in the current position of camera
                pointer.position = currentPositionOfCamera
                
                // we have to delete every single other pointer if is SCNBox
                self.sceneView.scene.rootNode.enumerateChildNodes( { (node, _) in
                    if node.name == "pointer" {
                         node.removeFromParentNode()
                    }
                })
                
                pointer.geometry?.firstMaterial?.diffuse.contents = UIColor.red
                
                // only adding the newest pointer in the sceneview
                self.sceneView.scene.rootNode.addChildNode(pointer)
            }
        }
        
        
    }
    
}

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    
    // making new 3D vector (add)
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}

