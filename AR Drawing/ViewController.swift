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
        print("rendering..")
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
        
        print(orientation.x, orientation.y, orientation.z)
    }
    
}

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    
    // making new 3D vector (add)
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}

