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
    }
    
    


}

