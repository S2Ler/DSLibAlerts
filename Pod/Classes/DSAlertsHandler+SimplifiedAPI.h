
@import Foundation;
#import <DSLibAlerts/DSAlertsHandler.h>

@class DSMessage;


@protocol DSAlertsHandlerSimplifiedAPIDelegate <NSObject>
/**
 @return you may return nil, then default alert will be created.
 */
- (nullable DSAlert *)customAlertForGeneralError:(nonnull DSMessage *)generalErrorMessage;

@optional
- (nullable DSAlert *)customAlertMessage:(nonnull DSMessage *)message;
@end

@interface DSAlertsHandler (SimplifiedAPI)
- (void)setSimpleAPIDelegate:(nonnull id<DSAlertsHandlerSimplifiedAPIDelegate>)simplifiedAPIDelegate;
- (void)showSimpleMessageAlert:(nullable DSMessage *)theMessage NS_SWIFT_NAME(show(_:));
- (void)showError:(nullable NSError *)error NS_SWIFT_NAME(show(_:));
- (void)showParseError:(nullable NSError *)error;
- (void)showUnknownError;
@end
