//
//  SettingsViewController.swift
//  anycard
//
//  Created by Charlye Castro on 2/15/20.
//  Copyright © 2020 Charlye Castro. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var rankPicker: UIPickerView!
    var rankList = [""]
        
    @IBOutlet weak var suitLabel: UILabel!
    @IBOutlet weak var suitPicker: UIPickerView!
    var suitList = [""]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if pickerView == rankPicker {
//            return rankList.count
//        } else {
            return suitList.count
       // }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if pickerView == rankPicker {
//            return rankList[row]
//        } else {
            return suitList[row]
     //   }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if pickerView == rankPicker {
//            rankLabel.text = rankList[row]
//        } else {
            suitLabel.text = suitList[row]
        //}
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rankList = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "J", "Q", "K"]
        suitList = ["Heart", "Spade", "Diamond", "Club"]
    }
    
    @IBAction func closeSettings(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
