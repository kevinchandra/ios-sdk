//
//  LocalAuthService.swift
//  CotterIOS
//
//  Created by Raymond Andrie on 2/4/20.
//

import Foundation
import LocalAuthentication

class LocalAuthService {
    
    // Alert Service
    let alertService = AlertService()
    
    // Configs
    let authTitle = "Verifikasi"
    let authBody = "Sentuh sensor sidikjari untuk melanjutkan"
    let authCancel = "Batalkan"
    let authAction = "Input PIN"
    
    let successAuthTitle = "Verifikasi"
    let successAuthMsg = "Sidik jari sesual"
    let successCancel = "Batalkan"
    let successAction = "Input PIN"
    
    let failAuthTitle = "Authentication Failed"
    let failAuthMsg = "You could not be verified; please try again."
    let noAuthMsg = "Your device is not configured for biometric authentication"
    
    var successAuthCallbackFunc: ((String) -> Void)?
    
    // Configure Local Authentication
    public func authenticate(
        view: UIViewController,
        reason: String,
        callback: ((String) -> Void)?
    ) {
        let context = LAContext()
        var error: NSError?
        
        successAuthCallbackFunc = callback
        
        // Show Biometric Alert
        let biometricAlert = self.alertService.createDefaultAlert(title: self.authTitle, body: self.authBody, actionText: self.authAction, cancelText: self.authCancel)
        view.present(biometricAlert, animated: true) {
            // Check if we can use biometrics
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                // Dismiss Biometric Alert
                biometricAlert.dismiss(animated: true) {
                    context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self, weak view] success, authenticationError in
                        DispatchQueue.main.async {
                            self?.dispatchResult(view: view, success: success, authError: authenticationError)
                        }
                    }
                }
            } else {
                // No biometrics for device
                print("No biometrics available for device!")
                let noBiometricAlert = self.alertService.createDefaultAlert(title: self.authTitle, body: self.noAuthMsg, actionText: self.authAction, cancelText: self.authCancel)
                view.present(noBiometricAlert, animated: true)
                
                // TODO: Go to Input PIN Page?
            }
        }
    }
    
    private func dispatchResult(view: UIViewController?, success: Bool, authError: Error?) {
        if success {
            print("Successful local authentication!")
            // Give Success Alert
            let successAlert = self.alertService.createDefaultAlert(title: self.successAuthTitle, body: self.successAuthMsg, actionText: self.authAction, cancelText: self.authCancel)
            view?.present(successAlert, animated: true)
            // Dismiss Alert after 3 seconds, then run callback
            let timer = DispatchTime.now() + 3
            DispatchQueue.main.asyncAfter(deadline: timer) {
                successAlert.dismiss(animated: true) {
                    // Run callback
                    self.successAuthCallbackFunc?("This is token!")
                }
            }
        } else {
            // Give Failed Authentication Alert
            print("Failed local authentication!")
            let failedBiometricAlert = self.alertService.createDefaultAlert(title: self.authTitle, body: self.failAuthMsg, actionText: self.authAction, cancelText: self.authCancel)
            view?.present(failedBiometricAlert, animated: true)
            
            // TODO: Allow user to Input PIN instead?
        }
    }
}
