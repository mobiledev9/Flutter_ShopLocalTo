import UIKit
import Flutter
import GoogleMaps
import FBSDKCoreKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    static let shared = AppDelegate()

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
     GMSServices.provideAPIKey("AIzaSyD0XCuciH1cPNUDLUacKf10YPps8xZF88s")
       ApplicationDelegate.shared.application(
                 application,
                 didFinishLaunchingWithOptions: launchOptions
             )

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    override func application(
           _ app: UIApplication,
           open url: URL,
           options: [UIApplication.OpenURLOptionsKey : Any] = [:]
       ) -> Bool {
           ApplicationDelegate.shared.application(
               app,
               open: url,
               sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
               annotation: options[UIApplication.OpenURLOptionsKey.annotation]
           )
       }

}
