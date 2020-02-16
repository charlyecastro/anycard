//
//  SettingsViewController.swift
//  anycard
//
//  Created by Charlye Castro on 2/15/20.
//  Copyright © 2020 Charlye Castro. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

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
        
        self.rankPicker.delegate = self as UIPickerViewDelegate
        self.rankPicker.dataSource = self as UIPickerViewDataSource
        
        self.suitPicker.delegate = self as UIPickerViewDelegate
        self.suitPicker.dataSource = self as UIPickerViewDataSource
    }
    
    @IBAction func handleSave(_ sender: UIButton) {
        let imageName = rankLabel.text! + suitLabel.text!.prefix(1)
        let newCard = PlayingCard(rank: rankLabel.text!, suit: suitLabel.text!, image: imageName)
        modelController.card = newCard
        cardImage.image = UIImage(named: imageName)
        
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
    }
}


    
    
