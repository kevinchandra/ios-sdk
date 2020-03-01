//
//  UserCheckViewController.swift
//  CotterIOS_Example
//
//  Created by Albert Purnama on 2/27/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Cotter

class UserCheckViewController: UIViewController {

    @IBOutlet weak var userDetailsLabel: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    
    var userID = ""
    
    var cb:ResultCallback<CotterUser> = DefaultResultCallback
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.userIDLabel.text = "Client User ID: \(self.userID)"
        

        func enrollCb(response: CotterResult<CotterUser>) {
            switch response {
            case .success(let resp):
                self.userDetailsLabel.text = resp.enrolled.joined(separator: ", ")
            case .failure(let err):
                // we can handle multiple error results here
                print(err.localizedDescription)
            }
        }
        
        self.cb = enrollCb
        
        CotterAPIService.shared.getUser(userID:self.userID, cb:cb)
    }
    
    @IBOutlet weak var textFieldUserID: UITextField!
    
    @IBAction func checkAction(_ sender: Any) {
        guard let userID = self.textFieldUserID.text else { return }
        CotterAPIService.shared.getUser(userID:userID, cb:cb)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
