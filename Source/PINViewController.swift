//
//  PINViewController.swift
//  CotterIOS
//
//  Created by Albert Purnama on 2/2/20.
//

import Foundation
import UIKit

public class PINViewController : UIViewController {
    let closeTitle = "Yakin tidak Mau Buat PIN Sekarang?"
    let closeMessage = "PIN Ini diperlukan untuk keamanan akunmu, lho."
    let stayText = "Input PIN"
    let leaveText = "Lain Kali"
    
    // Code Text Field
    @IBOutlet weak var codeTextField: OneTimeCodeTextField!
    
    // PIN Visibility Toggle Button
    @IBOutlet weak var pinVisibilityButton: UIButton!
    let showPinText = "Lihat PIN"
    let hidePinText = "Sembunyikan"
    
    // Error Label
    @IBOutlet weak var errorLabel: UILabel!
    var showErrorMsg = false
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("loaded PIN Cotter View")
        
        // Implement Custom Back Button instead of default in Nav controller
        self.navigationItem.hidesBackButton = true
        let crossButton = UIBarButtonItem(title: "\u{2717}", style: UIBarButtonItem.Style.plain, target: self, action: #selector(PINViewController.promptClose(sender:)))
        crossButton.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = crossButton
        
        // Configure PIN Visibility Button
        configurePinVisButton()
        
        // Add Password Code Text Field
        codeTextField.configure()
        
        // Configure Error Msg Label
        configureErrorMsg()
        
        // Instantiate Function to run when user enters wrong PIN code
        codeTextField.removeErrorMsg = {
            // Remove error msg if it is present
            if self.showErrorMsg {
                self.toggleErrorMsg()
            }
        }
        
        // Instantiate Function to run when PIN is fully entered
        codeTextField.didEnterLastDigit = { code in
            print("PIN Code Entered: ", code)
            // Test: If code is 123456, show error. Else, is fine
            if code == "123456" {
                // Show errors, hide button
                self.toggleErrorMsg()
            }
            
            // TODO: Check for basic errors such as repeating digits and straight digits
            
            // TODO: Run API to check whether PIN is correct
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Open Keypad on View Appearance
        codeTextField.becomeFirstResponder()
    }
    
    private func configurePinVisButton() {
        pinVisibilityButton.setTitleColor(UIColor(red: 0.0196, green: 0.4275, blue: 0, alpha: 1.0), for: .normal)
        pinVisibilityButton.setTitle(showPinText, for: .normal)
        pinVisibilityButton.isHidden = false
    }
    
    private func configureErrorMsg() {
        errorLabel.isHidden = true
        errorLabel.textColor = UIColor(red: 0.8392, green: 0, blue: 0, alpha: 1.0)
    }
    
    private func toggleErrorMsg() {
        showErrorMsg.toggle()
        errorLabel.isHidden.toggle()
        pinVisibilityButton.isHidden.toggle()
    }
    
    @IBAction func onClickPinVis(_ sender: UIButton) {
        codeTextField.togglePinVisibility()
        if sender.title(for: .normal) == showPinText {
            sender.setTitle(hidePinText, for: .normal)
        } else {
            sender.setTitle(showPinText, for: .normal)
        }
    }
    
    @objc private func promptClose(sender: UIBarButtonItem) {
        // Perform Prompt Alert
        createAlert(title: closeTitle, message: closeMessage, stayText: stayText, leaveText: leaveText)
    }
    
    // Alert Function for when User clicks close Pin Verification View
    public func createAlert(title: String, message: String, stayText: String, leaveText: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: leaveText, style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: {
                // Go back to previous screen
                self.navigationController?.popViewController(animated: true)
            })
        }))
        
        alert.addAction(UIAlertAction(title: stayText, style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
