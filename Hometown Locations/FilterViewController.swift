//
//  FilterViewController.swift
//  Hometown Locations
//
//  Created by Sapna Chandiramani on 11/7/17.
//  Copyright © 2017 Sapna Chandiramani. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var countryFilterPickerView: UIPickerView!
    @IBOutlet weak var yearFilterPickerView: UIPickerView!

    var personArray = [Person]()
    var countryArray: [String] = []
    var yearArray: [Any] = []
    var selectedCountry: String = ""
    var selectedYear: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        countryFilterPickerView.selectRow(0, inComponent: 0, animated: true)
        fillCountryPickerView()
        fillYearPickerView()
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    func fillCountryPickerView()
    {
        guard let url = URL(string: "https://bismarck.sdsu.edu/hometown/countries")else { return }
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let array = json as?[Any] else { return }
            countryArray = array as! [String]
            countryArray.insert("Select Country", at: 0)
        }
        catch {
            print("Catch block error - Country Picker View: \(error.localizedDescription)")
        }
    }

    func fillYearPickerView()
    {
        for i in 1970...2017 {
            yearArray.append(i)
        }
        yearArray.insert("Select Year", at: 0)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case countryFilterPickerView:
            return countryArray.count
        case yearFilterPickerView:
            return yearArray.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case countryFilterPickerView:
            return countryArray[row]
        case yearFilterPickerView:
            return String(describing: yearArray[row])
        default:
            return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case countryFilterPickerView:
            selectedCountry = countryArray[row]
        case yearFilterPickerView:
            selectedYear = yearArray[row] as! Int
        default:
            return
        }
    }

    func getJSONData(selectedCountry: String, selectedYear: Int)
    {
        var stringURL: String = ""
        if(selectedCountry != "" && selectedYear != 0)
        {
            stringURL = "https://bismarck.sdsu.edu/hometown/users?year=\(selectedYear)&country=\(selectedCountry)"
        }
            else if(selectedCountry != "")
        {
            stringURL = "https://bismarck.sdsu.edu/hometown/users?country=\(selectedCountry)"
        }
            else if(selectedYear != 0)
        {
            stringURL = "https://bismarck.sdsu.edu/hometown/users?year=\(selectedYear)"
        }
            else
        {
            stringURL = "https://bismarck.sdsu.edu/hometown/users"
        }
        guard let url = URL(string: stringURL)else { return }
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            guard let array = json as?[Any] else { return }
            for user in array {
                guard let userDict = user as? [String: Any] else { return }
                guard let nickname = userDict["nickname"] as? String else { return }
                guard let country = userDict["country"] as? String else { return }
                guard let state = userDict["state"] as? String else { return }
                guard let city = userDict["city"] as? String else { return }
                guard let year = userDict["year"] as? Int else { return }
                guard let latitude = userDict["latitude"] as? Double else { return }
                guard let longitude = userDict["longitude"] as? Double else { return }
                personArray.append(Person(nickname: nickname, city: city, state: state, country: country, year: year, latitude: latitude, longitude: longitude))
            }
        }
        catch {
            print("Catch block error")
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "segueExistingUserInMaps")
        {
            let destination = segue.destination as! ExistingUsersInMapViewController
            destination.personArray = personArray
            return
        }
        if segue.identifier == "segueList" {
            let destination = segue.destination as! ViewController
            destination.personArray = personArray
            //destination.selectedCountry = selectedCountry
            //destination.selectedYear = selectedYear
        }
    }

    @IBAction func btnViewInList(_ sender: Any) {
        getJSONData(selectedCountry: selectedCountry, selectedYear: selectedYear)
        performSegue(withIdentifier: "segueList", sender: self)
    }


    @IBAction func btnViewInMaps(_ sender: Any) {
        getJSONData(selectedCountry: selectedCountry, selectedYear: selectedYear)
        performSegue(withIdentifier: "segueExistingUserInMaps", sender: self)
    }
}

class Person: NSObject {
    var nickname: String
    var city: String
    var state: String
    var country: String
    var year: Int
    var latitude: Double
    var longitude: Double



    init(nickname: String, city: String, state: String, country: String, year: Int, latitude: Double, longitude: Double) {
        self.nickname = nickname
        self.city = city
        self.state = state
        self.country = country
        self.year = year
        self.latitude = latitude
        self.longitude = longitude
    }
}

