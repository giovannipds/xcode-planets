//
//  ViewController.swift
//  Planets
//
//  Created by Giovani on 19/06/2018.
//  Copyright © 2018 Ezoom. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let config = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin ]
        self.sceneView.session.run(config)
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let threeHundredNSixtyDegrees = CGFloat(360.degreesToRadians)
        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        let earthParent = SCNNode()
        let venusParent = SCNNode()
        sun.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "Sun Diffuse")
        sun.position = SCNVector3(0, 0, -1)
        earthParent.position = SCNVector3(0, 0, -1)
        venusParent.position = SCNVector3(0, 0, -1)
        
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        
        
        let earth = planet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "Earth Day"), specular: #imageLiteral(resourceName: "Earth Specular"), emission: #imageLiteral(resourceName: "Earth Clouds"), normal: #imageLiteral(resourceName: "Earth Textures"), position: SCNVector3(1.2, 0, 0))
        let venus = planet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "Venus Surface"), specular: #imageLiteral(resourceName: "Venus Surface"), emission: nil, normal: nil, position: SCNVector3(0.7, 0, 0))
        let moon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, -0.3))
        let venusMoon = planet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "moon Diffuse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, -0.3))
        
        
        
        
        let action = SCNAction.rotateBy(x: 0, y: threeHundredNSixtyDegrees, z: 0, duration: 8)
        let forever = SCNAction.repeatForever(action)
        
        let earthParentRotation = SCNAction.rotateBy(x: 0, y: threeHundredNSixtyDegrees, z: 0, duration: 14)
        let venusParentRotation = SCNAction.rotateBy(x: 0, y: threeHundredNSixtyDegrees, z: 0, duration: 10)
        
        let foreverEarth = SCNAction.repeatForever(earthParentRotation)
        let foreverVenus = SCNAction.repeatForever(venusParentRotation)
        
        
        let earthRotation = SCNAction.rotateBy(x: 0, y: threeHundredNSixtyDegrees, z: 0, duration: 8)
        let venusRotation = SCNAction.rotateBy(x: 0, y: threeHundredNSixtyDegrees, z: 0, duration: 8)
        
        let foreverEarthRotation = SCNAction.repeatForever(earthRotation)
        let foreverVenusRotation = SCNAction.repeatForever(venusRotation)
        
        earth.runAction(foreverEarthRotation)
        venus.runAction(foreverVenusRotation)
        
        
        earthParent.runAction(foreverEarth)
        
        venusParent.runAction(foreverVenus)
        
        
        sun.runAction(forever)
        earthParent.addChildNode(earth)
        venusParent.addChildNode(venus)
        earth.addChildNode(moon)
        venus.addChildNode(venusMoon)
    }
    
    func planet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?, emission: UIImage?, normal: UIImage?, position :SCNVector3) -> SCNNode {
        let planet = SCNNode(geometry: geometry)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180}
}
