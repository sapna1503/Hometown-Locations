//
//  ViewController.swift
//  Hometown Locations
//
//  Created by Sapna Chandiramani on 10/31/17.
//  Copyright © 2017 Sapna Chandiramani. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var personArray = [Person]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.isPagingEnabled = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableviewCell else { return UITableViewCell() }
        self.tableView.rowHeight = 100
        
        cell.lblNickname.text = "Nickname: " + personArray[indexPath.row].nickname
        cell.lblCityState.text = "City, State : " + personArray[indexPath.row].city + ", " + personArray[indexPath.row].state
        cell.lblCountry.text = "Country : " + personArray[indexPath.row].country
        cell.lblYear.text = "Started SDSU in Year : " + String (personArray[indexPath.row].year)
        
        if(indexPath.row % 2 == 0)
        { cell.backgroundColor = UIColor.lightGray }
        else
        { cell.backgroundColor = UIColor.white }
        
        return cell
    }

//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,forRowAt indexPath: IndexPath)
//    {
//        let dataArray = personArray[0..<10]
//        let lastItem = dataArray.count - 1
//        if indexPath.row == lastItem{
//        }
//    }
//    
//    func loadMoreData(){
//        let x = personArray.count
//        for i in  0..<x {
//            let lastitem = personArray[0..<10]
//            
//        }
//        
//        
//    }
    
    @IBAction func btnBack(_ sender: Any) {
        //performSegue(withIdentifier: "segueListToFilter", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "segueListToFilter" {
//            let destination = segue.destination as? FilterViewController
//            destination?.selectedCountry = selectedCountry
//            destination?.selectedYear = selectedYear
//        }
//    }
    
    //=================For Pagination ========//
    
   
    
}


//extension ViewController:UITableViewDataSource{
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return  self.data.count + 1
//    }
//
//
//}



