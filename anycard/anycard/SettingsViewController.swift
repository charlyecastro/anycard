//
//  SettingsViewController.swift
//  anycard
//
//  Created by Charlye Castro on 2/15/20.
//  Copyright © 2020 Charlye Castro. All rights reserved.
//

import UIKit

protocol UpdateCardDelegate {
   func updateCard(cardImage: String)
}

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var delegate: UpdateCardDelegate? = nil
    var imageName = ""
    var modelController: ModelController!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rankPicker: UIPickerView!
    private let rankList = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "J", "Q", "K"]

        
    @IBOutlet weak var suitLabel: UILabel!
    @IBOutlet weak var suitPicker: UIPickerView!
    private let suitList = ["Heart", "Spade", "Diamond", "Club"]

    override func viewDidLoad() {
        super.viewDidLoad()
        rankLabel.text = modelController.card.rank
        suitLabel.text = modelController.card.suit
        
        cardImage.image = UIImage(named: modelController.card.image)
        self.rankPicker.delegate = self as UIPickerViewDelegate
        self.rankPicker.dataSource = self as UIPickerViewDataSource
        
        self.suitPicker.delegate = self as UIPickerViewDelegate
        self.suitPicker.dataSource = self as UIPickerViewDataSource
    }
    
    func updateCardImage() {
        self.imageName = rankLabel.text! + suitLabel.text!.prefix(1)
        let newCard = PlayingCard(rank: rankLabel.text!, suit: suitLabel.text!, image: imageName)
        modelController.card = newCard
        cardImage.image = UIImage(named: modelController.card.image)
    }
    
    @IBAction func handleSave(_ sender: UIButton) {
        updateCardImage()
        self.delegate?.updateCard(cardImage: self.imageName)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeSettings(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return rankList.count
        } else {
            return suitList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return rankList[row]
        } else {
            return suitList[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            rankLabel.text = rankList[row]
        } else {
            suitLabel.text = suitList[row]
        }
        updateCardImage()
    }
}



    
    
