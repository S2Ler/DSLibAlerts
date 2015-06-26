
@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@protocol DSAlertView;
@class DSAlert;
@protocol DSAlertViewDelegate;


@interface DSAlertViewFactory: NSObject
/** Don't forget to set delegate */
+ (id<DSAlertView>)modalAlertViewWithAlert:(DSAlert *)theAlert
                                  delegate:(nullable id<DSAlertViewDelegate>)theDelegate;
@end

NS_ASSUME_NONNULL_END