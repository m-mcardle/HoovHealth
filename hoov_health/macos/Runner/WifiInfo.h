#ifdef __cplusplus
extern "C" {
#endif

#import <Foundation/Foundation.h>
#import <CoreWLAN/CoreWLAN.h>

NSDictionary* getWifiInfo(void);
NSString* securityTypeString(CWSecurity security);

#ifdef __cplusplus
}
#endif
