//
//  AppDelegate.swift
//  GBKSoftTestApp
//
//  Created by Kateryna on 25.02.2020.
//  Copyright © 2020 Kateryna. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        Coordinator.shared.setWindow(window)
        Coordinator.shared.presentInititalScreen()
        self.window = window
        window.makeKeyAndVisible()
        
        GMSServices.provideAPIKey("AIzaSyAEcddjS9noMPORBHv7To6uinX-P7eywvg")
        GMSPlacesClient.provideAPIKey("AIzaSyAEcddjS9noMPORBHv7To6uinX-P7eywvg")

        GIDSignIn.sharedInstance().clientID = "581337879942-a5afp6okk0jv5c37vjf6bkam4t3qi36g.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        FirebaseApp.configure()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
}

extension AppDelegate: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let _ = error {
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
        } else {
            let userId = user.userID ?? ""
            let idToken = user.authentication.idToken ?? ""
            let fullName = user.profile.name ?? ""
            let givenName = user.profile.givenName ?? ""
            let familyName = user.profile.familyName ?? ""
            let email = user.profile.email ?? ""
            NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"),
                object: nil,
                userInfo: ["userId": userId,
                           "idToken": idToken,
                           "fullName": fullName,
                           "givenName": givenName,
                           "familyName": familyName,
                           "email": email])
        }
    }
}

