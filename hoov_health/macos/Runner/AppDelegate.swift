// AppDelegate.swift

import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    override func applicationDidFinishLaunching(_ notification: Notification) {
        guard let window = mainFlutterWindow,
              let controller = window.contentViewController as? FlutterViewController else {
            return
        }

        let methodChannel = FlutterMethodChannel(name: "com.example.wifi_info", binaryMessenger: controller.engine.binaryMessenger)

        methodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "getWifiInfo" {
                let wifiInfo = getWifiInfo()
                if let wifiInfoDict = wifiInfo as NSDictionary? {
                    result(wifiInfoDict)
                } else {
                    result(FlutterError(code: "UNAVAILABLE", message: "Wi-Fi info not available", details: nil))
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    }
}
