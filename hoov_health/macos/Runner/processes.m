#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import <mach/mach.h>
#import <libproc.h>
#import <Security/Security.h>

// Function prototype for CPU usage calculation
float cpu_usage_for_pid(pid_t pid);

// Function to get process information
NSDictionary* getProcessInfo(void);

// Function to get CPU usage for a specific process ID
float cpu_usage_for_pid(pid_t pid) {
    struct proc_taskinfo taskInfo;
    int result = proc_pidinfo(pid, PROC_PIDTASKINFO, 0, &taskInfo, sizeof(taskInfo));
    
    if (result <= 0) {
        return -1;
    }
    
    return (taskInfo.pti_total_user + taskInfo.pti_total_system) / (float)TH_USAGE_SCALE * 100.0;
}

NSDictionary* getProcessInfo(void) {
    @autoreleasepool {
        NSMutableArray *appsArray = [NSMutableArray array];
        NSWorkspace *workspace = [NSWorkspace sharedWorkspace];
        NSArray<NSRunningApplication *> *runningApplications = [workspace runningApplications];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        NSUInteger limit = MIN(30, [runningApplications count]);
        
        for (NSUInteger i = 0; i < limit; i++) {
            NSRunningApplication *app = [runningApplications objectAtIndex:i];
            NSMutableDictionary *appInfo = [NSMutableDictionary dictionary];
            appInfo[@"pid"] = @(app.processIdentifier);
            appInfo[@"bundle_identifier"] = app.bundleIdentifier ? app.bundleIdentifier : @"";
            appInfo[@"localized_name"] = app.localizedName ? app.localizedName : @"";
            appInfo[@"executable_path"] = app.executableURL ? [app.executableURL path] : @"";
            if (app.launchDate) {
                NSString *launchDateString = [dateFormatter stringFromDate:app.launchDate];
                appInfo[@"launch_date"] = launchDateString;
            } else {
                appInfo[@"launch_date"] = @"";
            }
            appInfo[@"is_active"] = @(app.isActive);
            float cpuUsage = cpu_usage_for_pid(app.processIdentifier);
            appInfo[@"cpu_usage"] = @(cpuUsage);
            
            NSImage *icon = [app icon];
            NSData *iconData = [icon TIFFRepresentation];
            if (iconData) {
                NSString *iconFileName = [NSString stringWithFormat:@"%@.tiff", app.localizedName];
                NSString *iconFilePath = [NSString stringWithFormat:@"json_files/icons/%@", iconFileName];
                [iconData writeToFile:iconFilePath atomically:YES];
                appInfo[@"icon_path"] = iconFilePath;
            } else {
                appInfo[@"icon_path"] = @"";
            }
            
            [appsArray addObject:appInfo];
        }
        
        // Prepare the result dictionary
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        result[@"processes"] = appsArray;
        
        return result;
    }
}
