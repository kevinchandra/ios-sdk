//
//  PINFinalViewController.swift
//  CotterIOS
//
//  Created by Albert Purnama on 2/3/20.
//

import Foundation

class PINFinalViewController: UIViewController {
    public var config: Config?
    
    @IBAction func finish(_ sender: Any) {
        // set access token or return values here
        self.config?.callbackFunc!("this is token")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Remove default Nav controller styling
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}