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

    var imageName = "AS"
    @IBOutlet var sceneView: ARSCNView!
    var modelController: ModelController!
    var card: PlayingCard!
    var plane: SCNPlane!
    
    @IBAction func handleSnap(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(self.sceneView.snapshot(), nil, nil, nil)
        print(card.image)
        
    }
    
    func updateCard(cardImage: String) {
        print(cardImage)
        self.plane.firstMaterial?.diffuse.contents = UIImage(named: cardImage)
        print("WE ARE HERE! WE MADE IT!!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        card = modelController.card
        plane = SCNPlane(width: 2.5, height: 3.5)

        print("viewDidLoad")
        
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
        print("viewWillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
        print("viewWillDisappear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear")
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
            print(card.image)
            plane.cornerRadius = 0.005
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            node.addChildNode(planeNode)
        }
        
        return node
    }

}

