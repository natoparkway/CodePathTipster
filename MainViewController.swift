//
//  ViewController.swift
//  CodePathTipApp
//
//  Created by Nathaniel Okun on 3/14/15.
//  Copyright (c) 2015 Nathaniel Okun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let tipPercentagesKey = "tipPercentages"
    let defaultPercentages = [18, 20, 22]

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("hi")
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(defaultPercentages, forKey: tipPercentagesKey)
        setNewSegmentValues()
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setNewSegmentValues()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     * When user has changed the bill amount in the field.
     */
    @IBAction func onEditingChanged(sender: AnyObject) {
        var defaults = NSUserDefaults.standardUserDefaults()
        var tipPercentages = defaults.arrayForKey(tipPercentagesKey) as? [Double]
        var tipPercentage = tipPercentages![tipControl.selectedSegmentIndex]
        
        var billAmount = billField.text._bridgeToObjectiveC().doubleValue
        var tip = billAmount * tipPercentage / 100
        var total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        //NOTE: Only gets 1 decimal point
        //tipLabel.text = "$\(tip)"
        //totalLabel.text = "$\(total)"
    }
    
    /*
     * Sets the values of the Segment Controller to those indicated in NSUserDefaults.
     */
    func setNewSegmentValues() -> Void {
        var defaults = NSUserDefaults.standardUserDefaults()
        var tipPercentages = defaults.arrayForKey(tipPercentagesKey) as? [Double]
        for var i = 0; i < tipPercentages!.count; i++ {
            var tip = String(format:"%.1f", tipPercentages![i]) + "%"
            tipControl.setTitle(tip, forSegmentAtIndex: i)
        }
    }

    //Removes keyboard on tap
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }


}

