import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    if let controller = window?.rootViewController as? FlutterViewController {
      registerAppLocaleChannel(controller.binaryMessenger)
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  /// Keeps the per-app language (Settings › TrackFollows › Language) in step
  /// with the language picked inside the app. iOS stores it as AppleLanguages
  /// in the app's own defaults domain and relaunches the app when it changes.
  private func registerAppLocaleChannel(_ messenger: FlutterBinaryMessenger) {
    let channel = FlutterMethodChannel(name: "trackfollows/app_locale", binaryMessenger: messenger)
    channel.setMethodCallHandler { call, result in
      let defaults = UserDefaults.standard
      let key = "AppleLanguages"
      switch call.method {
      case "get":
        // Only the app's own domain: the global domain holds the device list.
        let domain = Bundle.main.bundleIdentifier.flatMap { defaults.persistentDomain(forName: $0) }
        result((domain?[key] as? [String])?.first)
      case "set":
        if let code = call.arguments as? String {
          defaults.set([code], forKey: key)
        } else {
          defaults.removeObject(forKey: key)
        }
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }
}
