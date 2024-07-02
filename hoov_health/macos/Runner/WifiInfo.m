// WifiInfo.m

#import "WifiInfo.h"
#import <CoreWLAN/CoreWLAN.h>

NSDictionary* getWifiInfo(void) {

    CWInterface *wifiInterface = [CWWiFiClient sharedWiFiClient].interface;
    if (wifiInterface) {
        NSMutableDictionary *wifiInfo = [NSMutableDictionary dictionary];
        if (wifiInterface.ssid) {
            wifiInfo[@"SSID"] = wifiInterface.ssid;
        }
        if (wifiInterface.bssid) {
            wifiInfo[@"BSSID"] = wifiInterface.bssid;
        }
        wifiInfo[@"RSSI"] = @(wifiInterface.rssiValue);
        wifiInfo[@"Noise_Level"] = @(wifiInterface.noiseMeasurement);
        wifiInfo[@"Transmit_Rate"] = @(wifiInterface.transmitRate);
        wifiInfo[@"Security"] = securityTypeString(wifiInterface.security);
        CWChannel *channel = wifiInterface.wlanChannel;
        if (channel) {
            wifiInfo[@"Channel"] = @(channel.channelNumber);
            wifiInfo[@"Channel_Width"] = @(channel.channelWidth);
            wifiInfo[@"Channel_Band"] = @(channel.channelBand);
        }
        return wifiInfo;
       

    }else{
        NSLog(@"WiFi Interface not found or not available.");
        NSError *error = [NSError errorWithDomain:@"YourDomain.WifiInfoError" code:1 userInfo:@{ NSLocalizedDescriptionKey : @"WiFi Interface not found or not available." }];
        NSLog(@"Error: %@", error);
        return nil;
    }
    return nil;
}


NSString* securityTypeString(CWSecurity security) {
    switch (security) {
        case kCWSecurityNone: return @"None";
        case kCWSecurityWEP: return @"WEP";
        case kCWSecurityWPAPersonal: return @"WPA Personal";
        case kCWSecurityWPAPersonalMixed: return @"WPA/WPA2 Personal";
        case kCWSecurityWPA2Personal: return @"WPA2 Personal";
        case kCWSecurityPersonal: return @"Personal";
        case kCWSecurityDynamicWEP: return @"Dynamic WEP";
        case kCWSecurityWPAEnterprise: return @"WPA Enterprise";
        case kCWSecurityWPAEnterpriseMixed: return @"WPA/WPA2 Enterprise";
        case kCWSecurityWPA2Enterprise: return @"WPA2 Enterprise";
        case kCWSecurityEnterprise: return @"Enterprise";
        case kCWSecurityWPA3Personal: return @"WPA3 Personal";
        case kCWSecurityWPA3Enterprise: return @"WPA3 Enterprise";
        case kCWSecurityWPA3Transition: return @"WPA3 Transition";
        case kCWSecurityOWE: return @"OWE";
        case kCWSecurityOWETransition: return @"OWE Transition";
        case kCWSecurityUnknown: return @"Unknown";
        default: return @"Unsupported Security Type";
    }
}

