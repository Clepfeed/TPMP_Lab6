//
//  ViewController.swift
//  task1
//
//
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundSwitch: UISwitch!
    
    @IBOutlet weak var switchLabel: UILabel!
    
    @IBAction func backgroundSwitchTapped(_ sender: Any) {
        if backgroundSwitch.isOn
         {
            switchLabel.text = "Background image: bg1.jpg"
         view.backgroundColor = UIColor(patternImage: UIImage(named:"bg1")!)
         }
        else
         {
            switchLabel.text = "Background image: bg2.jpg"
            view.backgroundColor = UIColor(patternImage: UIImage(named: "bg2")!)
         }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchLabel.text = "Background image: bg1.jpg"
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg1")!)
    }


}

