//
//  CotterViewController.swift
//  CotterIOS
//
//  Created by Albert Purnama on 2/1/20.
//

import UIKit



public class CotterViewController: UIViewController {
    var parentNavController: UINavigationController?
    var onSuccessView: UIViewController?, onFailureView: UIViewController?
    var apiSecretKey: String="", apiKeyID: String="", cotterURL: String=""
    
    // cotterStoryboard refers to Cotter.storyboard
    // bundleidentifier can be found when you click Pods general view.
    static var cotterStoryboard = UIStoryboard(name:"Cotter", bundle:Bundle(identifier: "org.cocoapods.CotterIOS"))

    // Xcode 7 & 8
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public convenience init() {
        self.init(
            nil,
            nil,
            nil,
            "",
            "",
            ""
        )
    }
    
    public init(_ callbackNav: UINavigationController?, _ successView: UIViewController?, _ failView:UIViewController?, _ apiSecretKey: String, _ apiKeyID: String, _ cotterURL: String ) {
        self.parentNavController = callbackNav
        self.onSuccessView = successView
        self.onFailureView = failView
        self.apiSecretKey = apiSecretKey
        self.apiKeyID = apiKeyID
        self.cotterURL = cotterURL
        super.init(nibName:nil,bundle:nil)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("loaded Cotter SDK")
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func start() {
        // initialize the storyboard
        let cotterVC = CotterViewController.cotterStoryboard.instantiateViewController(withIdentifier: "CotterViewController")as! CotterViewController
        
        // push the viewcontroller to the parent navController
        self.parentNavController?.pushViewController(cotterVC, animated: true)
    }
    
    public func startEnrollment() {
        // initialize the storyboard
        let cotterVC = CotterViewController.cotterStoryboard.instantiateViewController(withIdentifier: "PINViewController")as! PINViewController
        
        // push the viewcontroller to the parent navController
        self.parentNavController?.pushViewController(cotterVC, animated: true)
    }
}


