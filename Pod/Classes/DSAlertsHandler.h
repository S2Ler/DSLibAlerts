
@import Foundation;
#import "DSAlertViewDelegate.h"

@class DSAlert;
@class DSReachability;
@class DSAlertsQueue;

#ifndef DSAlertsHandler_SHOW_NO_INTERNET_CONNECTION_POPUPS_ONCE
  #define DSAlertsHandler_SHOW_NO_INTERNET_CONNECTION_POPUPS_ONCE 1
#endif

@interface DSAlertsHandler: NSObject<DSAlertViewDelegate>

@property (nonatomic, weak, nullable) DSReachability *reachability;
@property (nonatomic, strong, nullable) NSArray *filterOutMessages;

+ (nonnull instancetype)sharedInstance;

- (void)showAlert:(nullable DSAlert *)theAlert modally:(BOOL)isModalAlert;

- (nonnull DSAlertsQueue *)detachAlertsQueue;

@end
