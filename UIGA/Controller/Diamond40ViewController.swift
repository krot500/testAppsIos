//
//  Diamond40ViewController.swift
//  UIGA
//
//  Created by Nikita Sibirtsev on 17/03/2022.
//

import UIKit

class Diamond40ViewController: UIViewController, ErrorHandlerDelegate {
    
    
    var da40 = Diamond40()

    
    @IBOutlet weak var frontPaxNumber: CustomLabel!
    @IBOutlet weak var rearPaxNumber: CustomLabel!
    @IBOutlet weak var emptyWeightLabel: CustomLabel!
    @IBOutlet weak var totalFuelLabel: CustomLabel!
    @IBOutlet weak var totalFuelWeightLabel: CustomLabel!
    @IBOutlet weak var baggageWeightLabel: CustomLabel!
    
    @IBOutlet weak var emptyWeightSlider: UISlider!
    @IBOutlet weak var totalFuelSlider: UISlider!
    @IBOutlet weak var baggageWeightSlider: UISlider!
    
    @IBOutlet weak var fronPaxStapper: UIStepper!
    @IBOutlet weak var rearPaxStepper: UIStepper!
    
    @IBOutlet weak var calculateButton: CustomButton!
    
    @IBOutlet weak var dencitySignLabel: CustomLabel!
    @IBOutlet weak var fuelDencityTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        frontPaxNumber.text = String(format: "%.0f", da40.pax_front)
        rearPaxNumber.text = String(format: "%.0f", da40.pax_rear)
        emptyWeightLabel.text = String(da40.empty_weight) + " kg"
        totalFuelLabel.text = String(da40.fuel_total) + " l"
        totalFuelWeightLabel.text = String(format: "%.1f", da40.fuelWeight) + " kg"
        baggageWeightLabel.text = String(da40.baggage_total) + " kg"
        emptyWeightSlider.value = Float(da40.empty_weight)
        totalFuelSlider.value = Float(da40.fuel_total)
        baggageWeightSlider.value = Float(da40.baggage_total)
        da40.errorDelegate = self
        
        
        fuelDencityTextField.keyboardType = .decimalPad
        fuelDencityTextField.placeholder = String(format: "%.3f", da40.fuel_dencity)
        dencitySignLabel.text = "kg/m\u{00B3}"
        fuelDencityTextField.delegate = self
        
        
        calculateButton.layer.cornerRadius = 15

    }
    
    
    @IBAction func calculateButton(_ sender: CustomButton) {
        da40.pax_front = Double(fronPaxStapper.value)
        da40.pax_rear = Double(rearPaxStepper.value)
        da40.fuel_total = Double(totalFuelSlider.value)
        da40.baggage_total = Double(baggageWeightSlider.value)
        da40.empty_weight = Double(emptyWeightSlider.value)
        
        if da40.isInputInRange() {
            let cg = da40.centerOfGravity()
            let isCgInRange = da40.isInRange()
            
            let cgString = "CG with fuel = " + String(format: "%.3f", cg.0) + ", CG with no fuel = " + String(format: "%.3f", cg.1) + ". "
            var isInRangeString: String {
                if !isCgInRange.0 {
                    return "Exceeds front margin of CG with fuel"
                }
                if !isCgInRange.1 {
                    return "Exceeds rear margin of CG with  fuel."
                }
                if !isCgInRange.2 {
                    return "Exceeds front margin of CG with no fuel"
                }
                if !isCgInRange.3 {
                    return "Exceeds rear margin of CG with no fuel."
                }
                return "CG is in range."
            }
            print (cgString + isInRangeString)
            let alert = UIAlertController(title: "CG info", message: (cgString + isInRangeString), preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    @IBAction func frontPaxTapper(_ sender: UIStepper) {
        frontPaxNumber.text = String(format: "%.0f", sender.value)
      
    }
    
    @IBAction func rearPaxTapper(_ sender: UIStepper) {
        rearPaxNumber.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func emptyWeightSlider(_ sender: UISlider) {
        emptyWeightLabel.text = String(format: "%.1f", sender.value) + " kg"
        
    }
    
    @IBAction func totalFuel(_ sender: UISlider) {
        totalFuelLabel.text = String(format: "%.1f", sender.value) + " l"
        totalFuelWeightLabel.text = String(format: "%.1f", (da40.fuel_dencity * Double(sender.value))) + " kg"
    }
    
    @IBAction func baggageWeightSlider(_ sender: UISlider) {
        baggageWeightLabel.text = String(format: "%.1f", sender.value) + " kg"
    }
    
    
    func error(error: ListOfErrors) -> Void {
        let str: String = error.returnError()
        let alert = UIAlertController(title: "Error", message: str, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
        return
    }
    
    
}


extension Diamond40ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            if let dencity = Double(text) {
                da40.fuel_dencity = dencity
                totalFuelWeightLabel.text = String(format: "%.1f", (da40.fuel_dencity * Double(totalFuelSlider.value))) + " kg"
            } else {
                error(error: ListOfErrors.incorrectValue)
                textField.text = String(format: "%.3f", da40.fuel_dencity)
            }
        } else {
            textField.text = String(format: "%.3f", da40.fuel_dencity)
        }
    }
}
