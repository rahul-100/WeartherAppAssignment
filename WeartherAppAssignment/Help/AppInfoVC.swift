//
//  AppInfoVC.swift
//  WeartherAppAssignment
//
//  Created by Rahul Parashar on 28/01/19.
//  Copyright © 2019 Rahul Parashar. All rights reserved.
//

import UIKit
import JavaScriptCore

class AppInfoVC: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Webview: - Loading help information
        
        self.loadHtmlData();
    }
    
        //MARK:- Method
    func loadHtmlData() {
        webView.loadHTMLString("<!DOCTYPE html><html><title>HTML Tutorial</title><body><p> \n  &nbsp There are total three view in the application <ul><li>Home</li> <li>City</li> <li>Select Location</li></ul> &nbsp &nbsp On <b>Home</b> user can add city by clicking <b>'+'</b> button on top of navigation bar and after adding city he/she can see information like current temperature, wind, rain, humidity. <br><br> &nbsp &nbsp  On clicking the <b>'+'</b> button user will be navigated to map screen, where user can <b>zoom</b>(with two finger gesture) the map and drop a pin to select his/her interest location. On pressing <b>Done</b> button, his/her location will be added on home screen. User can delete the city added by left swiping the city row(<b>default delete behaviour of iOS device</b>). <br><br> &nbsp &nbsp On clicking the city row, user will be navigated to new view where he/she can see current temperature, wind, rain, humidity info with next <b>5-day forecast</b>. There is one button <b>C/F</b> on top of City screen which shows user temperature in Celcius/Fahrenheit.</p></body></html>", baseURL: nil)
    }
    
    // MARK: - Actions
    
     @IBAction func doneBtnAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}
