
@import Foundation;
#import "DSAlertViewDelegate.h"

@class DSAlert;
@class DSReachability;
@class DSAlertsQueue;

@interface DSAlertsHandler: NSObject<DSAlertViewDelegate>

@property (nonatomic, weak, nullable) DSReachability *reachability;
@property (nonatomic, strong, nullable) NSArray *filterOutMessages;

+ (nonnull instancetype)sharedInstance;

- (void)showAlert:(nullable DSAlert *)theAlert modally:(BOOL)isModalAlert;

- (nonnull DSAlertsQueue *)detachAlertsQueue;

@end
