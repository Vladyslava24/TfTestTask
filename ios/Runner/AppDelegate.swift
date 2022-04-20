import UIKit
import Flutter
import Firebase
import AdSupport
import StoreKit
import FBSDKCoreKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    private let SHARE_CHANNEL = "channel:com.totalfit.mobile/share";
    
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        ///
        FirebaseApp.configure()
        ///
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let shareChannel = FlutterMethodChannel(name: SHARE_CHANNEL, binaryMessenger: controller.binaryMessenger)
        shareChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            if(call.method == "shareFile") {
                let imagePath = call.arguments as! String
                let image = UIImage(contentsOfFile: imagePath)

                let activityItems = [ image! ]

                let activityViewController = UIActivityViewController(activityItems: activityItems , applicationActivities: nil)
                   activityViewController.popoverPresentationController?.sourceView = controller.view
                controller.present(activityViewController, animated: true, completion: nil)
                
                activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
                    print(success ? "NATIVE SHARE SUCCESS!" : "NATIVE SHARE FAILURE");
                    result(success);
                }
            }
            
        })


        GeneratedPluginRegistrant.register(with: self)
        
        if #available(iOS 10.0, *) {
             UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
           }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}