//
//  ViewController.swift
//  task3
//
//   
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var trainingsSegmentControl: UISegmentedControl!
    @IBOutlet weak var sexSegmentControl: UISegmentedControl!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBAction func calculateTapped(_ sender: Any) {
        
        
        guard let weightText = weightTextField.text,
              let weight = Double(weightText),
              let heightText = heightTextField.text,
              let height = Double(heightText),
              let ageText = ageTextField.text,
              let age = Int(ageText),
              height > 0, age > 0 else {
            resultLabel.text = "Введите корректные данные"
            return
        }
        
   
        let heightInMeters = height / 100
        let bmi = weight / pow(heightInMeters, 2)
        let formattedBMI = String(format: "%.1f", bmi)
        
        
        let isMale = sexSegmentControl.selectedSegmentIndex == 0
        let trainingFrequency = trainingsSegmentControl.selectedSegmentIndex
        
        
        let bmr: Double
        if isMale {
            bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * Double(age))
        } else {
            bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * Double(age))
        }
        
        
        let activityMultiplier: Double
        switch trainingFrequency {
        case 0: activityMultiplier = 1.2
        case 1: activityMultiplier = 1.375
        case 2: activityMultiplier = 1.55
        case 3: activityMultiplier = 1.725
        default: activityMultiplier = 1.2
        }
        
        let calories = Int(bmr * activityMultiplier)
        
        
        resultLabel.text = """
        ИМТ: \(formattedBMI)
        Потребность: \(calories) ккал/день
        """
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

