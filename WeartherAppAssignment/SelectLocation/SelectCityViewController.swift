//
//  SelectCityViewController.swift
//  WeartherAppAssignment
//
//  Created by Rahul Parashar on 28/01/19.
//  Copyright © 2019 Rahul Parashar. All rights reserved.
//


import UIKit

class SelectCityViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var noRecordFoundLabel: UILabel!
    
    var locationList : Array<[String:Any]>!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        locationList = UserDefaults.standard.object(forKey: klocationArray) as? Array<[String:Any]>
        tblView.tableFooterView = UIView()
    }

    
     // MARK: - Actions
    
    @IBAction func addLocationBtnAction(_ sender: Any) {
        let selectLocationOnMapVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectLocationOnMapVC") as! SelectLocationOnMapVC
        selectLocationOnMapVC.delagate = self;
        navigationController?.present(selectLocationOnMapVC, animated: true, completion: nil)
    }
    
    @IBAction func helpBtnAction(_ sender: Any) {
        let appInfoVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppInfoVC") as!  AppInfoVC
        navigationController?.present(appInfoVC, animated: true, completion: nil)
    }
}

extension SelectCityViewController : SelectLocationOnMapVCDelegate {
    func refreshLocationList() {
        locationList = UserDefaults.standard.object(forKey: klocationArray) as? Array<[String:Any]>
        tblView.reloadData()
    }
}


    // MARK: - Tableview Delegate & Datasource Methods

extension SelectCityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        noRecordFoundLabel.isHidden = true

        if locationList == nil || locationList.count == 0 {
            noRecordFoundLabel.isHidden = false
            return 0
        }
        return locationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       var cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cellID")
            cell?.selectionStyle = .none
        }
        let dict = locationList[indexPath.row]
        cell?.textLabel?.text = dict[kcity] as? String ?? ""
        
            // Set row color of Tableview
        cell?.contentView.backgroundColor = UIColor(red: 102/255, green: 179/255, blue: CGFloat(200 + indexPath.row*10)/255, alpha: 1.0)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherInfoViewController") as! WeatherInfoViewController
        vc.locationDict = locationList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // Delete Row
            let userDefaults = UserDefaults.standard
            locationList.remove(at: indexPath.row)
            userDefaults.set(locationList, forKey: klocationArray)
            userDefaults.synchronize()
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
        else{
            //  Do nothing
        }
    }
}


