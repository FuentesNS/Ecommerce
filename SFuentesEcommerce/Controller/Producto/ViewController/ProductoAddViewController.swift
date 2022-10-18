//
//  ProductoAddViewController.swift
//  SFuentesEcommerce
//
//  Created by MacBookMBA1 on 14/10/22.
//

import UIKit
import RadioGroup

class ProductoAddViewController: UIViewController {

    @IBOutlet var radioGroup: RadioGroup!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        radioGroup = RadioGroup(titles: ["One", "Two", "Three"])
        radioGroup.selectedIndex = 0

        
        radioGroup.tintColor = .green // surrounding ring
        radioGroup.selectedColor = .red // center circle
        
        radioGroup.buttonSize = 42.0
        radioGroup.spacing = 12 // vertical spacing between options
        radioGroup.itemSpacing = 12 // horizontal spacing between button and title

    }
    
    @objc func didSelectOption(radioGroup: RadioGroup) {
           print(radioGroup.titles[radioGroup.selectedIndex] ?? "")
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
