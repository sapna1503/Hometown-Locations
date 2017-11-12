//
//  AddNewUserViewController.swift
//  Hometown Locations
//
//  Created by Sapna Chandiramani on 11/2/17.
//  Copyright © 2017 Sapna Chandiramani. All rights reserved.
//

import Foundation
import UIKit

class AddNewUserViewController: UIViewController {

    @IBOutlet weak var txtNickname: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var countryPickerView: UIPickerView!
    @IBOutlet weak var statePickerView: UIPickerView!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtYear: UITextField!
    @IBOutlet weak var txtLatitude: UITextField!
    @IBOutlet weak var txtLongitude: UITextField!



    @IBOutlet weak var btnSubmit: UIButton!

    var latitude: String = "0.0"
    var longitude: String = "0.0"

    var countryArray: [String] = []
    var stateArray: [String] = []
    var selectedCountryName = ""
    var selectedStateName = ""
    var from: Int = 0

    var dataDictionary: [String: Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        txtPassword.isSecureTextEntry = true
        txtYear.delegate = self
        txtYear.keyboardType = UIKeyboardType.decimalPad




        // btnSubmit.isEnabled = false
        fillCountryPickerView()
        fillStatePickerView(selectedCountry: countryArray[0])
        // txtNickname.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        setValues(from: from)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }

    // Open Maps button click
    @IBAction func getLocation(_ sender: Any) {
        if (txtCity.text == "") {
            createAlert(title: "City cannot be empty", message: "Please enter City")
            return
        }
        performSegue(withIdentifier: "segue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        getValues()
        if segue.identifier == "segue" {
            let destination = segue.destination as? MapViewController
            destination?.dataDictionary = dataDictionary
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func getValues()
    {
        dataDictionary = [:]
        dataDictionary["nickname"] = txtNickname.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        dataDictionary["password"] = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        dataDictionary["country"] = countryPickerView.selectedRow(inComponent: 0)
        dataDictionary["state"] = statePickerView.selectedRow(inComponent: 0)
        dataDictionary["city"] = txtCity.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        dataDictionary["year"] = txtYear.text!
        dataDictionary["latitude"] = txtLatitude.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        dataDictionary["longitude"] = txtLongitude.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func setValues(from: Int)
    {
        if(from == 1) {
            txtNickname.text = (dataDictionary["nickname"] as! String)
            txtPassword.text = (dataDictionary["password"] as! String)
            fillCountryPickerView()
            countryPickerView.selectRow(dataDictionary["country"] as! Int, inComponent: 0, animated: true)
            fillStatePickerView(selectedCountry: countryArray[dataDictionary["country"] as! Int])
            statePickerView.selectRow(dataDictionary["state"] as! Int, inComponent: 0, animated: true)
            txtCity.text = (dataDictionary["city"] as! String)
            txtYear.text = (dataDictionary["year"] as! String)
            txtLatitude.text = latitude
            txtLongitude.text = longitude
        }
    }

    private func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in alert.dismiss(animated: true, completion: nil) }))
        self.present(alert, animated: true, completion: nil)
    }


    @IBAction func btnSubmit(_ sender: Any) {
        if validateFields() == false {
            return
        }
        submitDataToServer()
    }

    func validateFields() -> Bool
    {
//        print(txtNickname.text! == "")
//        print(txtPassword.text)
//        print(txtCity.text)
//        print(txtYear.text)
//        print(txtLatitude.text!)
        
        print("1")
//        print(txtNickname.text!)
//         print(txtPassword.text!.count)
        if (txtNickname.text! == "") {
            print(txtNickname.text! == "")
            createAlert(title: "Nickname cannot be empty", message: "Please enter Nickname")
            return false
        }
         
        else {
            let exists = checkNicknameExists(nickName: (txtNickname.text!.trimmingCharacters(in: .whitespacesAndNewlines)))
            if (exists == true) {
                createAlert(title: "Nickname: '\(txtNickname.text!)' already exists", message: "Please enter another Nickname")
                return false
            }
        }
        print("3")
        if (txtPassword.text! == "")  {
            createAlert(title: "Password cannot be empty", message: "Please enter Password")
            return false
        }
        print("4")
        print(txtPassword.text!.count)
        guard txtPassword.text!.count > 3 else {
            createAlert(title: "Password is too short", message: "Passwords must be at least three characters long")
            return false
        }
        print("5")
        if (txtCity.text! == "") {
            createAlert(title: "City cannot be empty", message: "Please enter City")
            return false
        }
        print("6")
        if (txtYear.text! == "") {
            createAlert(title: "Started SDSU in Year cannot be empty", message: "Please enter Started SDSU in Year")
            return false
        }
        print("7")
        guard case (1970...2017) = Int(txtYear.text!)! else {
            createAlert(title: "Year: \(String(describing: txtYear.text)) is invalid", message: "Please enter Year in range of 1970 to 2017")
            return false
        }
        print("8")
        guard case (-90.0...90.0) = Double(txtLatitude.text!)! else {
            createAlert(title: "Latitude: \(txtLatitude.text ?? "") is invalid", message: "Please enter Latitude in range of -90.0 to 90.0")
            return false
        }
        print("9")
        guard case (-180.0...180.0) = Double(txtLongitude.text!)! else {
            createAlert(title: "Longitude: \(String(describing: txtLongitude.text)) is invalid", message: "Please enter Longitude in range of -180.0 to 180.0")
            return false
        }
        return true
    }


    func checkNicknameExists(nickName: String) -> Bool {
        guard let url = URL(string: "https://bismarck.sdsu.edu/hometown/nicknameexists?name=\(nickName)")else { return true }
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Bool
            return json
        } catch {
            print("json error: \(error.localizedDescription)")
            return true
        }
    }

    func submitDataToServer()
    {
        let parameters = ["nickname": txtNickname.text!.trimmingCharacters(in: .whitespacesAndNewlines) as Any,
            "password": txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines) as Any,
            "country": selectedCountryName,
            "state": selectedStateName,
            "city": txtCity.text!.trimmingCharacters(in: .whitespacesAndNewlines),
            "year": Int(txtYear.text!)!,
            "latitude": Double(txtLatitude.text!) ?? 0.0,
            "longitude": Double(txtLongitude.text!) ?? 0.0] as [String: Any]

        print(parameters)

        guard let url = URL(string: "https://bismarck.sdsu.edu/hometown/adduser")
            else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }

            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }

        }.resume()
    }


}

//Custom Text Field to disable Paste action while copied string contains characters other than 0123456789.
//class UICustomTextField: UITextField {
//    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
//            let pasteboardString: String? = UIPasteboard.general.string
//            if let string = pasteboardString {
//                let aSet = NSCharacterSet(charactersIn: "0123456789").inverted
//                let compSepByCharInSet = string.components(separatedBy: aSet)
//                let numberFiltered = compSepByCharInSet.joined(separator: "")
//                return string == numberFiltered
//            }
//        }
//        return super.canPerformAction(action, withSender: sender)
//    }
//}
extension AddNewUserViewController: UITextFieldDelegate
{
    //Nick name exists
    @IBAction func nickNameCheckExists(_ sender: UITextField) {
        let exists = checkNicknameExists(nickName: (sender.text!.trimmingCharacters(in: .whitespacesAndNewlines)))
        guard (exists == false) else {
            createAlert(title: "Nickname: '\(sender.text!)' already exists", message: "Please enter another Nickname")
            return
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }

    //For pwd length > 3
    @IBAction func txtPasswordTextEditingEnd(_ sender: UITextField) {
        guard sender.text!.count > 3 else {
            createAlert(title: "Password is too short", message: "Passwords must be at least three characters long.")
            return
        }
    }


    //For year textbox
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn: "0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }

    //For year textbox
    @IBAction func txtLatitudeEditingEnd(_ sender: UITextField) {
        if(sender.text! == "") {
            sender.text = "0.0"
        }

        let decimalTuples = sender.text!.components(separatedBy: ".")
        if (decimalTuples.count > 2) {
            createAlert(title: "Invalid Input", message: "Please enter in range of -90.0 to 90.0")
            sender.text = "0.0"
        }

        guard case (-90.0...90.0) = Double(sender.text!)! else {
            createAlert(title: "\(String(describing: sender.text)) Latitude is invalid.", message: "Please enter Latitude in range of -90.0 to 90.0")
            return
        }

        let roundedString = String(round(1000000 * Double(sender.text!)!) / 1000000)
        if ((roundedString != "0.0") && ((sender.text)?.contains("."))!) {
            sender.text = roundedString
        }
    }

    //For year textbox
    @IBAction func txtLongitudeEditingEnd(_ sender: UITextField) {
        if(sender.text! == "") {
            sender.text = "0.0"
        }

        let decimalTuples = sender.text!.components(separatedBy: ".")
        if (decimalTuples.count > 2) {
            createAlert(title: "Invalid Input", message: "Please enter in range of -180.0 to 180.0")
            sender.text = "0.0"
        }

        guard case (-180.0...180.0) = Double(sender.text!)! else {
            createAlert(title: "\(String(describing: sender.text)) Longitude is invalid.", message: "Please enter Longitude in range of -180.0 to 180.0")
            return
        }

        let roundedString = String(round(1000000 * Double(sender.text!)!) / 1000000)
        if ((roundedString != "0.0") && ((sender.text)?.contains("."))!) {
            sender.text = roundedString
        }
    }

}




extension AddNewUserViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func fillCountryPickerView()
    {
        guard let url = URL(string: "https://bismarck.sdsu.edu/hometown/countries")else { return }
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let array = json as?[Any] else { return }
            countryArray = array as! [String]
        }
        catch {
            print("Catch block error")
        }
    }

    func fillStatePickerView(selectedCountry: String)
    {
        let stateGetString = "https://bismarck.sdsu.edu/hometown/states?country=" + selectedCountry
        guard let url = URL(string: stateGetString)else { return }
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let array = json as?[Any] else { return }
            stateArray = array as! [String]
        }
        catch {
            print("Catch block error")
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case countryPickerView:
            return countryArray.count
        case statePickerView:
            return stateArray.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case countryPickerView:
            selectedCountryName = countryArray[row]
            return countryArray[row]
        case statePickerView:
            selectedStateName = stateArray[row]
            return stateArray[row]
        default:
            return "Country"
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case countryPickerView:
            fillStatePickerView(selectedCountry: countryArray[row])
            statePickerView.reloadAllComponents()
        default:
            return
        }
    }
}
