
@import Foundation;
#import "DSAlertViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@class DSAlert;
@class DSReachability;
@class DSAlertsQueue;

@interface DSAlertsHandler: NSObject<DSAlertViewDelegate>

@property (nonatomic, weak, nullable) DSReachability *reachability;
@property (nonatomic, strong, nullable) NSArray *filterOutMessages;

+ (instancetype)sharedInstance;

- (void)showAlert:(nullable DSAlert *)theAlert modally:(BOOL)isModalAlert;

- (DSAlertsQueue *)detachAlertsQueue;

@end

NS_ASSUME_NONNULL_END
