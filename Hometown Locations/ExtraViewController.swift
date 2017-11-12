//
//  ExtraViewController.swift
//  Hometown Locations
//
//  Created by Sapna Chandiramani on 11/9/17.
//  Copyright © 2017 Sapna Chandiramani. All rights reserved.
//

import UIKit

class ExtraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//1
    //    func isValidName(_ nameString: String) -> Bool {
    //        var returnValue = true
    //        let mobileRegEx =  "[A-Za-z]{3}"  // {3} -> at least 3 alphabet are compulsory.
    //
    //        do {
    //            let regex = try NSRegularExpression(pattern: mobileRegEx)
    //            let nsString = nameString as NSString
    //            let results = regex.matches(in: nameString, range: NSRange(location: 0, length: nsString.length))
    //
    //            if results.count == 0
    //            {
    //                returnValue = false
    //            }
    //
    //        } catch let error as NSError {
    //            print("invalid regex: \(error.localizedDescription)")
    //            returnValue = false
    //        }
    //
    //        return  returnValue
    //    }

//2
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        //        let countdots = textField.text!.components(separatedBy: ".").count - 1
//        //        if countdots > 0 && string == "." {
//        //            return false
//        //        }
//        let aSet = NSCharacterSet(charactersIn: "0123456789").inverted
//        let compSepByCharInSet = string.components(separatedBy: aSet)
//        let numberFiltered = compSepByCharInSet.joined(separator: "")
//        return string == numberFiltered
//    }
}
