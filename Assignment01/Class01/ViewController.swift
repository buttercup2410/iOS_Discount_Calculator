//
//  ViewController.swift
//  Class01
//
//  Created by Nishi Mewada on 25/01/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        reset()
    }

    @IBOutlet weak var uiPriceTextField: UITextField!
    @IBOutlet weak var uiSlider: UISlider!
    @IBOutlet weak var uiSliderLabel: UILabel!
    @IBOutlet weak var uiDiscount: UILabel!
    @IBOutlet weak var uiFinalPrice: UILabel!
    @IBOutlet weak var uiSaleSegment: UISegmentedControl!
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay",style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func reset(){
        uiPriceTextField.text = ""
        uiSlider.setValue(25.00, animated: true)
        uiSliderLabel.text = String(uiSlider.value).prefix(2) + "%"
        uiDiscount.text = String(format: "%.2f", 0.00)
        uiFinalPrice.text = String(format: "%.2f", 0.00)
        uiSaleSegment.selectedSegmentIndex = 0
        uiSlider.isEnabled = false
    }
    
    func calculate() {
        if let price = uiPriceTextField.text, !price.isEmpty {
            if let price = Int(price) {
                var discountValue = Double(0)
                let selectedSegment = uiSaleSegment.selectedSegmentIndex
                if  selectedSegment == 0 {
                    discountValue = 0.10
                } else if selectedSegment == 1 {
                    discountValue = 0.15
                } else if selectedSegment == 2 {
                    discountValue = 0.18
                } else {
                    discountValue = Double(Int(uiSlider.value)) * Double(0.01)
                }
                let calculatedDiscount = Double(price) * Double(discountValue)
                let finalPrice = Double(price) - calculatedDiscount
                uiDiscount.text = String(format: "%.2f", calculatedDiscount)
                uiFinalPrice.text = String(format: "%.2f", finalPrice)
            } else {
                print("Invalid price format")
                showAlert(message: "Invalid Price format")
            }
        } else {
            showAlert(message: "Enter Item Price")
        }
    }
    
    @IBAction func uiSaleSegment(_ sender: UISegmentedControl) {
        let _ = String(sender.titleForSegment(at: sender.selectedSegmentIndex)!)
        if sender.selectedSegmentIndex == 3 {
            uiSlider.isEnabled = true
        }
    }
    
    @IBAction func uiSlider(_ sender: UISlider) {
        let sliderValue = String(sender.value)
        self.uiSliderLabel.text = sliderValue.prefix(2) + "%"
    }
    
    
    @IBAction func uiResetButton(_ sender: Any) {
        reset()
    }
    
    @IBAction func uiCalculateButton(_ sender: Any) {
        calculate()
    }
}
