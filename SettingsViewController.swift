//
//  SettingsViewController.swift
//  CodePathTipApp
//
//  Created by Nathaniel Okun on 3/14/15.
//  Copyright (c) 2015 Nathaniel Okun. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let tipPercentagesKey = "tipPercentages"
    @IBOutlet weak var newTipField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNewSegmentValues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setNewSegmentValues()
    }
    
    func setNewSegmentValues() -> Void {
        var defaults = NSUserDefaults.standardUserDefaults()
        var tipPercentages = defaults.arrayForKey(tipPercentagesKey) as? [Double]
        for var i = 0; i < tipPercentages!.count; i++ {
            var tip = String(format:"%.1f", tipPercentages![i]) + "%"
            tipControl.setTitle(tip, forSegmentAtIndex: i)
        }
    }
    

    @IBAction func newTipSet(sender: AnyObject) {
        //Set defaults in NSUserDefaults
        var defaults = NSUserDefaults.standardUserDefaults()
        var tipPercentages = defaults.arrayForKey(tipPercentagesKey) as? [Double]
        tipPercentages![tipControl.selectedSegmentIndex] = newTipField.text._bridgeToObjectiveC().doubleValue
        defaults.setObject(tipPercentages, forKey: tipPercentagesKey)
        
        newTipField.text = ""   //Clear text
        setNewSegmentValues()   //Set new values
    }
    
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
