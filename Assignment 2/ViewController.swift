//
//  ViewController.swift
//  Assignment 2
//
//  Created by Vanessa Aguilar on 9/26/20.
//  Copyright © 2020 Personal Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
 
    
//MARK:Outlets
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var amountTip: UILabel!
    @IBOutlet weak var percentageTip: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var partySizeSlider: UISlider!
    @IBOutlet weak var partySizeLabel: UILabel!
    @IBOutlet weak var partySplitAmountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    ///Make sure the keyboard is no longer displayed when the user clicks away
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    
// Class to detect / only update bill amount when the keyboard is dissmissed 
  
//MARK: Messages from Model
///Key Components to update the view, so you can know that something changed in the model
    
    ///Wheneveer a new Bill amount was inserted it will get detected
    var billAmount = 0.0{
        didSet{
            updateView()
        }
    }
    ///Whenver a new percentage is specified it will get detected, default will 20 percent if none is specified
    var percentagePicked = 20 {
        didSet{
            
            updateView()
        }
    }
    ///Whenever a new amount of people to split the bill is specified it will get detected , default will be 1 if none is specified
    var partyPicked = 1{
        didSet{
            updateView()
        }
    }
    
    
    
//MARK: Actions
    ///Action is Working when the user types in how much their bill was
    @IBAction func amountTyped(_ sender: UITextField) {
        ///Will convert the text field string into a double
        billAmount = (sender.text! as NSString).doubleValue
     
    }
    
    ///Functions will work with grabbing the new percentage specified from the slider
    @IBAction func percentageSliderPicked(_ sender: UISlider) {
        percentagePicked = Int(sender.value) * 5
        
    }
    
    ///Function will work with grabbing how many people are going to split the bill
    @IBAction func partySizeSlider(_ sender: UISlider) {
        partyPicked = Int(sender.value)
    }
    
    
//MARK: Functions
    ///Function will take care of updating the view to the user
    func updateView(){
        ///Calculations
        
        //Will Calculate the amount of the bill x How much user want to tip
        let tipCalculated = (billAmount * Double(percentagePicked))/100
        
        
        let totaAmount = billAmount + tipCalculated
        let eachpay = totaAmount / Double(partyPicked)
       
        ///Will take care of Formatting the numeric values that will be displayed
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        
        ///Updates The label
        percentageTip.text = "\(percentagePicked)%" // Tip
        partySizeLabel.text = "\(partyPicked)"  //Party
        
        amountTip.text = "\(numberFormatter.string(from: NSNumber(value: totaAmount))!)" //After Calculations on the tip amount
        
        partySplitAmountLabel.text = "\(numberFormatter.string(from: NSNumber(value: eachpay))!) "
        
    }
    

}
