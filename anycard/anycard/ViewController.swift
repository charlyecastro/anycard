//
//  ViewController.swift
//  anycard
//
//  Created by Charlye Castro on 2/15/20.
//  Copyright © 2020 Charlye Castro. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, UpdateCardDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var modelController: ModelController!
    var card: PlayingCard!
    var plane: SCNPlane!
    
    @IBAction func handleSnap(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(self.sceneView.snapshot(), nil, nil, nil)
    }
    
    func updateCard(cardImage: String) {
        self.plane.firstMaterial?.diffuse.contents = UIImage(named: cardImage)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        card = modelController.card
        plane = SCNPlane(width: 0, height: 0)
    }
    
    @objc func advance() {
        let vc = SettingsViewController()
        vc.delegate = self   }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARImageTrackingConfiguration()
        
        card = modelController.card
        if let trackingImages = ARReferenceImage.referenceImages(inGroupNamed: "Card Deck", bundle: Bundle.main) {
            configuration.trackingImages = trackingImages
            configuration.maximumNumberOfTrackedImages = 2

        }
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsViewController = segue.destination as? SettingsViewController {
            settingsViewController.modelController = modelController
            settingsViewController.delegate = self
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            let size = imageAnchor.referenceImage.physicalSize
            plane = SCNPlane(width: size.width, height: size.height)
            card = modelController.card
            plane.firstMaterial?.diffuse.contents = UIImage(named: card.image)
            plane.cornerRadius = 0.005
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            node.addChildNode(planeNode)
        }
        return node
    }

}

