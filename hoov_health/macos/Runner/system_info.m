// system_info.m

#import "system_info.h"
#import <Foundation/Foundation.h>
#include <sys/utsname.h>

NSDictionary* getSystemInfo(void) {
    @autoreleasepool {
        // Declare uname_buf variable
        struct utsname uname_buf;
        
        // Prepare the result dictionary
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        result[@"platform"] = @"darwin";
        result[@"platform_like"] = @"darwin";

        // Gather system information

        // Hostname
        NSString *hostname = [[NSHost currentHost] localizedName];
        if (hostname) {
            result[@"hostname"] = hostname;
        }

        // System Uptime
        NSTimeInterval uptime = [[NSProcessInfo processInfo] systemUptime];
        result[@"uptime"] = @(uptime);

        // Memory Information
        NSProcessInfo *processInfo = [NSProcessInfo processInfo];
        result[@"physical_memory"] = @(processInfo.physicalMemory);

        // Processor Information
        if (uname(&uname_buf) == 0) {
            NSString *processorType = [NSString stringWithUTF8String:uname_buf.machine];
            if (processorType) {
                result[@"processor_type"] = processorType;
            }
        } else {
            NSLog(@"Failed to determine the processor type");
        }

        // Path to the SystemVersion.plist file
        NSString *systemVersionPath = @"/System/Library/CoreServices/SystemVersion.plist";

        // Load the contents of the plist into a dictionary
        NSDictionary *versionDict = [NSDictionary dictionaryWithContentsOfFile:systemVersionPath];

        if (!versionDict) {
            NSLog(@"Failed to read system version information");
        } else {
            // Determine architecture
            if (uname(&uname_buf) == 0) {
                result[@"arch"] = [NSString stringWithUTF8String:uname_buf.machine];
            } else {
                NSLog(@"Failed to determine the OS architecture, error %d", errno);
            }

            // Extract version information from the plist
            NSString *productName = versionDict[@"ProductName"];
            NSString *productVersion = versionDict[@"ProductVersion"];
            NSString *productBuildVersion = versionDict[@"ProductBuildVersion"];

            if (productName) {
                result[@"name"] = productName;
            }
            if (productVersion) {
                result[@"version"] = productVersion;

                // Break out version parts
                NSArray *versionComponents = [productVersion componentsSeparatedByString:@"."];
                if (versionComponents.count > 0) {
                    result[@"major"] = @([versionComponents[0] integerValue]);
                }
                if (versionComponents.count > 1) {
                    result[@"minor"] = @([versionComponents[1] integerValue]);
                }
                if (versionComponents.count > 2) {
                    result[@"patch"] = @([versionComponents[2] integerValue]);
                }
            }
            if (productBuildVersion) {
                result[@"build"] = productBuildVersion;
            }
        }

        return result;
    }
}
