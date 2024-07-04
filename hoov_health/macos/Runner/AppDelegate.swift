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

        let wifiMethodChannel = FlutterMethodChannel(name: "com.example.wifi_info", binaryMessenger: controller.engine.binaryMessenger)
        let systemMethodChannel = FlutterMethodChannel(name: "com.example.system_info", binaryMessenger: controller.engine.binaryMessenger)
        let processMethodChannel = FlutterMethodChannel(name: "com.example.process_info", binaryMessenger: controller.engine.binaryMessenger)

        wifiMethodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
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

        systemMethodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "getSystemInfo" {
                let systemInfo = getSystemInfo()
                if let systemInfoDict = systemInfo as NSDictionary? {
                    result(systemInfoDict)
                } else {
                    result(FlutterError(code: "UNAVAILABLE", message: "System info not available", details: nil))
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        processMethodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "getProcessInfo" {
                if let processInfoDict = getProcessInfo() as NSDictionary? {
                    result(processInfoDict)
                } else {
                    result(FlutterError(code: "UNAVAILABLE", message: "Process info not available", details: nil))
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    }
}
