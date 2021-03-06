//
//  APIServiceProtocol.swift
//  Cotter
//
//  Created by Raymond Andrie on 5/10/20.
//

import Foundation

public protocol APIService : MockedService {
    func auth(userID: String, issuer: String, event: String, code: String, method: String, pubKey: String?, timestamp: String, cb: @escaping ResultCallback<CotterEvent>)
    func registerUser(userID: String, cb: @escaping ResultCallback<CotterUser>)
    func enrollUserPin(code: String, cb: @escaping ResultCallback<CotterUser>)
    func updateUserPin(oldCode: String, newCode: String, cb: @escaping ResultCallback<CotterUser>)
    func getBiometricStatus(cb: @escaping ResultCallback<EnrolledMethods>)
    func updateBiometricStatus(enrollBiometric: Bool, cb: @escaping ResultCallback<CotterUser>)
    func requestToken(codeVerifier: String, challengeID: Int, authorizationCode: String, redirectURL: String, cb: @escaping ResultCallback<CotterIdentity>)
    func getUser(userID: String, cb: @escaping ResultCallback<CotterUser>)
    func registerBiometric(userID: String, pubKey: String, cb: @escaping ResultCallback<CotterUser>)
    func requestPINReset(name: String, sendingMethod: String, sendingDestination: String, cb: @escaping ResultCallback<CotterResponseWithChallenge>)
    func verifyPINResetCode(resetCode: String, challengeID: Int, challenge: String, cb: @escaping ResultCallback<CotterBasicResponse>)
    func resetPIN(resetCode: String, newCode: String, challengeID: Int, challenge: String, cb: @escaping ResultCallback<CotterBasicResponse>)
    func enrollTrustedDevice(clientUserID: String, cb: @escaping ResultCallback<CotterUser>)
    func getNewEvent(userID: String, cb: @escaping ResultCallback<CotterEvent?>)
    func getTrustedDeviceStatus(clientUserID: String, cb: @escaping ResultCallback<EnrolledMethods>)
    func getTrustedDeviceEnrolledAny(userID: String, cb: @escaping ResultCallback<EnrolledMethods>)
    func reqAuth(clientUserID: String, event: String, cb: @escaping ResultCallback<CotterEvent>)
    func getEvent(eventID:String, cb: @escaping ResultCallback<CotterEvent>)
    func approveEvent(event: CotterEvent, cb: @escaping ResultCallback<CotterEvent>)
    func registerOtherDevice(qrData:String, userID:String, cb: @escaping ResultCallback<CotterEvent>)
    func removeTrustedDeviceStatus(userID: String, cb: @escaping ResultCallback<CotterUser>)
    func getNotificationAppID(cb: @escaping ResultCallback<CotterNotificationCredential>)
    
    // enrollTrustedDeviceWith cotter's user ID, this indicates that a user has been created in cotter's server and we would like
    // to enroll trusted device on that user
    func enrollTrustedDeviceWith(cotterUser: CotterUser, cb: @escaping ResultCallback<CotterUser>)
    
    // reqAuthWith does exactly what reqAuth do but with different parameters
    func reqAuthWith(cotterUserID: String, event: String, cb: @escaping ResultCallback<CotterEvent>)
    
    func getTrustedDeviceStatusWith(cotterUserID: String, cb: @escaping ResultCallback<EnrolledMethods>)
}
