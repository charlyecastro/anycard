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
    @IBOutlet weak var selectedCardLabel: UILabel!
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var rankPicker: UIPickerView!
    @IBOutlet weak var suitPicker: UIPickerView!
    
    private let rankList = ["Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King"]
    private let suitList = ["Spade", "Heart", "Diamond", "Club"]

    private var selectedRank : String = ""
    private var selectedSuit : String = ""
    private var rankIndex: Int = 0
    private var suitIndex: Int = 0
        

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedRank = modelController.card.rank
        selectedSuit = modelController.card.suit
        rankIndex = modelController.card.rankIndex
        suitIndex = modelController.card.suitIndex
        
        selectedCardLabel.text = selectedRank + " of " + selectedSuit + "s"
        
        cardImage.image = UIImage(named: modelController.card.image)
        self.rankPicker.delegate = self as UIPickerViewDelegate
        self.rankPicker.dataSource = self as UIPickerViewDataSource
        
        self.suitPicker.delegate = self as UIPickerViewDelegate
        self.suitPicker.dataSource = self as UIPickerViewDataSource
        
        self.suitPicker.selectRow(suitIndex, inComponent:0, animated:true)
        self.rankPicker.selectRow(rankIndex, inComponent:0, animated:true)
    }
    
    func updateCardImage() {
        selectedCardLabel.text = selectedRank + " of " + selectedSuit + "s"
        self.imageName = selectedRank + selectedSuit.prefix(1)
        let newCard = PlayingCard(rank: selectedRank, suit: selectedSuit, image: imageName, rankIndex: rankIndex, suitIndex: suitIndex)
        modelController.card = newCard
        cardImage.image = UIImage(named: modelController.card.image)
    }
    
    @IBAction func doneClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
            rankIndex = row
            return rankList[row]
        } else {
            suitIndex = row
            return suitList[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            rankIndex = row
            selectedRank = rankList[row]
        } else {
            suitIndex = row
            selectedSuit = suitList[row]
        }
        updateCardImage()
    }
}



    
    
