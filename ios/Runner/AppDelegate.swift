import UIKit
import Flutter
import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    static let shared = AppDelegate()
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
     GMSServices.provideAPIKey("AIzaSyD0XCuciH1cPNUDLUacKf10YPps8xZF88s")
     

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
   

}
