import Flutter
import UIKit
import FirebaseCore // Add this if you haven't already, but usually GeneratedPluginRegistrant handles it.
// Actually flutter_fire plugins often auto-register, but proper setup for iOS 10+ sometimes needs more.
// For standard FlutterFire, just the code below is mostly enough, but we should ensure capabilities are on.

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
